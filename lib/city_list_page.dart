import 'package:flutter/material.dart';
import 'package:resas_app/city_detail_page.dart';

class CityListPage extends StatelessWidget {
  const CityListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    const cities = [
      '札幌市', 
      '横浜市', 
      '川崎市', 
      '新潟市',
      '大阪市',
      '名古屋市',
      '京都市',
      '福岡市',
      '岡山市',
      '北九州市',
      '長崎市',
      '大分市',
      '熊本市',
      ]; 

    return Scaffold(
      appBar: AppBar(
        title: const Text('市区町村一覧'),
      ),
      body: ListView(
        children: [
          for (final city in cities)
            ListTile(
              title: Text(city),
              subtitle: const Text('政令指定都市'),
              trailing: const Icon(Icons.navigate_next),
              onTap: () {
                // 選択した市区町村の詳細画面へ遷移
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CityDetailPage(city: city),
                  ),
                );
              },
          )
        ],
      ),
    );
  }
}

