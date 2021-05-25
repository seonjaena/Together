import 'package:flutter/material.dart';
import 'package:together/page/after_project/project_schedule_page.dart';

class ProjectMainPage extends StatefulWidget {
  @override
  _ProjectMainPageState createState() => _ProjectMainPageState();
}

class _ProjectMainPageState extends State<ProjectMainPage> {
  final List<Widget> _children = [
    ProjectSchedulePage(),
    ProjectSchedulePage(),
    ProjectSchedulePage(),
    ProjectSchedulePage(),
  ];
  int _selectedSeiviceIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedSeiviceIndex],
      bottomNavigationBar: bottomBar(),
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      currentIndex: _selectedSeiviceIndex,
      onTap: (int index) {
        setState(() {
          _selectedSeiviceIndex = index;
        });
      },
      items: [
        // BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
        BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined), label: "일정"),
        BottomNavigationBarItem(icon: Icon(Icons.file_copy), label: "파일"),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "채팅"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "마이"),
      ],
    );
  }
}
