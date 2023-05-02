import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/create/create_page.dart';
import 'package:instagram_clone/detail_post/detail_post_page.dart';
import 'package:instagram_clone/tab/search/search_model.dart';

import '../../domain/post.dart';

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
    final model = SearchModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: StreamBuilder<QuerySnapshot<Post>>(
            stream: model.postsStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('알 수 없는 에러');
                //에러처리용
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              List<Post> posts =
                  snapshot.data!.docs.map((e) => e.data()).toList();
              //data!안에 <QuerySnapshot<Post>>라는게 들어있고 그걸 docs로 접근하면
              //List로 접근이되고 그안에서 map형태로 돌면서 QueryDocumentSnapshot<Post>의 정보를 갖고있고
              //그 Post에 data()로 접근을하고 그데이터를 리스트로만들어서 posts에 저장

              return GridView.builder(
                itemCount: posts.length,
                //그리드 내부의 카운트가 없으면 계속생성되므로 posts리스트의 개수만큼 출력
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //그리드 열의 개수
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
                //그리드의 열을 3열로 만들어줌
                itemBuilder: (BuildContext context, int index) {
                  final post = posts[index]; //posts의 인덱스를 가져와서 post에 넣어준다
                  return GestureDetector(
                    //서치 페이지에있는 사진을 클릭했을때
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPostPage(post: post)),
                      );
                    },
                    child: Hero(
                      //Hero위젯으로 사진 클릭했을때 애니메이션적용가능, 클릭했을때 나오는 사진에도 똑같이 Hero해주면된다
                      tag: post.id,
                      child: Image.network(
                        post.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }),
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
