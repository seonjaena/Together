import 'package:flutter/material.dart';
import 'package:together/page/after_login/finding_member_page.dart';
import 'package:together/page/after_login/finding_project_page.dart';
import 'package:together/page/after_login/making_project_page.dart';
import 'package:together/page/after_login/myinfo_page.dart';
import 'package:together/page/after_login/ongoing_project_page.dart';

class SuccessLoginPage extends StatefulWidget {
  @override
  _SuccessLoginPageState createState() => _SuccessLoginPageState();
}

class _SuccessLoginPageState extends State<SuccessLoginPage> {
  int _selectedMenuIndex = 0;
  final List<Widget> _children = [
    OnGoingPage(),
    MakingProjectPage(),
    FindProjectPage(),
    FindMemberPage(),
    MyInfoPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Together'),
      ),
      body: _children[_selectedMenuIndex],
      bottomNavigationBar: bottomBar(),
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      currentIndex: _selectedMenuIndex,
      onTap: (int index) {
        setState(() {
          _selectedMenuIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "생성"),
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_sharp), label: "팀 매칭"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "팀원 매칭"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이"),
      ],
    );
  }
}
