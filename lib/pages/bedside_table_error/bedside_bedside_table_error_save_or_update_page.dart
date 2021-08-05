import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_table_error_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_table_error/bedside_bedside_table_error_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideTableErrorSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidetableerrorSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideTableErrorSaveOrUpadtePage({this.dto});

  final BedsideBedsideTableErrorViewModel _bedsideBedsideTableErrorViewModel = BedsideBedsideTableErrorViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController deviceIdController = new TextEditingController(text: "");
  final TextEditingController numberController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设备绑定错误记录表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "设备编号",hintText: "请输入设备编号",textEditingController: deviceIdController,),
              PrefixiconTextField(prefixText: "二维码编号",hintText: "请输入二维码编号",textEditingController: numberController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: updatedAtController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideTableErrorViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideTableErrorInfo(dto.id,success: (BedsideBedsideTableErrorListModelData info) {
                        deviceIdController.text = info.deviceId;
                        numberController.text = info.number;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideTableErrorViewModel,
                  builder: (c,BedsideBedsideTableErrorViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (deviceIdController.text.isEmpty) {
                            EasyLoading.showToast("设备编号不能为空");
                            return;
                        }
                        if (numberController.text.isEmpty) {
                            EasyLoading.showToast("二维码编号不能为空");
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

                        String deviceId = deviceIdController.text;
                        String number = numberController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;

                        BedsideBedsideTableErrorListModelData data = BedsideBedsideTableErrorListModelData(
                          id: dto.id,
                            deviceId: deviceId,
                            number: number,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                        );
                        model.bedsideBedsideTableErrorSaveUpdate(data,success: (value) {
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
