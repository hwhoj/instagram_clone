import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:instagram_clone/tab/account/account_page.dart';
import 'package:instagram_clone/tab/home/home_page.dart';
import 'package:instagram_clone/tab/search/search_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;

  final _pages = const [
    HomePage(),
    SearchPage(),
    AccountPage(),
    ProfileScreen(
      //바텀네비아이콭중에 선택할수있는 프로필화면
      providerConfigs: [
        EmailProviderConfiguration(),
        //flutterfire에서 복붙해온 이메일인증 기능
      ],
      avatarSize: 24, //사진크기
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //바텀네비바 아이콘이 4개가 넘어가서 아무것도안나올때 이 코드를써줌
        currentIndex: _currentIndex, //바텀네비바 기본속성 > 현재선택한 인덱스를 표시해줌
        onTap: (index) {
          //탭했을때 탭한 인덱스를 int형태로 불러옴
          setState(() {
            //화면갱신 = setState
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
