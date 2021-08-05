import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_config_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_config/bedside_bedside_config_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideConfigSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideconfigSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideConfigSaveOrUpadtePage({this.dto});

  final BedsideBedsideConfigViewModel _bedsideBedsideConfigViewModel = BedsideBedsideConfigViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController valueController = new TextEditingController(text: "");
  final TextEditingController descController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("系统配置表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "配置名称",hintText: "请输入配置名称",textEditingController: nameController,),
              PrefixiconTextField(prefixText: "配置值",hintText: "请输入配置值",textEditingController: valueController,),
              PrefixiconTextField(prefixText: "说明（描述）",hintText: "请输入说明（描述）",textEditingController: descController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideConfigViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideConfigInfo(dto.id,success: (BedsideBedsideConfigListModelData info) {
                        nameController.text = info.name;
                        valueController.text = info.value;
                        descController.text = info.desc;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideConfigViewModel,
                  builder: (c,BedsideBedsideConfigViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (nameController.text.isEmpty) {
                            EasyLoading.showToast("配置名称不能为空");
                            return;
                        }
                        if (valueController.text.isEmpty) {
                            EasyLoading.showToast("配置值不能为空");
                            return;
                        }
                        if (descController.text.isEmpty) {
                            EasyLoading.showToast("说明（描述）不能为空");
                            return;
                        }

                        String name = nameController.text;
                        String value = valueController.text;
                        String desc = descController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;

                        BedsideBedsideConfigListModelData data = BedsideBedsideConfigListModelData(
                          id: dto.id,
                            name: name,
                            value: value,
                            desc: desc,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                        );
                        model.bedsideBedsideConfigSaveUpdate(data,success: (value) {
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
