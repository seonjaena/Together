import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:together/model/auth.dart';
import 'package:together/page/after_login/success_login_page.dart';
import 'package:http/http.dart' as http;
import 'package:together/page/login/sign_up_page.dart';

class SignInPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: "abc@naver.com");
  final passwordController = TextEditingController(text: "1234");

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '로그인',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: height * 0.128),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildFormField(
                        "Email", Icon(Icons.email), emailController, false),
                    buildFormField(
                        "Password", Icon(Icons.lock), passwordController, true),
                  ],
                ),
              ),
              SizedBox(height: height * 0.128),
              buildSubmitButton(width, height, context),
              SizedBox(height: height * 0.012),
              Container(
                child: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => FindIDPW()));
                  },
                  child: Text(
                    '아이디/비밀번호 찾기',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.048,
              ),
              Container(
                padding: EdgeInsets.only(right: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SignUpPage()));
                  },
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '회원가입',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Container buildSubmitButton(
      double width, double height, BuildContext context) {
    return Container(
      width: width * 0.7,
      height: height * 0.076,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.green),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            signInUser(emailController.text, passwordController.text, context);
          }
        },
        child: Text(
          '로그인',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Container buildFormField(
      String form, Icon icon, TextEditingController controller, bool visible) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: form,
          prefixIcon: icon,
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

  void signInUser(String email, String password, BuildContext context) async {
    final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/user/login'),
        headers: {'Content-Type': "application/json"},
        body: jsonEncode({"user_email": email, "user_pw": password}));

    final idx = Auth.fromJson(json.decode(response.body)).idx;
    final code = Auth.fromJson(json.decode(response.body)).code;
    if (code == "wrong_pw") {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              codeAlertDialog(context, "비밀번호를 확인하세요!!"));
      print('password error!');
    } else if (code == "not_user") {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              codeAlertDialog(context, "이메일이 존재하지 않습니다.."));
      print("not exist email! ");
    } else if (code == "success") {
      print("user_idx : " + idx.toString());
      print("code : " + code);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SuccessLoginPage()));
    } else {
      print("some error!");
    }
  }

  AlertDialog codeAlertDialog(BuildContext context, String code) {
    return AlertDialog(
      title: Text("알림"),
      content: Text(code),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("확인"))
      ],
    );
  }
}
