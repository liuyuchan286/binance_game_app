import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/bedside_bedside_hospital_office/bedside_bedside_hospital_office_list_dto.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_office_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_office/bedside_bedside_hospital_office_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideHospitalOfficeSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidehospitalofficeSaveOrUpadtePage';

  SaveOrUpdateDto<BedsideBedsideHospitalOfficeListDto> dto;


  BedsideBedsideHospitalOfficeSaveOrUpadtePage({this.dto});

  final BedsideBedsideHospitalOfficeViewModel _bedsideBedsideHospitalOfficeViewModel = BedsideBedsideHospitalOfficeViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("医院科室记录表-${dto.titleStr}",
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
              PrefixiconTextField(prefixText: "科室名称",hintText: "请输入科室名称",textEditingController: nameController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideHospitalOfficeViewModel model) {
                    hospitalIdController.text = dto.t.hospitalId.toString();
                    if (this.dto.id != null) {
                      model.bedsideBedsideHospitalOfficeInfo(dto.id,success: (BedsideBedsideHospitalOfficeListModelData info) {
                        hospitalIdController.text = info.hospitalId.toString();
                        nameController.text = info.name;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideHospitalOfficeViewModel,
                  builder: (c,BedsideBedsideHospitalOfficeViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (hospitalIdController.text.isEmpty) {
                            EasyLoading.showToast("医院ID不能为空");
                            return;
                        }
                        if (nameController.text.isEmpty) {
                            EasyLoading.showToast("科室名称不能为空");
                            return;
                        }


                        String hospitalId = hospitalIdController.text;
                        String name = nameController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;

                        BedsideBedsideHospitalOfficeListModelData data = BedsideBedsideHospitalOfficeListModelData(
                          id: dto.id,
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            name: name,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                        );
                        model.bedsideBedsideHospitalOfficeSaveUpdate(data,success: (value) {
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
