import 'package:flutter/material.dart';
import 'package:together/model/user.dart';
import 'package:together/page/after_login/success_login_page.dart';

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
                    buildEmailFormField(),
                    buildPasswordFormField(),
                  ],
                ),
              ),
              SizedBox(height: height * 0.128),
              Container(
                width: width * 0.7,
                height: height * 0.076,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var log = {
                        "user_email": emailController.text,
                        "user_pw": passwordController.text
                      };
                      // 1. http url 연결하고 json 형식 post메소드 전송
                      // 2. mysql User 테이블에서 user_email과 user_pw 비교
                      // 3. 있을경우 return true 아닐경우 false(아이디 문제인지 비밀번호 문제인지 경고)
                      // 위 과정  Future 함수로 만들어야함

                      var testResult = false;
                      if (emailController.text == example.email &&
                          passwordController.text != example.password) {
                        testResult = false;
                        print('password error!'); //alertDialog 추가
                      } else if (emailController.text != example.email) {
                        testResult = false;
                        print("don 't exist email! ");
                      } else {
                        testResult = true;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SuccessLoginPage()));
                      }
                    }
                  },
                  child: Text(
                    '로그인',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.012,
              ),
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
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => SignUp()));
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

  Container buildEmailFormField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'E-mail',
          prefixIcon: Icon(Icons.email),
        ),
        controller: emailController,
        validator: (email) {
          if (email!.isEmpty) {
            return 'E-mail 을 입력하세요';
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  Container buildPasswordFormField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'password',
          prefixIcon: Icon(Icons.lock),
        ),
        controller: passwordController,
        validator: (email) {
          if (email!.isEmpty) {
            return 'password 을 입력하세요';
          } else {
            return null;
          }
        },
        obscureText: true,
      ),
    );
  }
}
