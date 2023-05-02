import 'dart:io';

import 'package:flutter/material.dart';
import 'package:instagram_clone/create/create_model.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final model = CreateModel();
  final _titleTextController = TextEditingController();
  File? _image; //null을 허용해주기위해서(처음에 사진이없는상태이니까) ?를 붙여줌

  bool _isLoading = false;

  @override
  void dispose() {
    _titleTextController.dispose();
    //뭔솔?
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('새 게시물'),
        actions: [
          IconButton(
            onPressed: () async {
              if (_image != null && _titleTextController.text.isNotEmpty) {
                setState(() {
                  _isLoading = true;
                });
                await model.uploadPost(
                  _titleTextController.text,
                  _image!,
                );

                setState(() {
                  _isLoading = false;
                });

                if (mounted) {
                  //mounted > async는 오래걸리는건데 만약 Navigator.pop(context);
                  //화면까지 살아있다면 아래 코드를 실행하고 살아있지않다면 패스
                  Navigator.pop(context);
                  //비동기(async) 코드 내부에서 context를 쓰면 노란불뜸
                }
              }
            },
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
                controller: _titleTextController,
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
              if(_isLoading) const CircularProgressIndicator(),
              ElevatedButton(
                onPressed: () async {
                  //이미지 피커 실행(라이브러리 추가 필요)
                  _image = await model
                      .getImage(); //Future 타입을 받아오는거기때문에 await, async 써줌
                  setState(() {
                    //화면갱신
                  });
                },
                child: const Text('이미지 선택'),
              ),
              if (_image != null)
                Image.file(
                  _image!, //_image는 변수선언에서 File?로 선언했기때문에 타입맞춰줘야함
                  width: 300,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
