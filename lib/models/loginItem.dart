class LoginItem {
  String userName;
  String password;
  String checkFingerprint;
  String lang;
  LoginItem({this.userName, this.password, this.lang, this.checkFingerprint});
  LoginItem.fromMap(Map<String, dynamic> map) {
    userName = map['userName'];
    password = map['password'];
    checkFingerprint = map['checkFingerprint'];
    lang = map['lang'];
  }

  factory LoginItem.fromJson(Map<String, dynamic> json) {
    return LoginItem(
      userName: json['userName'],
      password: json['password'],
      checkFingerprint: json['checkFingerprint'],
      lang: json['lang'],
    );
  }
}
