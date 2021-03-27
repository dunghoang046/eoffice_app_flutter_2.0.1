class LoginModel {
  String userName;
  String password;
  String lang;
  bool checkFingerprint;
  LoginModel({
    this.userName,
    this.password,
    this.lang,
    this.checkFingerprint,
  });

  LoginModel.fromMap(Map<String, dynamic> map) {
    userName = map['userName'];
    password = map['password'];
    lang = map['lang'];
    checkFingerprint = map['checkFingerprint'];
  }
}
