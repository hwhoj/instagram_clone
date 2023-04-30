import 'package:firebase_auth/firebase_auth.dart';

class AccountModel {
  void logout() async {
    await FirebaseAuth.instance.signOut();
    //firebasefire에서 복붙해온 로그아웃 기능
  }
}
