import 'package:firebase_auth/firebase_auth.dart';

class AccountModel {
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
