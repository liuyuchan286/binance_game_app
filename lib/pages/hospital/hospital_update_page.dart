import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/model/radio_list_title_model.dart';
import 'package:binance_game_app/pages/hospital/widget/hospital_usetime_list.dart';
import 'package:binance_game_app/widget/only_data_noborder_text_field.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/radio_group_list.dart';
import 'package:binance_game_app/widget/radio_list_title.dart';

class HospitalUpdatePage extends StatelessWidget {

  static const routeName = '/hospitalUpdatePage';

  final TextEditingController hospitalNameController = new TextEditingController(text: "长春圣心积善医院");
  final TextEditingController contactController = new TextEditingController(text: "程瑶");
  final TextEditingController phoneController = new TextEditingController(text: "18677572737");
  final TextEditingController addressController = new TextEditingController(text: "吉林省长春市绿园区");
  final TextEditingController detailController = new TextEditingController(text: "吉林省长春市绿园区吉林大学");
  final TextEditingController moneyController = new TextEditingController(text: "1000");
  final TextEditingController timeController = new TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("医院管理-修改",
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
              PrefixiconTextField(prefixText: "医院名称",hintText: "请输入原密码",textEditingController: hospitalNameController,),
              PrefixiconTextField(prefixText: "密码",hintText: "请输入密码",required: false,),
              PrefixiconTextField(prefixText: "联系人",hintText: "请输入联系人",textEditingController: contactController,),
              PrefixiconTextField(prefixText: "手机号",hintText: "请输入手机号",textEditingController: phoneController,),
              PrefixiconTextField(prefixText: "地区",hintText: "请输入地区",textEditingController: addressController,),
              PrefixiconTextField(prefixText: "详细地址",hintText: "请输入详细地址",textEditingController: detailController,),
              PrefixiconTextField(prefixText: "付款方式",hintText: "",readOnly: true,suffixIcon: RadioGroupList(
                  groupValue: 1,
                  onChanged: (value) {
                    print("选择的数据:${value}");
                  },
                  list: [
                    RadioListTitleModel(value: 1,title: "按天付费"),
                    RadioListTitleModel(value: 2,title: "小时付费"),
                    RadioListTitleModel(value: 3,title: "押金按次"),
                  ],
                ),
              ),
              PrefixiconTextField(prefixText: "延时收费",hintText: "",readOnly: true,suffixIcon: RadioGroupList(
                  groupValue: 1,
                  onChanged: (value) {
                    print("选择的数据:${value}");
                  },
                  list: [
                    RadioListTitleModel(value: 1,title: "关闭"),
                    RadioListTitleModel(value: 2,title: "开启"),
                  ],
                ),
              ),

              PrefixiconTextField(prefixText: "保证金",hintText: "请输入保证金",textEditingController: moneyController,),
              PrefixiconTextField(prefixText: "免费使用时间（分）",hintText: "请输入免费使用时间（分）",textEditingController: timeController,),

              HospitalUsetimeList(),

              PrefixiconTextField(prefixText: "时间包段",hintText: "",readOnly: true,suffixIcon: RadioGroupList(
                groupValue: 1,
                onChanged: (value) {
                  print("选择的数据:${value}");
                },
                list: [
                  RadioListTitleModel(value: 1,title: "关闭"),
                  RadioListTitleModel(value: 2,title: "开启"),
                ],
              ),
              ),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: TextButton(
                  onPressed: (){},
                  child: Text(
                      "确定"
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
