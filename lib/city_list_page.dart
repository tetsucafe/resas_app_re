import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:resas_app/city.dart';
import 'env.dart';

import 'city_detail_page.dart';
import 'package:http/http.dart' as http;

class CityListPage extends StatefulWidget {
  const CityListPage({
    super.key,
  });

  @override
  State<CityListPage> createState() => _CityListPageState();
}

class _CityListPageState extends State<CityListPage> {
  late Future<String> _future;

  // 画面を開いたときの処理
  @override
  void initState() {
    super.initState();
    const host = 'opendata.resas-portal.go.jp';
    const endopoint = 'api/v1/cities';
    final headers = {'X-API-KEY': Env.resasApiKey};
    _future = http
        .get(Uri.https(host, endopoint), headers: headers)
        .then((res) => res.body);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: FutureBuilder<String>(
          future: _future,
          builder: (context, snapshot) { //snapshotには、非同期処理の字状態やデータが入っている
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final json = jsonDecode(snapshot.data!)['result'] as List;
            final items = json.cast<Map<String, dynamic>>();
            final cities = items
              .map((item) => City.fromJson(item)).toList();
            //パフォーマンスを高めるため、ListView.builderを使う（使わないと、全てのデータをメモリに読み込む）
            return ListView.separated(
              itemCount: cities.length,
              itemBuilder: (context, index){
                final city = cities[index];
                return ListTile(
                    title: Text(city.cityName),
                    subtitle: Text(city.cityType.label), // This is fine as it's a constant string
                    trailing: const Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CityDetailPage(
                            city: city,
                          ),
                        ),
                      );
                    },
                );
              }, 
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }
      ),
    );
  }
} 
