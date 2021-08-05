/// username : "demoData"
/// password : "demoData"
/// captcha : "demoData"
/// uuid : "demoData"

class SysLoginDto {
  String _username;
  String _password;
  String _captcha;
  String _uuid;

  String get username => _username;
  String get password => _password;
  String get captcha => _captcha;
  String get uuid => _uuid;

  SysLoginDto({
      String username, 
      String password, 
      String captcha, 
      String uuid}){
    _username = username;
    _password = password;
    _captcha = captcha;
    _uuid = uuid;
}

  SysLoginDto.fromJson(dynamic json) {
    _username = json["username"];
    _password = json["password"];
    _captcha = json["captcha"];
    _uuid = json["uuid"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["username"] = _username;
    map["password"] = _password;
    map["captcha"] = _captcha;
    map["uuid"] = _uuid;
    return map;
  }

}