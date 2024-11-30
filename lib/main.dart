import 'package:flutter/material.dart';
import 'package:resas_app/city_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RESAS_APP',
      home: CityListPage(),
    );
  }
}
