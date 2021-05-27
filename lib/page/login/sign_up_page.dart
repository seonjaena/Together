import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:together/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:together/widget/email_form.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _selectedValue = '선택하세요';
  final emailList = ['선택하세요', 'naver.com', 'hanmail.net'];
  final _formKey = GlobalKey<FormState>();
  final _emailformKey = GlobalKey<FormState>();
  final _nicknameformKey = GlobalKey<FormState>();

  int nicknameCheckFlag = 0; // 0 일경우 중복확인 체크하세요  1일경우 사용가능 2 이미 존재하는 아이디

  final nameController = TextEditingController();
  final nicknameController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final yearController = TextEditingController(text: "1997");
  final monthController = TextEditingController(text: "7");
  final dayController = TextEditingController(text: "23");
  DateTime birth = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  '회원가입',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height * 0.048,
                ),
                SignUpEmailForm(),
                buildHearderChek(
                  header: "비밀번호",
                  subtitle: "8~16자 영문, 숫자 특수기호를 입력하시요",
                  child: buildPwForm("비밀번호", passwordController, true),
                ),
                buildHearder(
                  header: "비밀번호 확인",
                  child: buildRePwForm("비밀번호", repasswordController, true),
                ),
                buildHearder(
                  header: "이름",
                  child: buildFormField("이름", nameController, false),
                ),
                buildHearderDupCheck(
                  //중복확인
                  header: "닉네임",
                  dupChecker: ElevatedButton(
                      onPressed: () async {
                        if (nicknameController.text == "bymine") {
                          //
                          setState(() {
                            nicknameCheckFlag = 2;
                          });
                        } else {
                          setState(() {
                            nicknameCheckFlag = 3;
                          });
                        }
                        print(nicknameCheckFlag);
                      },
                      child: Text("중복 확인")),
                  child: buildcheckNickname("닉네임", nicknameController, false),
                ),
                buildHearderDupCheck(
                  //중복확인
                  header: "휴대전화",
                  dupChecker:
                      ElevatedButton(onPressed: () {}, child: Text("중복 확인")),
                  child: buildFormField("휴대전화", phoneController, false),
                ),
                buildSignUpButton(width, height, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildFormField(
      String form, TextEditingController controller, bool visible) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          if (text!.isEmpty) {
            return '${form}를 입력하세요';
          } else {
            return null;
          }
        },
        obscureText: visible,
      ),
    );
  }

  Container buildPwForm(
      String form, TextEditingController controller, bool visible) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          if (text!.isEmpty) {
            return "비밀번호를 입력하세요.";
          }
          if (text.length < 8) {
            return '8자 이상 입력해 주세요';
          } else {
            return null;
          }
        },
        obscureText: visible,
      ),
    );
  }

  Container buildRePwForm(
      String form, TextEditingController controller, bool visible) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (text) {
          if (text!.isEmpty) {
            return "비밀번호를 입력하세요.";
          }
          print(passwordController.text);
          if (text != passwordController.text) {
            return '비밀번호가 일치하지 않습니다. 다시 입력하세요.';
          } else {
            return null;
          }
        },
        obscureText: visible,
      ),
    );
  }

  Container buildcheckNickname(
      String form, TextEditingController controller, bool visible) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: Icon(
            Icons.check,
            color: nicknameCheckFlag == 3 ? Colors.green : Colors.red,
          ),
        ),
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (text) {
          nicknameCheckFlag = 0;
        },
        validator: (text) {
          if (text!.isNotEmpty && nicknameCheckFlag == 1) {
            nicknameCheckFlag = 3;
            return "사용가능한 닉네임입니다.";
          } else if (text.isNotEmpty && nicknameCheckFlag == 2) {
            return "이미 사용중이거나 탈퇴한 닉네임입니다.";
          } else if (text.isNotEmpty && nicknameCheckFlag == 0) {
            return "중복 체크하시오.";
          } else if (text.isNotEmpty && nicknameCheckFlag == 3) {
            return null;
          } else
            return "닉네임을 입력하세요";
        },
        obscureText: visible,
      ),
    );
  }

  Widget buildHearder({
    required String header,
    required Widget child,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            child
          ],
        ),
      );
  Widget buildHearderChek({
    required String header,
    required String subtitle,
    required Widget child,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  header,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(subtitle),
              ],
            ),
            child
          ],
        ),
      );

  Widget buildHearderDupCheck({
    required String header,
    required Widget dupChecker,
    required Widget child,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  header,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                dupChecker,
              ],
            ),
            child
          ],
        ),
      );
  Container buildSignUpButton(
      double width, double height, BuildContext context) {
    return Container(
      width: width * 0.7,
      height: height * 0.076,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            Navigator.of(context).pop();
          }
        },
        child: Text(
          '가입하기',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
