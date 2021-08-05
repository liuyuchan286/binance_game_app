import 'package:binance_game_app/model/bedside_bedside_ops_hospital_listbyopsid_model.dart';

class BedsideBedsideopshospitalSaveDto {
  int t;
  int opsId;
  String hospitalId;
  String createdAt;
  String updatedAt;
  List<BedsideBedsideOpsHospitalListbyopsidModel> hospitals;
  BedsideBedsideopshospitalSaveDto({
      this.t, 
      this.opsId, 
      this.hospitalId, 
      this.createdAt, 
      this.updatedAt,
      this.hospitals});

  BedsideBedsideopshospitalSaveDto.fromJson(dynamic json) {
    t = json["t"];
    opsId = json["opsId"];
    hospitalId = json["hospitalId"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["t"] = t;
    map["opsId"] = opsId;
    map["hospitalId"] = hospitalId;
    map["createdAt"] = createdAt;
    map["updatedAt"] = updatedAt;
    if (hospitals != null) {
      map["hospitals"] = hospitals.map((v) => v.toJson()).toList();
    }
    return map;
  }

}