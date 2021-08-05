import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_office_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_room_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_user_notice_list_model.dart';
import 'package:binance_game_app/model/enum/enum_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_select/bedside_bedside_hospital_select_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_user_notice/bedside_bedside_user_notice_view_model.dart';
import 'package:binance_game_app/view_model/enums/enum_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';
import 'package:binance_game_app/widget/single_list_picker.dart';


class BedsideBedsideUserNoticeSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideusernoticeSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideUserNoticeSaveOrUpadtePage({this.dto});

  final BedsideBedsideUserNoticeViewModel _bedsideBedsideUserNoticeViewModel = BedsideBedsideUserNoticeViewModel();
  final BedsideBedsideHospitalSelectViewModel _bedsideBedsideHospitalSelectViewModel = BedsideBedsideHospitalSelectViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController officeIdController = new TextEditingController(text: "");
  final TextEditingController roomIdController = new TextEditingController(text: "");
  final TextEditingController startTimeController = new TextEditingController(text: "");
  final TextEditingController endTimeController = new TextEditingController(text: "");
  final TextEditingController stateController = new TextEditingController(text: "");
  final TextEditingController noticeContentController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");
  final TextEditingController hospitalNameController = new TextEditingController(text: "");
  final TextEditingController officeNameController = new TextEditingController(text: "");
  final TextEditingController roomNameController = new TextEditingController(text: "");
  final TextEditingController typeController = new TextEditingController(text: "");
  final TextEditingController typeStrController = new TextEditingController(text: "");

  DateTime _currentStart;
  DateTime _currentEnd;

  //类型监听器
  ValueNotifier<int>  typeValueNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户端公告-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "推送类型",hintText: "请选择推送类型",textEditingController: typeStrController,readOnly: true,suffixIcon: ProviderWidget(
                  init: (EnumViewModel model) {
                    model.appEnumsAll();
                  },
                  viewModel: EnumViewModel(),
                  builder: (_,EnumViewModel model,c){
                    return model.loading ? CupertinoActivityIndicator() :SingleListPicker<EnumModel>(
                      initKey: typeController,
                      onTap: (context,showSingleListPicker) {
                        showSingleListPicker(context,model.enumAllModel.userNoticeTypes);
                      },
                      onSelectedItemChanged: (index) {
                        typeController.text = model.enumAllModel.userNoticeTypes[index].key.toString();
                        typeStrController.text = model.enumAllModel.userNoticeTypes[index].value;
                        typeValueNotifier.value = model.enumAllModel.userNoticeTypes[index].key;

                        hospitalIdController.text = null;
                        hospitalNameController.text = null;

                        officeIdController.text = null;
                        officeNameController.text = null;

                        roomIdController.text = null;
                        roomNameController.text = null;
                      },
                    );
                  },
                ),
                horizontal: 0,
              ),

              ValueListenableBuilder(
                valueListenable: _bedsideBedsideUserNoticeViewModel.valueNotifier,
                builder: (_,__,___){
                  return PrefixiconDateTextField(prefixText: "开始时间",hintText: "请输入开始时间",controller: startTimeController, current: _currentStart);
                },
              ),
              ValueListenableBuilder(
                valueListenable: _bedsideBedsideUserNoticeViewModel.valueNotifier,
                builder: (_,__,___){
                  return PrefixiconDateTextField(prefixText: "结束时间",hintText: "请输入结束时间",controller: endTimeController,current: _currentEnd);
                },
              ),

              ValueListenableBuilder(
                valueListenable: typeValueNotifier,
                builder: (_,__,___) {
                  print(typeValueNotifier.value);
                  return Offstage(
                    offstage: typeValueNotifier.value == 1 || typeValueNotifier.value == 0,
                    child: PrefixiconTextField(prefixText: "医院名称",hintText: "请输入医院名称",textEditingController: hospitalNameController,suffixIcon: ProviderWidget(
                      init: (BedsideBedsideHospitalSelectViewModel model) {
                        model.bedsideBedsideHospitalListAll();
                      },
                      viewModel: _bedsideBedsideHospitalSelectViewModel,
                      builder: (_,BedsideBedsideHospitalSelectViewModel model,c){
                        return model.loading ? CupertinoActivityIndicator() :SingleListPicker<BedsideBedsideHospitalListModelData>(
                          initKey: hospitalIdController,
                          onTap: (context,showSingleListPicker) {
                            showSingleListPicker(context,model.bedsideBedsideHospitalListModelDatas);
                          },
                          onSelectedItemChanged: (index) {
                            hospitalIdController.text = model.bedsideBedsideHospitalListModelDatas[index].id.toString();
                            hospitalNameController.text = model.bedsideBedsideHospitalListModelDatas[index].name.toString();

                            officeIdController.text = null;
                            officeNameController.text = null;

                            roomIdController.text = null;
                            roomNameController.text = null;

                            model.bedsideBedsideHospitalOfficeListAll(model.bedsideBedsideHospitalListModelDatas[index].id);

                          },
                        );
                      },
                    ),horizontal: 0,),
                  );
                },
              ),

              ValueListenableBuilder(
                valueListenable: typeValueNotifier,
                builder: (_,__,___) {
                  print(typeValueNotifier.value);
                  return Offstage(
                    offstage: typeValueNotifier.value == 1 || typeValueNotifier.value == 0 || typeValueNotifier.value == 2,
                    child: PrefixiconTextField(prefixText: "科室名称",hintText: "请输入科室名称",textEditingController: officeNameController,suffixIcon: ProviderWidget(
                      init: (BedsideBedsideHospitalSelectViewModel model) {

                      },
                      viewModel: _bedsideBedsideHospitalSelectViewModel,
                      builder: (_,BedsideBedsideHospitalSelectViewModel model,c){
                        return model.loading ? CupertinoActivityIndicator() :SingleListPicker<BedsideBedsideHospitalOfficeListModelData>(
                          initKey: officeIdController,
                          onTap: (context,showSingleListPicker) {
                            print(model.officeValueNotifier.value.length);
                            showSingleListPicker(context,model.officeValueNotifier.value);
                          },
                          onSelectedItemChanged: (index) {
                            officeIdController.text = model.officeValueNotifier.value[index].id.toString();
                            officeNameController.text = model.officeValueNotifier.value[index].name.toString();

                            roomIdController.text = null;
                            roomNameController.text = null;

                            model.bedsideBedsideHospitalRoomListAll(model.officeValueNotifier.value[index].id);
                          },
                        );
                      },
                    ),horizontal: 0,),
                  );
                },
              ),

              ValueListenableBuilder(
                valueListenable: typeValueNotifier,
                builder: (_,__,___) {
                  print(typeValueNotifier.value);
                  return Offstage(
                    offstage: typeValueNotifier.value == 1 || typeValueNotifier.value == 0 || typeValueNotifier.value == 3  || typeValueNotifier.value == 2,
                    child: PrefixiconTextField(prefixText: "房间号名称",hintText: "请输入房间号名称",textEditingController: roomNameController,suffixIcon: ProviderWidget(
                      init: (BedsideBedsideHospitalSelectViewModel model) {

                      },
                      viewModel: _bedsideBedsideHospitalSelectViewModel,
                      builder: (_,BedsideBedsideHospitalSelectViewModel model,c){
                        return model.loading ? CupertinoActivityIndicator() :SingleListPicker<BedsideBedsideHospitalRoomListModelData>(
                          initKey: roomIdController,
                          onTap: (context,showSingleListPicker) {
                            showSingleListPicker(context,model.roomValueNotifier.value);
                          },
                          onSelectedItemChanged: (index) {
                            roomIdController.text = model.roomValueNotifier.value[index].id.toString();
                            roomNameController.text = model.roomValueNotifier.value[index].name.toString();
                          },
                        );
                      },
                    ),horizontal: 0,),
                  );
                },
              ),


              PrefixiconTextField(maxLines: 5,prefixText: "提示内容",hintText: "请输入提示内容",textEditingController: noticeContentController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideUserNoticeViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideUserNoticeInfo(dto.id,success: (BedsideBedsideUserNoticeListModelData info) {
                        hospitalIdController.text = (info.hospitalId??"").toString();
                        officeIdController.text = (info.officeId??"").toString();
                        roomIdController.text = (info.roomId ?? "").toString();
                        startTimeController.text = info.startTime;
                        endTimeController.text = info.endTime;
                        stateController.text = info.state.toString();
                        noticeContentController.text = info.noticeContent;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                        hospitalNameController.text = info.hospitalName;
                        officeNameController.text = info.officeName;
                        roomNameController.text = info.roomName;
                        typeController.text = info.type.toString();
                        typeStrController.text = info.typeStr.toString();
                        _currentStart = DateTime.parse(startTimeController.text);
                        _currentEnd = DateTime.parse(endTimeController.text);
                        typeValueNotifier.value = info.type;

                        _bedsideBedsideHospitalSelectViewModel.bedsideBedsideHospitalOfficeListAll(info.hospitalId);
                        _bedsideBedsideHospitalSelectViewModel.bedsideBedsideHospitalRoomListAll(info.officeId);
                      });
                    }
                  },
                  viewModel: _bedsideBedsideUserNoticeViewModel,
                  builder: (c,BedsideBedsideUserNoticeViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }

                          if (typeController.text.isEmpty) {
                            EasyLoading.showToast("推送类型不能为空");
                            return;
                          }

                        if ((typeValueNotifier.value == 2 ||typeValueNotifier.value == 4 || typeValueNotifier.value == 3) && hospitalIdController.text.isEmpty) {
                            EasyLoading.showToast("医院id不能为空");
                            return;
                        }
                        if ((typeValueNotifier.value == 4 || typeValueNotifier.value == 3)  && officeIdController.text.isEmpty) {
                            EasyLoading.showToast("科室id不能为空");
                            return;
                        }
                        if ((typeValueNotifier.value == 4) && roomIdController.text.isEmpty) {
                            EasyLoading.showToast("床位id不能为空");
                            return;
                        }
                        if (startTimeController.text.isEmpty) {
                            EasyLoading.showToast("开始时间不能为空");
                            return;
                        }
                        if (endTimeController.text.isEmpty) {
                            EasyLoading.showToast("结束时间不能为空");
                            return;
                        }


                        String hospitalId = hospitalIdController.text;
                        String officeId = officeIdController.text;
                        String roomId = roomIdController.text;
                        String startTime = startTimeController.text;
                        String endTime = endTimeController.text;
                        String state = stateController.text;
                        String noticeContent = noticeContentController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;
                        String hospitalName = hospitalNameController.text;
                        String officeName = officeNameController.text;
                        String roomName = roomNameController.text;
                        String type = typeController.text;

                        BedsideBedsideUserNoticeListModelData data = BedsideBedsideUserNoticeListModelData(
                          id: dto.id,
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            officeId: officeId.isEmpty ? null : int.parse(officeId),
                            roomId: roomId.isEmpty ? null : int.parse(roomId),
                            startTime: startTime,
                            endTime: endTime,
                            state: state.isEmpty ? null : int.parse(state),
                            noticeContent: noticeContent,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                            hospitalName: hospitalName,
                            officeName: officeName,
                            roomName: roomName,
                            type: type.isEmpty ? null : int.parse(type),
                        );
                        model.bedsideBedsideUserNoticeSaveUpdate(data,success: (value) {
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
}

class PrefixiconDateTextField extends StatelessWidget {


  final TextEditingController controller;
  DateTime current;
  String prefixText;
  String hintText;

  PrefixiconDateTextField({
    Key key,
    @required this.controller,
    @required DateTime current,
    this.prefixText,
    this.hintText
  }): this.current = current ?? DateTime.now();

  @override
  Widget build(BuildContext context) {
    print(this.current);
    return PrefixiconTextField(prefixText: prefixText ?? "",hintText: hintText ?? "",textEditingController: controller,readOnly: true,onTap: () async {

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 10,
        builder: (BuildContext context) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 15.w,),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text("取消",style: Theme.of(context).textTheme.headline2.copyWith(height: 2),),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      controller.text = current.toString().split(".")[0];
                      Navigator.pop(context);
                    },
                    child: Text("确认",style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.green,height: 2),),
                  ),
                  SizedBox(width: 15.w,),
                ],
              ),
              Divider(),
              Expanded(
                flex: 1,
                child: CupertinoDatePicker(

                  onDateTimeChanged: (DateTime value) {
                    current = value;
                  },
                  use24hFormat: true,
                  initialDateTime: current,
                  mode: CupertinoDatePickerMode.dateAndTime,
                ),
              ),
            ],
          );
        },
      );


    },);
  }
}
