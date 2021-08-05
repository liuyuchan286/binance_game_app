

class BedsideBedsideOpsHospitalListbyopsidModel {
  int id;
  String name;
  bool hospitalId;
  bool autoPush;
  bool autoAssign;

  BedsideBedsideOpsHospitalListbyopsidModel({
      this.id, 
      this.name, 
      this.hospitalId, 
      this.autoPush, 
      this.autoAssign});

  BedsideBedsideOpsHospitalListbyopsidModel.fromJson(dynamic json) {
    id = json["id"];
    name = json["name"];
    hospitalId = json["hospitalId"];
    autoPush = json["autoPush"];
    autoAssign = json["autoAssign"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["name"] = name;
    map["hospitalId"] = hospitalId;
    map["autoPush"] = autoPush;
    map["autoAssign"] = autoAssign;
    return map;
  }

}