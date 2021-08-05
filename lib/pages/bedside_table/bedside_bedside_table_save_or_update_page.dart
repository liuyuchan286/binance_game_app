import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_bed_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_office_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_room_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_table_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital/bedside_bedside_hospital_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_bed/bedside_bedside_hospital_bed_view_model.bak.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_office/bedside_bedside_hospital_office_view_model.bak.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_room/bedside_bedside_hospital_room_view_model.bak.dart';
import 'package:binance_game_app/view_model/bedside_bedside_table/bedside_bedside_table_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';
import 'package:binance_game_app/widget/single_list_picker.dart';


class BedsideBedsideTableSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidetableSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideTableSaveOrUpadtePage({this.dto});

  final BedsideBedsideTableViewModel _bedsideBedsideTableViewModel = BedsideBedsideTableViewModel();
  //医院信息
  final BedsideBedsideHospitalViewModel _bedsideBedsideHospitalViewModel = BedsideBedsideHospitalViewModel();
  //科室信息
  final BedsideBedsideHospitalOfficeViewModel _bedsideBedsideHospitalOfficeViewModel = BedsideBedsideHospitalOfficeViewModel();
  //房间信息
  final BedsideBedsideHospitalRoomViewModel _bedsideBedsideHospitalRoomViewModel = BedsideBedsideHospitalRoomViewModel();
  //床位信息
  final BedsideBedsideHospitalBedViewModel _bedsideBedsideHospitalBedViewModel = BedsideBedsideHospitalBedViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController officeIdController = new TextEditingController(text: "");
  final TextEditingController roomIdController = new TextEditingController(text: "");
  final TextEditingController bedIdController = new TextEditingController(text: "");
  final TextEditingController numberController = new TextEditingController(text: "");
  final TextEditingController hospitalNameController = new TextEditingController(text: "");
  final TextEditingController officeNameController = new TextEditingController(text: "");
  final TextEditingController roomNameController = new TextEditingController(text: "");
  final TextEditingController bedNameController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("床头柜记录表-${dto.titleStr}",
        ),
      ),
      body: GestureDetector(
        onTap: () {
          //关闭键盘
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              PrefixiconTextField(prefixText: "二维码编号",hintText: "请输入二维码编号",textEditingController: numberController,),
              PrefixiconTextField(prefixText: "医院名称",hintText: "请输入医院名称",textEditingController: hospitalNameController,
                suffixIcon: SingleListPicker<BedsideBedsideHospitalListModelData>(
                  initKey: hospitalIdController,
                  onTap: (context,showSingleListPicker) {
                    showSingleListPicker(context,_bedsideBedsideHospitalViewModel.bedsideBedsideHospitalListModelDatas);
                  },
                  onSelectedItemChanged: (index) {
                    hospitalSetState(index);
                  },
                ),
                horizontal: 0,
                readOnly: true,
              ),
              PrefixiconTextField(prefixText: "科室名称",hintText: "请输入科室名称",textEditingController: officeNameController,
                suffixIcon: SingleListPicker<BedsideBedsideHospitalOfficeListModelData>(
                  initKey: officeIdController,
                  onTap: (context,showSingleListPicker) {
                    showSingleListPicker(context,_bedsideBedsideHospitalOfficeViewModel.bedsideBedsideHospitalOfficeListModelDatas);
                  },
                  onSelectedItemChanged: (index) {
                    officeSetState(index);
                  },
                ),
                horizontal: 0,
                readOnly: true,
              ),
              PrefixiconTextField(prefixText: "房间号名称",hintText: "请输入房间号名称",textEditingController: roomNameController,
                suffixIcon: SingleListPicker<BedsideBedsideHospitalRoomListModelData>(
                  initKey: roomIdController,
                  onTap: (context,showSingleListPicker) {
                    showSingleListPicker(context,_bedsideBedsideHospitalRoomViewModel.bedsideBedsideHospitalRoomListModelDatas);
                  },
                  onSelectedItemChanged: (index) {
                    roomSetState(index);
                  },
                ),
                horizontal: 0,
                readOnly: true,
              ),
              PrefixiconTextField(prefixText: "床号名称",hintText: "请输入床号名称",textEditingController: bedNameController,
                suffixIcon: SingleListPicker<BedsideBedsideHospitalBedListModelData>(
                  initKey: bedIdController,
                  onTap: (context,showSingleListPicker) {
                    showSingleListPicker(context,_bedsideBedsideHospitalBedViewModel.bedsideBedsideHospitalBedListModelDatas);
                  },
                  onSelectedItemChanged: (index) {
                    bedSetState(index);
                  },
                ),
                horizontal: 0,
                readOnly: true,
              ),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideTableViewModel model) {

                    _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalListAll();

                    if (this.dto.id != null) {
                      model.bedsideBedsideTableInfo(dto.id,success: (BedsideBedsideTableListModelData info) {
                        hospitalIdController.text = info.hospitalId.toString();
                        officeIdController.text = info.officeId.toString();
                        roomIdController.text = info.roomId.toString();
                        bedIdController.text = info.bedId.toString();
                        numberController.text = info.number;
                        hospitalNameController.text = info.hospitalName;
                        officeNameController.text = info.officeName;
                        roomNameController.text = info.roomName;
                        bedNameController.text = info.bedName;

                        //初始化医院,房间,科室信息
                        _bedsideBedsideHospitalOfficeViewModel.bedsideBedsideHospitalOfficeListAll(info.hospitalId);
                        _bedsideBedsideHospitalRoomViewModel.bedsideBedsideHospitalRoomListAll(info.officeId);
                        _bedsideBedsideHospitalBedViewModel.bedsideBedsideHospitalBedListAll(info.roomId);
                      });
                    }
                  },
                  viewModel: _bedsideBedsideTableViewModel,
                  dispose: () {
                    _bedsideBedsideHospitalViewModel.dispose();
                    _bedsideBedsideHospitalOfficeViewModel.dispose();
                    _bedsideBedsideHospitalRoomViewModel.dispose();
                    _bedsideBedsideHospitalBedViewModel.dispose();
                  },
                  builder: (c,BedsideBedsideTableViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (officeIdController.text.isEmpty) {
                            EasyLoading.showToast("科室ID不能为空");
                            return;
                        }
                        if (roomIdController.text.isEmpty) {
                            EasyLoading.showToast("房间号ID不能为空");
                            return;
                        }
                        if (bedIdController.text.isEmpty) {
                            EasyLoading.showToast("床号id不能为空");
                            return;
                        }
                        if (numberController.text.isEmpty) {
                            EasyLoading.showToast("二维码编号不能为空");
                            return;
                        }
                        if (hospitalNameController.text.isEmpty) {
                            EasyLoading.showToast("医院名称不能为空");
                            return;
                        }
                        if (officeNameController.text.isEmpty) {
                            EasyLoading.showToast("科室名称不能为空");
                            return;
                        }
                        if (roomNameController.text.isEmpty) {
                            EasyLoading.showToast("房间号名称不能为空");
                            return;
                        }
                        if (bedNameController.text.isEmpty) {
                            EasyLoading.showToast("床号名称不能为空");
                            return;
                        }

                        String hospitalId = hospitalIdController.text;
                        String officeId = officeIdController.text;
                        String roomId = roomIdController.text;
                        String bedId = bedIdController.text;
                        String number = numberController.text;
                        String hospitalName = hospitalNameController.text;
                        String officeName = officeNameController.text;
                        String roomName = roomNameController.text;
                        String bedName = bedNameController.text;

                        BedsideBedsideTableListModelData data = BedsideBedsideTableListModelData(
                          id: dto.id,
                          hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                          officeId: officeId.isEmpty ? null : int.parse(officeId),
                          roomId: roomId.isEmpty ? null : int.parse(roomId),
                          bedId: bedId.isEmpty ? null : int.parse(bedId),
                          number: number,
                          hospitalName: hospitalName,
                          officeName: officeName,
                          roomName: roomName,
                          bedName: bedName,
                        );
                        model.bedsideBedsideTableSaveUpdate(data,success: (value) {
                          EasyLoading.showToast("${dto.titleStr}成功");
                          dto.callback(data);
                          Navigator.pop<String>(context);
                        });
                      },
                      child: model.loading ? CupertinoActivityIndicator() : Text(
                          "确定"
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void bedSetState(int index) {
    BedsideBedsideHospitalBedListModelData data = _bedsideBedsideHospitalBedViewModel.bedsideBedsideHospitalBedListModelDatas[index];
    bedIdController.text = data.id.toString();
    bedNameController.text = data.name;
  }

  void roomSetState(int index) {
    BedsideBedsideHospitalRoomListModelData data = _bedsideBedsideHospitalRoomViewModel.bedsideBedsideHospitalRoomListModelDatas[index];
    roomIdController.text = data.id.toString();
    roomNameController.text = data.name;

    clearBed();
    _bedsideBedsideHospitalBedViewModel.bedsideBedsideHospitalBedListAll(data.id);
  }

  void officeSetState(int index) {
    BedsideBedsideHospitalOfficeListModelData data = _bedsideBedsideHospitalOfficeViewModel.bedsideBedsideHospitalOfficeListModelDatas[index];
    officeIdController.text = data.id.toString();
    officeNameController.text = data.name;

    clearRoom();
    clearBed();
    _bedsideBedsideHospitalRoomViewModel.bedsideBedsideHospitalRoomListAll(data.id);
  }

  void hospitalSetState(int index) {
    BedsideBedsideHospitalListModelData data = _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalListModelDatas[index];
    hospitalIdController.text = data.id.toString();
    hospitalNameController.text = data.name.toString();
    clearOffice();
    clearRoom();
    clearBed();
    _bedsideBedsideHospitalOfficeViewModel.bedsideBedsideHospitalOfficeListAll(data.id);
  }

  void clearBed() {
    bedIdController.text = "";
    bedNameController.text = "";
    _bedsideBedsideHospitalBedViewModel.bedsideBedsideHospitalBedListModelDatas = [];
  }

  void clearRoom() {
    roomIdController.text = "";
    roomNameController.text = "";
    _bedsideBedsideHospitalRoomViewModel.bedsideBedsideHospitalRoomListModelDatas = [];
  }

  void clearOffice() {
    officeIdController.text = "";
    officeNameController.text = "";
    _bedsideBedsideHospitalOfficeViewModel.bedsideBedsideHospitalOfficeListModelDatas = [];
  }
}
