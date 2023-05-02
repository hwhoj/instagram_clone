import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/post.dart';

class SearchModel {
  //게시물 데이터를 스트림으로 가지고 오는 클래스
  //flutterfire > cloud FireStore > Usage > Realtime changes

  final Stream<QuerySnapshot<Post>> postsStream = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<Post>(
        fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      )
      .snapshots();
//collection('posts')에 있는 데이터들이 postsStream라는 변수로 들어오고 그걸
//QuerySnapshot이라는 객체로 정보를 들고있겠다
//즉 'posts'에 있는 전체 데이터정보를 QuerySnapshot 형태로 가지고온다
//스트림은 데이터가 변경되면 자동으로 갱신됨
}

