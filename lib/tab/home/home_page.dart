import 'package:flutter/material.dart';
import 'package:instagram_clone/tab/home/home_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = HomeModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //컬럼은 수직방향이고 가로방향으로 중앙정렬하기때문에
          children: [
            const SizedBox(height: 20),
            const Text(
              'Instagram에 오신것을 환영합니다.',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text('사진과 동영상을 보려면 팔로우 하세요'),
            const SizedBox(height: 20),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(model.getProfileImageUrl()),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.getEmail(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(model.getNickName()),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      //로우는 기본적으로 화면을 가득 채우기때문에 크기를 줄여줌
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://dimg.donga.com/wps/NEWS/IMAGE/2022/08/17/114998051.2.jpg',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ), //박스를 가득 채우는 효과
                        const SizedBox(width: 4),
                        Image.network(
                          'https://dimg.donga.com/wps/NEWS/IMAGE/2022/08/17/114998051.2.jpg',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 4),
                        Image.network(
                          'https://dimg.donga.com/wps/NEWS/IMAGE/2022/08/17/114998051.2.jpg',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 8),
                    const Text('Facebook 친구'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('팔로우'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
