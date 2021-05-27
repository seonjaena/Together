import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:together/data.dart';

class SignUpEmailForm extends StatefulWidget {
  @override
  _SignUpEmailFormState createState() => _SignUpEmailFormState();
}

class _SignUpEmailFormState extends State<SignUpEmailForm> {
  final _emailformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String selectedValue = '선택하세요';
  final validEmail = RegExp(r'^[a-zA-Z0-9]+$');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // 메일 형식이 옳바를  경우
                  // post 메소드 사용해서 이메일 중복 확인
                  // flag 따라 메시지 전송
                },
                child: Text('중복 확인'),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.5,
                height: height * 0.1,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  key: _emailformKey,
                  controller: emailController,
                  decoration: InputDecoration(
                    errorMaxLines: 1,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) {
                    if (email!.isEmpty) {
                      return "이메일을 입력하세요";
                    }
                    if (!validEmail.hasMatch(email)) {
                      //특수기호 포함 x
                      return "이메일을 올바르게 입력해주세요.";
                    }
                  },
                ),
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Expanded(
                child: Container(
                  height: height * 0.1,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(3)),
                  child: Center(
                    child: DropdownButton(
                      value: selectedValue,
                      items: emailList.map(
                        (value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value.toString();
                        });
                      },
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
