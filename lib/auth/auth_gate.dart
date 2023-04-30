import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:instagram_clone/tab/tab_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      //FirebaseAuth.instance < 파이어베이스를 통해서 인증한 객체가 있다면
      //authStateChanges() < 로그인 상태에 따라 변경을 알려주는 스트림
      builder: (context, snapshot) {
        //스냅샷 안에는 유저의 정보가 들어있음(FB에서 로그인한 객체)
        // User is not signed in
        if (!snapshot.hasData) {
          //if 유저 정보의 데이터가 없다면 로그인 화면을 보여줘라
          return const SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration(),
            ],
            //flutterfire 라이브러리에서 로그인화면을 구현해줌
          );
        }

        // Render your application if authenticated
        return const TabPage();
        //유저정보 데이터가 있다면(로그인했다면) 너의 화면(tabpage화면)을 표시해라
      },
    );
  }
}
