import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_commission_config_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_commission_config/bedside_bedside_hospital_commission_config_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideHospitalCommissionConfigSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidehospitalcommissionconfigSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideHospitalCommissionConfigSaveOrUpadtePage({this.dto});

  final BedsideBedsideHospitalCommissionConfigViewModel _bedsideBedsideHospitalCommissionConfigViewModel = BedsideBedsideHospitalCommissionConfigViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController hospitalNameController = new TextEditingController(text: "");
  final TextEditingController commissionRatioController = new TextEditingController(text: "");
  final TextEditingController lateArrivalController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("医院分佣配置-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "医院名称",hintText: "请输入医院名称",textEditingController: hospitalNameController,readOnly: true,),
              PrefixiconTextField(prefixText: "分佣比例",hintText: "请输入分佣比例",textEditingController: commissionRatioController,),
              PrefixiconTextField(prefixText: "延迟到账",hintText: "请输入延迟到账",textEditingController: lateArrivalController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideHospitalCommissionConfigViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideHospitalCommissionConfigInfo(dto.id,success: (BedsideBedsideHospitalCommissionConfigListModelData info) {
                        hospitalNameController.text = info.hospitalName;
                        commissionRatioController.text = info.commissionRatio.toString();
                        lateArrivalController.text = info.lateArrival.toString();
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideHospitalCommissionConfigViewModel,
                  builder: (c,BedsideBedsideHospitalCommissionConfigViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (hospitalNameController.text.isEmpty) {
                            EasyLoading.showToast("医院名称不能为空");
                            return;
                        }
                        if (commissionRatioController.text.isEmpty) {
                            EasyLoading.showToast("分佣比例不能为空");
                            return;
                        }
                        if (lateArrivalController.text.isEmpty) {
                            EasyLoading.showToast("延迟到账不能为空");
                            return;
                        }
                        if (createdAtController.text.isEmpty) {
                            EasyLoading.showToast("创建时间不能为空");
                            return;
                        }
                        if (updatedAtController.text.isEmpty) {
                            EasyLoading.showToast("修改时间不能为空");
                            return;
                        }

                        String hospitalName = hospitalNameController.text;
                        String commissionRatio = commissionRatioController.text;
                        String lateArrival = lateArrivalController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;

                        BedsideBedsideHospitalCommissionConfigListModelData data = BedsideBedsideHospitalCommissionConfigListModelData(
                          id: dto.id,
                            hospitalName: hospitalName,
                            commissionRatio: commissionRatio.isEmpty ? null : double.parse(commissionRatio),
                            lateArrival: lateArrival.isEmpty ? null : int.parse(lateArrival),
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                        );
                        model.bedsideBedsideHospitalCommissionConfigSaveUpdate(data,success: (value) {
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
