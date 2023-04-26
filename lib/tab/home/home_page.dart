import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
      ),
      body: const Column(
        children: [
          Text('Instagram에 오신것을 환영합니다.'),
        ],
      ),
    );
  }
}
