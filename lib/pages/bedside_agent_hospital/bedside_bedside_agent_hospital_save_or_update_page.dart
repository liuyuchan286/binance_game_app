import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_agent_hospital_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_agent_hospital/bedside_bedside_agent_hospital_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideAgentHospitalSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideagenthospitalSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideAgentHospitalSaveOrUpadtePage({this.dto});

  final BedsideBedsideAgentHospitalViewModel _bedsideBedsideAgentHospitalViewModel = BedsideBedsideAgentHospitalViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController agentIdController = new TextEditingController(text: "");
  final TextEditingController hospitalIdController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("代理商-医院记录表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "代理商ID",hintText: "请输入代理商ID",textEditingController: agentIdController,),
              PrefixiconTextField(prefixText: "医院ID",hintText: "请输入医院ID",textEditingController: hospitalIdController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: updatedAtController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideAgentHospitalViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideAgentHospitalInfo(dto.id,success: (BedsideBedsideAgentHospitalListModelData info) {
                        agentIdController.text = info.agentId.toString();
                        hospitalIdController.text = info.hospitalId.toString();
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideAgentHospitalViewModel,
                  builder: (c,BedsideBedsideAgentHospitalViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (agentIdController.text.isEmpty) {
                            EasyLoading.showToast("代理商ID不能为空");
                            return;
                        }
                        if (hospitalIdController.text.isEmpty) {
                            EasyLoading.showToast("医院ID不能为空");
                            return;
                        }
                        if (createdAtController.text.isEmpty) {
                            EasyLoading.showToast("不能为空");
                            return;
                        }
                        if (updatedAtController.text.isEmpty) {
                            EasyLoading.showToast("不能为空");
                            return;
                        }

                        String agentId = agentIdController.text;
                        String hospitalId = hospitalIdController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;

                        BedsideBedsideAgentHospitalListModelData data = BedsideBedsideAgentHospitalListModelData(
                          id: dto.id,
                            agentId: agentId.isEmpty ? null : int.parse(agentId),
                            hospitalId: hospitalId.isEmpty ? null : int.parse(hospitalId),
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                        );
                        model.bedsideBedsideAgentHospitalSaveUpdate(data,success: (value) {
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
