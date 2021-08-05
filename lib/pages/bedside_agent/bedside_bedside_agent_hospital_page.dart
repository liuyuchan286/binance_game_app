import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_agent_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_agent_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_list_model.dart';
import 'package:binance_game_app/pages/bedside_agent/widget/bedside_bedside_agent_hospital_table_column.dart';
import 'package:binance_game_app/view_model/bedside_bedside_agent/bedside_bedside_agent_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_agent_hospital/bedside_bedside_agent_hospital_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital/bedside_bedside_hospital_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';



class BedsideBedsideAgentHospitalPage extends StatelessWidget {

  SaveOrUpdateDto dto;


  BedsideBedsideAgentHospitalPage({this.dto});

  static const routeName = '/bedsideagentHospitalPage';

  final BedsideBedsideAgentViewModel _bedsideBedsideAgentViewModel = BedsideBedsideAgentViewModel();

  final BedsideBedsideHospitalViewModel _bedsideBedsideHospitalViewModel = BedsideBedsideHospitalViewModel();

  final BedsideBedsideAgentHospitalViewModel _bedsideBedsideAgentHospitalViewModel = BedsideBedsideAgentHospitalViewModel();




  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController typeController = new TextEditingController(text: "1");
  final TextEditingController contactController = new TextEditingController(text: "");
  final TextEditingController phoneController = new TextEditingController(text: "");
  final TextEditingController passwordController = new TextEditingController(text: "");
  final TextEditingController addressController = new TextEditingController(text: "");
  final TextEditingController moneyController = new TextEditingController(text: "");
  final TextEditingController rememberTokenController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");
  final TextEditingController sysUserIdController = new TextEditingController(text: "");
  final TextEditingController withdrawableMoneyController = new TextEditingController(text: "");
  final TextEditingController withdrawnMoneyController = new TextEditingController(text: "");
  final TextEditingController totalRevenueMoneyController = new TextEditingController(text: "");
  final TextEditingController tobeCreditedMoneyController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle =
    Theme.of(context).textTheme.headline1.copyWith(fontSize: 14.ssp);

    final TextStyle lineStyle = Theme.of(context).textTheme.headline5;

    return Scaffold(
      appBar: AppBar(
        title: Text("代理医院",
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

              PrefixiconTextField(prefixText: "代理商名称",hintText: "请输入代理商名称",textEditingController: nameController,readOnly: true,),
              PrefixiconTextField(prefixText: "医院"),
              ProviderWidget(
                viewModel: _bedsideBedsideHospitalViewModel,
                init: (BedsideBedsideHospitalViewModel model) {
                },
                builder: (c,BedsideBedsideHospitalViewModel model,_){
                  if(model.loading) {
                    return CupertinoActivityIndicator();
                  }
                  return BedsideBedsideAgentHospitalTableColumn(titleStyle: titleStyle, lineStyle: lineStyle,
                    listData: _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalListModelDatas,
                    selectsId: _bedsideBedsideAgentViewModel.hospitalIds,
                  );
                },
              ),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideAgentViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideAgentInfo(dto.id,success: (BedsideBedsideAgentListModelData info) {
                        nameController.text = info.name;
                        typeController.text = info.type.toString();
                        contactController.text = info.contact;
                        phoneController.text = info.phone;
                        passwordController.text = info.password;
                        addressController.text = info.address;
                        moneyController.text = info.money.toString();
                        rememberTokenController.text = info.rememberToken;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                        sysUserIdController.text = info.sysUserId.toString();
                        withdrawableMoneyController.text = info.withdrawableMoney.toString();
                        withdrawnMoneyController.text = info.withdrawnMoney.toString();
                        totalRevenueMoneyController.text = info.totalRevenueMoney.toString();
                        tobeCreditedMoneyController.text = info.tobeCreditedMoney.toString();
                        model.bedsideBedsideagenthospitalListByAgentId(dto.id,success: (value){

                          _bedsideBedsideHospitalViewModel.bedsideBedsideHospitalListAll();
                        });
                      });
                    }
                  },
                  viewModel: _bedsideBedsideAgentViewModel,
                  builder: (c,BedsideBedsideAgentViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                        EasyLoading.show(status: "保存中");
                        BedsideBedsideAgentHospitalListModelData data = BedsideBedsideAgentHospitalListModelData(
                          agentId: dto.id,
                          hospitalIds: _bedsideBedsideAgentViewModel.hospitalIds
                        );
                        _bedsideBedsideAgentHospitalViewModel.bedsideBedsideAgentHospitalSaveUpdate(data,success: (value){
                          EasyLoading.dismiss();
                          Navigator.pop<String>(context);
                        },error: (err){
                          EasyLoading.dismiss();
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
