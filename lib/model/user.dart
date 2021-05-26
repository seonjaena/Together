class User {
  String email;
  String password;
  String name;
  String phone;
  String nickname;
  String birthday; // 디비 설계 TimeStamp type
  int age;
  String mbti;
  String license1;
  String license2;
  String license3;

  User(
      {required this.email,
      required this.password,
      required this.name,
      required this.phone,
      required this.nickname,
      required this.birthday,
      required this.age,
      this.mbti = '',
      this.license1 = '',
      this.license2 = '',
      this.license3 = ''});

// 데이터 json 형식으로 가져올때
  User.fromJson(Map<String, dynamic> json)
      : email = json['user_email'],
        password = json['user_pw'],
        name = json['user_name'],
        phone = json['user_phone'],
        nickname = json['user_nickname'],
        birthday = json['user_birth'],
        age = json['user_age'],
        mbti = json['user_mbti'],
        license1 = json['user_license1'],
        license2 = json['user_license2'],
        license3 = json['user_license3'];

//데이터 json 형식으로 보낼때
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email'] = this.email;
    data['user_pw'] = this.password;
    data['user_name'] = this.name;
    data['user_phone'] = this.phone;
    data['user_nickname'] = this.nickname;
    data['user_birth'] = this.birthday;
    data['user_age'] = this.age;

    return data;
  }

  Map<String, dynamic> login() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_email'] = this.email;
    data['user_pw'] = this.password;
    return data;
  }
}

User example = User(
    email: "abc@naver.com",
    password: "1234",
    name: "박수빈",
    phone: "010-9663-6696",
    nickname: "bymine",
    birthday: DateTime(1997, 7, 23).toIso8601String(),
    age: 25);
