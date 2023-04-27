import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: Padding(
        //텍스트필드가 너무 크기때문에 주변에 패딩을 줘서 줄여줌
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          //컬럼 안의 사진이 너무 클 때 스크롤을 가능하게해서 오버플로우 나는것을 방지
          child: Column(
            children: [
              TextField(
                //게시물의 제목 text를 받아옴
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    hintText: "제목을 입력하세요",
                    fillColor: Colors.white70),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('이미지 선택'),
              ),
              Image.network(
                'https://www.mangboard.com/wp-content/uploads/mangboard/2017/04/07/F816_imageupload.png',
                width: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
