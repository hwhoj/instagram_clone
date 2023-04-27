import 'package:flutter/material.dart';
import 'package:instagram_clone/create/create_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  final List<String> _urls = const [
    'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202111/30/4b59d179-deb8-456c-9bc6-d2402ef775f1.jpg',
    'https://img.sbs.co.kr/newimg/news/201110/200511052_1280.jpg',
    'https://dimg.donga.com/wps/NEWS/IMAGE/2021/10/26/109917755.1.jpg',
    'https://img.hankyung.com/photo/202103/01.25558607.1.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GridView.builder(
          itemCount: _urls.length, //그리드 내부의 카운트가 없으면 계속생성되므로 url리스트의 개수만큼 출력
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //그리드 열의 개수
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
          ),
          //그리드의 열을 3열로 만들어줌
          itemBuilder: (BuildContext context, int index) {
            final url = _urls[index]; //_url의 인덱스를 가져와서 url을 넣어준다
            return Image.network(
              url,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePage()),
          );
        },
        child: const Icon(Icons.create),
      ),
    );
  }
}
