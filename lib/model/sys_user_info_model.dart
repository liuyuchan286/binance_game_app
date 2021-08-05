/// userId : 1
/// username : "admin"
/// password : "c86405b934710ed8f2638197bb160b809c6c3ada39a1892c5af2cc07ce4c4455"
/// salt : "YzcmCZNvbXocrsz9dm8e"
/// email : "root@renren.io"
/// mobile : "13612345678"
/// status : 1
/// roleIdList : [1,2,3]
/// createUserId : 1
/// createTime : "2016-11-11 11:11:11"
/// auth : false

class SysUserInfoModel {
  int _userId;
  String _username;
  String _password;
  String _salt;
  String _email;
  String _mobile;
  int _status;
  List<int> _roleIdList;
  int _createUserId;
  String _createTime;
  bool _auth;

  int get userId => _userId;
  String get username => _username;
  String get password => _password;
  String get salt => _salt;
  String get email => _email;
  String get mobile => _mobile;
  int get status => _status;
  List<int> get roleIdList => _roleIdList;
  int get createUserId => _createUserId;
  String get createTime => _createTime;
  bool get auth => _auth;

  SysUserInfoModel({
      int userId, 
      String username, 
      String password, 
      String salt, 
      String email, 
      String mobile, 
      int status, 
      List<int> roleIdList, 
      int createUserId, 
      String createTime, 
      bool auth}){
    _userId = userId;
    _username = username;
    _password = password;
    _salt = salt;
    _email = email;
    _mobile = mobile;
    _status = status;
    _roleIdList = roleIdList;
    _createUserId = createUserId;
    _createTime = createTime;
    _auth = auth;
}

  SysUserInfoModel.fromJson(dynamic json) {
    _userId = json["userId"];
    _username = json["username"];
    _password = json["password"];
    _salt = json["salt"];
    _email = json["email"];
    _mobile = json["mobile"];
    _status = json["status"];
    _roleIdList = json["roleIdList"] != null ? json["roleIdList"].cast<int>() : [];
    _createUserId = json["createUserId"];
    _createTime = json["createTime"];
    _auth = json["auth"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["userId"] = _userId;
    map["username"] = _username;
    map["password"] = _password;
    map["salt"] = _salt;
    map["email"] = _email;
    map["mobile"] = _mobile;
    map["status"] = _status;
    map["roleIdList"] = _roleIdList;
    map["createUserId"] = _createUserId;
    map["createTime"] = _createTime;
    map["auth"] = _auth;
    return map;
  }

}