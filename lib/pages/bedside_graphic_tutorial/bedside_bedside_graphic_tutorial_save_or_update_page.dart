import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_graphic_tutorial_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_graphic_tutorial_list_model.dart';
import 'package:binance_game_app/pages/bedside_agent/widget/bedside_bedside_agent_hospital_table_column.dart';
import 'package:binance_game_app/view_model/bedside_bedside_graphic_tutorial/bedside_bedside_graphic_tutorial_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_graphic_tutorial_hospital/bedside_bedside_graphic_tutorial_hospital_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideGraphicTutorialSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidegraphictutorialSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideGraphicTutorialSaveOrUpadtePage({this.dto});

  final BedsideBedsideGraphicTutorialViewModel _bedsideBedsideGraphicTutorialViewModel = BedsideBedsideGraphicTutorialViewModel();
  final BedsideBedsideGraphicTutorialHospitalViewModel _bedsideBedsideGraphicTutorialHospitalViewModel = BedsideBedsideGraphicTutorialHospitalViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController remarkController = new TextEditingController(text: "");
  final TextEditingController contentController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle =
    Theme.of(context).textTheme.headline1.copyWith(fontSize: 14.ssp);

    final TextStyle lineStyle = Theme.of(context).textTheme.headline5;

    return Scaffold(
      appBar: AppBar(
        title: Text("图文教程-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "备注",hintText: "请输入备注",textEditingController: remarkController,),

              ProviderWidget(
                viewModel: _bedsideBedsideGraphicTutorialHospitalViewModel,
                init: (BedsideBedsideGraphicTutorialHospitalViewModel model) {
                  model.initBedsideBedsideGraphicTutorialHospitalListAll(dto.id);
                },
                builder: (c,BedsideBedsideGraphicTutorialHospitalViewModel model,_){
                  if(model.loading) {
                    return CupertinoActivityIndicator();
                  }
                  return BedsideBedsideAgentHospitalTableColumn<BedsideBedsideGraphicTutorialHospitalListModelData>(titleStyle: titleStyle, lineStyle: lineStyle,
                    listData: model.bedsideBedsideGraphicTutorialHospitalListModelDatas,
                    selectsId: model.selectIds,
                  );
                },
              ),

              PrefixiconTextField(prefixText: "内容",hintText: "请输入内容",textEditingController: contentController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideGraphicTutorialViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideGraphicTutorialInfo(dto.id,success: (BedsideBedsideGraphicTutorialListModelData info) {
                        remarkController.text = info.remark;
                        contentController.text = info.content;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideGraphicTutorialViewModel,
                  builder: (c,BedsideBedsideGraphicTutorialViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (remarkController.text.isEmpty) {
                            EasyLoading.showToast("备注不能为空");
                            return;
                        }
                        if (contentController.text.isEmpty) {
                            EasyLoading.showToast("内容不能为空");
                            return;
                        }

                        String remark = remarkController.text;
                        String content = contentController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;

                        BedsideBedsideGraphicTutorialListModelData data = BedsideBedsideGraphicTutorialListModelData(
                          id: dto.id,
                            remark: remark,
                            content: content,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                            selectHospitalIds: _bedsideBedsideGraphicTutorialHospitalViewModel.selectIds,
                        );
                        model.bedsideBedsideGraphicTutorialSaveUpdate(data,success: (value) {
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
