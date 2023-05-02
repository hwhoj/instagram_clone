import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/post.dart';

class AccountModel {
  final Stream<QuerySnapshot<Post>> postsStream = FirebaseFirestore.instance
      .collection('posts')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .withConverter<Post>(
        fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
        toFirestore: (post, _) => post.toJson(),
      )
      .snapshots();
      //where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      //userId가 내 userId와 동일하다면 그 값만 가져오겠다

  void logout() async {
    await FirebaseAuth.instance.signOut();
    //firebasefire에서 복붙해온 로그아웃 기능
  }

  String getNickName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? '닉네임 없음';
  }

  String getProfileImageUrl() {
    return FirebaseAuth.instance.currentUser?.photoURL ??
        'https://dimg.donga.com/wps/NEWS/IMAGE/2022/08/17/114998051.2.jpg';
  }
}
