class Auth {
  // changeNotifier  선언할것! provider로 idx 제공해야함
  final int idx; // var --> int 타입
  String code;

  Auth({required this.idx, required this.code});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(idx: json['user_idx'], code: json['code']);
  }
}
