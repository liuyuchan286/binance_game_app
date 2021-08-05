import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_graphic_tutorial_hospital_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_graphic_tutorial_hospital/bedside_bedside_graphic_tutorial_hospital_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideGraphicTutorialHospitalSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidegraphictutorialhospitalSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideGraphicTutorialHospitalSaveOrUpadtePage({this.dto});

  final BedsideBedsideGraphicTutorialHospitalViewModel _bedsideBedsideGraphicTutorialHospitalViewModel = BedsideBedsideGraphicTutorialHospitalViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController remarkController = new TextEditingController(text: "");
  final TextEditingController graphicTutorialHospitalIdController = new TextEditingController(text: "");
  final TextEditingController contentController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("医院图文教程-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "名称",hintText: "请输入名称",textEditingController: nameController,),
              PrefixiconTextField(prefixText: "备注",hintText: "请输入备注",textEditingController: remarkController,),
              PrefixiconTextField(prefixText: "医院图文教程id",hintText: "请输入医院图文教程id",textEditingController: graphicTutorialHospitalIdController,),
              PrefixiconTextField(prefixText: "内容",hintText: "请输入内容",textEditingController: contentController,),
              PrefixiconTextField(prefixText: "创建时间",hintText: "请输入创建时间",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "修改时间",hintText: "请输入修改时间",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "删除时间",hintText: "请输入删除时间",textEditingController: deletedAtController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideGraphicTutorialHospitalViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideGraphicTutorialHospitalInfo(dto.id,success: (BedsideBedsideGraphicTutorialHospitalListModelData info) {
                        nameController.text = info.name;
                        remarkController.text = info.remark;
                        graphicTutorialHospitalIdController.text = info.graphicTutorialHospitalId.toString();
                        contentController.text = info.content;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideGraphicTutorialHospitalViewModel,
                  builder: (c,BedsideBedsideGraphicTutorialHospitalViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (nameController.text.isEmpty) {
                            EasyLoading.showToast("名称不能为空");
                            return;
                        }
                        if (remarkController.text.isEmpty) {
                            EasyLoading.showToast("备注不能为空");
                            return;
                        }
                        if (graphicTutorialHospitalIdController.text.isEmpty) {
                            EasyLoading.showToast("医院图文教程id不能为空");
                            return;
                        }
                        if (contentController.text.isEmpty) {
                            EasyLoading.showToast("内容不能为空");
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
                        if (deletedAtController.text.isEmpty) {
                            EasyLoading.showToast("删除时间不能为空");
                            return;
                        }

                        String name = nameController.text;
                        String remark = remarkController.text;
                        String graphicTutorialHospitalId = graphicTutorialHospitalIdController.text;
                        String content = contentController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;

                        BedsideBedsideGraphicTutorialHospitalListModelData data = BedsideBedsideGraphicTutorialHospitalListModelData(
                          id: dto.id,
                            name: name,
                            remark: remark,
                            graphicTutorialHospitalId: graphicTutorialHospitalId.isEmpty ? null : int.parse(graphicTutorialHospitalId),
                            content: content,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                        );
                        model.bedsideBedsideGraphicTutorialHospitalSaveUpdate(data,success: (value) {
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
