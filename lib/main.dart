import 'package:flutter/material.dart';
import 'package:together/page/login/sign_in_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Together',
      theme: ThemeData(primaryColor: Colors.green[400]),
      home: SignInPage(),
    );
  }
}
