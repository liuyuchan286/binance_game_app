class SysPasswordDto {
  int t;
  String password;
  String newPassword;

  SysPasswordDto({
      this.t, 
      this.password, 
      this.newPassword});

  SysPasswordDto.fromJson(dynamic json) {
    t = json["t"];
    password = json["password"];
    newPassword = json["newPassword"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["t"] = t;
    map["password"] = password;
    map["newPassword"] = newPassword;
    return map;
  }

}