import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_problem_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital/bedside_bedside_hospital_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_select/bedside_bedside_hospital_select_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_problem/bedside_bedside_problem_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';
import 'package:binance_game_app/widget/single_list_picker.dart';


class BedsideBedsideProblemSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideproblemSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideProblemSaveOrUpadtePage({this.dto});

  //医院信息
  final BedsideBedsideHospitalViewModel _bedsideBedsideHospitalViewModel = BedsideBedsideHospitalViewModel();

  final BedsideBedsideProblemViewModel _bedsideBedsideProblemViewModel = BedsideBedsideProblemViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController valueController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController hospitalNameController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("常见问题记录表-${dto.titleStr}",
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

              PrefixiconTextField(required: false,prefixText: "医院名称",hintText: "请输入医院名称",textEditingController: hospitalNameController,
                suffixIcon: ProviderWidget(
                  init: (BedsideBedsideHospitalSelectViewModel model) {
                    model.bedsideBedsideHospitalListAll();
                  },
                  viewModel: BedsideBedsideHospitalSelectViewModel(),
                  builder: (_,BedsideBedsideHospitalSelectViewModel model,c){
                    return model.loading ? CupertinoActivityIndicator() :SingleListPicker<BedsideBedsideHospitalListModelData>(
                      initKey: hospitalIdController,
                      onTap: (context,showSingleListPicker) {
                        showSingleListPicker(context,model.bedsideBedsideHospitalListModelDatas);
                      },
                      onSelectedItemChanged: (index) {
                        hospitalIdController.text = model.bedsideBedsideHospitalListModelDatas[index].id.toString();
                        hospitalNameController.text = model.bedsideBedsideHospitalListModelDatas[index].name.toString();
                      },
                    );
                  },
                ),
                horizontal: 0,
                readOnly: true,
              ),
              PrefixiconTextField(prefixText: "标题",hintText: "请输入标题",textEditingController: nameController,),
              PrefixiconTextField(prefixText: "内容",hintText: "请输入内容",textEditingController: valueController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideProblemViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideProblemInfo(dto.id,success: (BedsideBedsideProblemListModelData info) {
                        nameController.text = info.name;
                        valueController.text = info.value;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                        hospitalIdController.text = info.hospitalId.toString();
                        hospitalNameController.text = info.hospitalName;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideProblemViewModel,
                  builder: (c,BedsideBedsideProblemViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (nameController.text.isEmpty) {
                            EasyLoading.showToast("标题不能为空");
                            return;
                        }
                        if (valueController.text.isEmpty) {
                            EasyLoading.showToast("内容不能为空");
                            return;
                        }

                        if (hospitalIdController.text.isEmpty) {
                            EasyLoading.showToast("医院不能为空");
                            return;
                        }

                        String name = nameController.text;
                        String value = valueController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;
                        String hospitalId = hospitalIdController.text;
                        String hospitalName = hospitalNameController.text;

                        BedsideBedsideProblemListModelData data = BedsideBedsideProblemListModelData(
                          id: dto.id,
                            name: name,
                            value: value,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            hospitalName: hospitalName,
                        );
                        model.bedsideBedsideProblemSaveUpdate(data,success: (value) {
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
