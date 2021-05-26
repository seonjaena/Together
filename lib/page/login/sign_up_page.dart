import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:together/model/user.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: "박수빈");
  final nicknameController = TextEditingController(text: "bymine");
  final emailController = TextEditingController(text: "frfr0723@gmail.com");
  final passwordController = TextEditingController(text: "abcd1234");
  final repasswordController = TextEditingController(text: "abcd1234");
  final phoneController = TextEditingController(text: "010-9663-6696");
  final yearController = TextEditingController(text: "1997");
  final monthController = TextEditingController(text: "7");
  final dayController = TextEditingController(text: "23");
  final ageController = TextEditingController(text: "25");
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '회원가입',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: height * 0.048,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildHearder(
                      //인증 기능
                      header: "이메일",
                      child: buildFormField("이메일", emailController, false),
                    ),
                    buildHearder(
                      header: "비밀번호",
                      child: buildFormField("비밀번호", passwordController, true),
                    ),
                    buildHearder(
                      // 비밀번호 텍스트 일치할것, 영문 숫자 특수기호  길이 제한 추가
                      header: "비밀번호 재확인",
                      child: buildFormField("비밀번호", repasswordController, true),
                    ),
                    buildHearder(
                      header: "이름",
                      child: buildFormField("이름", nameController, false),
                    ),
                    buildHearder(
                      //중복확인
                      header: "닉네임",
                      child: buildFormField("닉네임", nicknameController, false),
                    ),
                    buildHearder(
                      //중복확인
                      header: "휴대전화",
                      child: buildFormField("휴대전화", phoneController, false),
                    ),
                    buildHearder(
                      header: "생년월일",
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: width * 0.3,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "년(4자)",
                                ),
                                controller: yearController,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.032,
                            ),
                            Container(
                              width: width * 0.26,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "월",
                                ),
                                controller: monthController,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.032,
                            ),
                            Container(
                              width: width * 0.26,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "일",
                                ),
                                controller: dayController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    buildHearder(
                      header: "나이",
                      child: buildFormField("나이", ageController, false),
                    ),
                  ],
                ),
              ),
              buildSignUpButton(width, height, context),
              SizedBox(
                height: height * 0.01,
              )
            ],
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

  Container buildSignUpButton(
      double width, double height, BuildContext context) {
    return Container(
      width: width * 0.7,
      height: height * 0.076,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // 가입 하기 함수 구현할것
            User user = User(
                email: emailController.text,
                password: passwordController.text,
                name: nameController.text,
                phone: phoneController.text,
                nickname: nicknameController.text,
                birthday: DateTime(
                  int.parse(yearController.text),
                  int.parse(monthController.text),
                  int.parse(dayController.text),
                ).toIso8601String(),
                age: int.parse(ageController.text));
            print(jsonEncode(user.toJson()));
            signUpUser(user);
          }
        },
        child: Text(
          '가입하기',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  void signUpUser(User user) async {
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/user/signup'),
        headers: {'Content-Type': "application/json"},
        body: jsonEncode(user.toJson()));
  }
}
