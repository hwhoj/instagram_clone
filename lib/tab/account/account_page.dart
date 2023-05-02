import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/tab/account/account_model.dart';

import '../../detail_post/detail_post_page.dart';
import '../../domain/post.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AccountModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Clone'),
        actions: [
          IconButton(
            onPressed: () {
              model.logout();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      //사진위에 버튼을 겹쳐놓아야 하기때문에 사진이있는 사이즈박스를 스택으로 감싸줌
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(model.getProfileImageUrl()),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.bottomRight,
                          child: const Stack(
                            //+아이콘 바깥으로 흰색바탕을 만들어주기위한 스택
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 28,
                                height: 28,
                                child: FloatingActionButton(
                                  onPressed: null,
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 25,
                                height: 25,
                                child: FloatingActionButton(
                                  onPressed: null,
                                  child: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.getNickName(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text(
                      '3',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '게시물',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '팔로워',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const Column(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '팔로잉',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              //나머지영역만큼 꽉채운 공간을 만듬
              child: Padding(
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
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, //그리드 열의 개수
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 2.0,
                        ),
                        //그리드의 열을 3열로 만들어줌
                        itemBuilder: (BuildContext context, int index) {
                          final post =
                              posts[index]; //posts의 인덱스를 가져와서 post에 넣어준다
                          return GestureDetector(
                            //서치 페이지에있는 사진을 클릭했을때
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPostPage(post: post)),
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
            ),
          ],
        ),
      ),
    );
  }
}
