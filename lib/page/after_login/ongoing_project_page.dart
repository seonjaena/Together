import 'package:flutter/material.dart';
import 'package:together/model/project.dart';
import 'package:together/page/after_project/project_main_page.dart';

class OnGoingPage extends StatefulWidget {
  @override
  _OnGoingPageState createState() => _OnGoingPageState();
}

class _OnGoingPageState extends State<OnGoingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                '참여중',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Expanded(
              child: GridView.count(
                  crossAxisCount: 2,
                  children: projects
                      .map(
                        (e) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProjectMainPage()));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: GradientTemplate
                                      .gradientTemplate[e.gradientColorIndex]
                                      .colors),
                              boxShadow: [
                                BoxShadow(
                                  color: GradientTemplate
                                      .gradientTemplate[e.gradientColorIndex]
                                      .colors
                                      .last
                                      .withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  e.name,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  e.members.toString() + "명",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
