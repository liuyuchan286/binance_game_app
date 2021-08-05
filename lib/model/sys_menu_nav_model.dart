/// menuId : 1
/// parentId : 0
/// parentName : null
/// name : "系统管理"
/// url : null
/// perms : null
/// type : 0
/// icon : "system"
/// orderNum : 0
/// open : null
/// list : [{"menuId":2,"parentId":1,"parentName":null,"name":"管理员列表","url":"sys/user","perms":null,"type":1,"icon":"admin","orderNum":1,"open":null,"list":null},{"menuId":3,"parentId":1,"parentName":null,"name":"角色管理","url":"sys/role","perms":null,"type":1,"icon":"role","orderNum":2,"open":null,"list":null},{"menuId":4,"parentId":1,"parentName":null,"name":"菜单管理","url":"sys/menu","perms":null,"type":1,"icon":"menu","orderNum":3,"open":null,"list":null},{"menuId":5,"parentId":1,"parentName":null,"name":"SQL监控","url":"http://localhost:8080/renren-fast/druid/sql.html","perms":null,"type":1,"icon":"sql","orderNum":4,"open":null,"list":null},{"menuId":6,"parentId":1,"parentName":null,"name":"定时任务","url":"job/schedule","perms":null,"type":1,"icon":"job","orderNum":5,"open":null,"list":null},{"menuId":27,"parentId":1,"parentName":null,"name":"参数管理","url":"sys/config","perms":"sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete","type":1,"icon":"config","orderNum":6,"open":null,"list":null},{"menuId":30,"parentId":1,"parentName":null,"name":"文件上传","url":"oss/oss","perms":"sys:oss:all","type":1,"icon":"oss","orderNum":6,"open":null,"list":null},{"menuId":137,"parentId":1,"parentName":null,"name":"订单分佣","url":"bedside/bedsideordercommission","perms":null,"type":1,"icon":"config","orderNum":6,"open":null,"list":null},{"menuId":158,"parentId":1,"parentName":null,"name":"用户端公告","url":"bedside/bedsideusernotice","perms":null,"type":1,"icon":"config","orderNum":6,"open":null,"list":null},{"menuId":168,"parentId":1,"parentName":null,"name":"首页视频教程","url":"bedside/bedsideindexvideotutorial","perms":null,"type":1,"icon":"config","orderNum":6,"open":null,"list":null},{"menuId":182,"parentId":1,"parentName":null,"name":"图文教程","url":"bedside/bedsidegraphictutorial","perms":null,"type":1,"icon":"config","orderNum":6,"open":null,"list":null},{"menuId":187,"parentId":1,"parentName":null,"name":"医院床号","url":"bedside/bedsidehospitalbed","perms":null,"type":1,"icon":"config","orderNum":6,"open":null,"list":null},{"menuId":192,"parentId":1,"parentName":null,"name":"每日统计表","url":"bedside/bedsidedailystatistics","perms":null,"type":1,"icon":"config","orderNum":6,"open":null,"list":null},{"menuId":29,"parentId":1,"parentName":null,"name":"系统日志","url":"sys/log","perms":"sys:log:list","type":1,"icon":"log","orderNum":7,"open":null,"list":null}]

class SysMenuNavModel {
  int _menuId;
  int _parentId;
  dynamic _parentName;
  String _name;
  String _url;
  dynamic _perms;
  int _type;
  String _icon;
  String _appIcon;
  int _orderNum;
  dynamic _open;
  List<SysMenuNavModel> _list;

  int get menuId => _menuId;

  int get parentId => _parentId;

  dynamic get parentName => _parentName;

  String get name => _name;

  String get url => _url;

  dynamic get perms => _perms;

  int get type => _type;

  String get icon => _icon;

  int get orderNum => _orderNum;

  dynamic get open => _open;

  String get appIcon => _appIcon;

  List<SysMenuNavModel> get list => _list;

  SysMenuNavModel({
    int menuId,
    int parentId,
    dynamic parentName,
    String name,
    String url,
    dynamic perms,
    int type,
    String icon,
    String appIcon,
    int orderNum,
    dynamic open,
    List<SysMenuNavModel> list}) {
    _menuId = menuId;
    _parentId = parentId;
    _parentName = parentName;
    _name = name;
    _url = url;
    _perms = perms;
    _type = type;
    _icon = icon;
    _appIcon = appIcon;
    _orderNum = orderNum;
    _open = open;
    _list = list;
  }

  SysMenuNavModel.fromJson(dynamic json) {
    _menuId = json["menuId"];
    _parentId = json["parentId"];
    _parentName = json["parentName"];
    _name = json["name"];
    _url = json["url"];
    _perms = json["perms"];
    _type = json["type"];
    _icon = json["icon"];
    _appIcon = json["appIcon"];
    _orderNum = json["orderNum"];
    _open = json["open"];
    if (json["list"] != null) {
      _list = [];
      json["list"].forEach((v) {
        SysMenuNavModel e = SysMenuNavModel.fromJson(v);
        if(!e.hidden()) {
          _list.add(e);
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["menuId"] = _menuId;
    map["parentId"] = _parentId;
    map["parentName"] = _parentName;
    map["name"] = _name;
    map["url"] = _url;
    map["perms"] = _perms;
    map["type"] = _type;
    map["icon"] = _icon;
    map["appIcon"] = _appIcon;
    map["orderNum"] = _orderNum;
    map["open"] = _open;
    if (_list != null) {
      map["list"] = _list.map((v) => v.toJson()).toList();
    }
    return map;
  }

  bool hidden() {
    print("url = ${url}");
    if (this._url == null || this._url.isEmpty) return false;
    return this._url.startsWith("sys/") ||  this._url.startsWith("oss/") || this._url.endsWith("sql.html") || this._url.startsWith("job/schedule");
  }
}