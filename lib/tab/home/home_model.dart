import 'package:firebase_auth/firebase_auth.dart';

class HomeModel {
  String getEmail() {
    return FirebaseAuth.instance.currentUser?.email ?? '메일 없음';
    //로그인한 사용자의 정보를 알수있다
    //currentUser?.email 커런트유저는 null일수있다, email이 null일때 공백을 준다
    //커런트 유저가 널이 아니면 email을 리턴하고 어느쪽도 null이면 기본값으로 공백을준다.
  }

  String getNickName() {
    return FirebaseAuth.instance.currentUser?.displayName ?? '닉네임 없음';
  }

  String getProfileImageUrl() {
    return FirebaseAuth.instance.currentUser?.photoURL ??
        'https://dimg.donga.com/wps/NEWS/IMAGE/2022/08/17/114998051.2.jpg';
  }
}
