import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_usetime_list_model.dart';
import 'package:binance_game_app/model/radio_list_title_model.dart';
import 'package:binance_game_app/pages/hospital/widget/hospital_usetime_list.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital/bedside_bedside_hospital_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';
import 'package:binance_game_app/widget/radio_group_list.dart';


class BedsideBedsideHospitalSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidehospitalSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideHospitalSaveOrUpadtePage({this.dto});

  final BedsideBedsideHospitalViewModel _bedsideBedsideHospitalViewModel = BedsideBedsideHospitalViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController passwordController = new TextEditingController(text: "");
  final TextEditingController contactController = new TextEditingController(text: "");
  final TextEditingController phoneController = new TextEditingController(text: "");
  final TextEditingController provinceController = new TextEditingController(text: "");
  final TextEditingController cityController = new TextEditingController(text: "");
  final TextEditingController countyController = new TextEditingController(text: "");
  final TextEditingController addressController = new TextEditingController(text: "");
  final TextEditingController startTimeController = new TextEditingController(text: "");
  final TextEditingController endTimeController = new TextEditingController(text: "");
  final TextEditingController moneyController = new TextEditingController(text: "");
  final TextEditingController depositController = new TextEditingController(text: "");
  final TextEditingController minimumDepositController = new TextEditingController(text: "");
  final TextEditingController depositBannerController = new TextEditingController(text: "");
  final TextEditingController freeTrialTimeController = new TextEditingController(text: "");
  final TextEditingController sysUserIdController = new TextEditingController(text: "");
  final TextEditingController rememberTokenController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");
  final TextEditingController payTypeController = new TextEditingController(text: "0");
  final TextEditingController isDelayController = new TextEditingController(text: "1");
  final TextEditingController timeoutMinutesController = new TextEditingController(text: "");
  final TextEditingController deductionStandardController = new TextEditingController(text: "");
  final TextEditingController isDayCardController = new TextEditingController(text: "1");
  final TextEditingController isAutomaticRenewalController = new TextEditingController(text: "1");

  ValueNotifier<int>  payTypeValueNotifier = ValueNotifier<int>(0);

  ValueNotifier<int>  isDelayValueNotifier = ValueNotifier<int>(1);
  ValueNotifier<int>  isAutomaticRenewalValueNotifier = ValueNotifier<int>(1);
  ValueNotifier<int>  isDayCardValueNotifier = ValueNotifier<int>(1);

  List<BedsideBedsideHospitalUsetimeListModelData> usetimeVOS = [
    BedsideBedsideHospitalUsetimeListModelData(money: 0.0,useDay: 1,startTime: "",endTime: "")
  ];

  List<BedsideBedsideHospitalUsetimeListModelData> usetimesDayCard = [
    BedsideBedsideHospitalUsetimeListModelData(startTime: "15:00:00",endTime: "15:00:00", money: 0.0, useDay: 1)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("医院记录表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "医院名称",hintText: "请输入医院名称",textEditingController: nameController,),
              PrefixiconTextField(prefixText: "密码",hintText: "请输入密码",textEditingController: passwordController,required: false,),
              PrefixiconTextField(prefixText: "联系人",hintText: "请输入联系人",textEditingController: contactController,),
              PrefixiconTextField(prefixText: "手机号",hintText: "请输入手机号",textEditingController: phoneController,),
              PrefixiconTextField(prefixText: "省",hintText: "请输入省",textEditingController: provinceController,),
              PrefixiconTextField(prefixText: "市",hintText: "请输入市",textEditingController: cityController,),
              PrefixiconTextField(prefixText: "区县",hintText: "请输入区县",textEditingController: countyController,),
              PrefixiconTextField(prefixText: "详细地址",hintText: "请输入详细地址",textEditingController: addressController,),

              ValueListenableBuilder<int>(
                  valueListenable: payTypeValueNotifier,
                  builder: (BuildContext context, int value, Widget child) {
                      return PrefixiconTextField(prefixText: "付款方式",hintText: "",readOnly: true,suffixIcon: RadioGroupList(
                        groupValue: payTypeValueNotifier.value,
                        onChanged: (value) {
                          print("选择的数据:${value}");
                          payTypeController.text = value.toString();
                          payTypeValueNotifier.value = value;
                          if(value != 3) {
                            isAutomaticRenewalController.text = "1";
                            isAutomaticRenewalValueNotifier.value = 1;
                          }
                        },
                        list: [
                          RadioListTitleModel(value: 0,title: "按天付费"),
                          RadioListTitleModel(value: 1,title: "小时付费"),
                          RadioListTitleModel(value: 3,title: "押金按次"),
                        ],
                      ),
                    );
                  }
              ),
              ValueListenableBuilder<int>(
                valueListenable: payTypeValueNotifier,
                builder: (BuildContext context, int value, Widget child) {
                  print(value);
                  return Offstage(
                    offstage: payTypeValueNotifier.value != 3,
                    child: PrefixiconTextField(prefixText: "未还自动续费",hintText: "",readOnly: true,suffixIcon: RadioGroupList(
                        groupValue: isAutomaticRenewalValueNotifier.value,
                        onChanged: (value) {
                          print("选择的数据:${value}");
                          isAutomaticRenewalController.text = value.toString();
                          isAutomaticRenewalValueNotifier.value = value;
                          if(value == 2) {
                            isDelayController.text = "1";
                            isDelayValueNotifier.value = 1;
                          }
                        },
                        list: [
                          RadioListTitleModel(value: 1,title: "关闭"),
                          RadioListTitleModel(value: 2,title: "开启"),
                        ],
                      ),
                    ),
                  );
                },
              ),

              ValueListenableBuilder(
                valueListenable: isAutomaticRenewalValueNotifier,
                builder: (BuildContext context, int value, Widget child){
                  return Offstage(
                    offstage: isAutomaticRenewalValueNotifier.value == 2,
                    child: PrefixiconTextField(prefixText: "延时收费",hintText: "",readOnly: true,suffixIcon: ValueListenableBuilder(
                        valueListenable: isDelayValueNotifier,
                        builder: (_,__,___){
                          return RadioGroupList(
                            groupValue: isDelayValueNotifier.value,
                            onChanged: (value) {
                              print("选择的数据:${value}");
                              isDelayController.text = value.toString();
                              isDelayValueNotifier.value = value;
                            },
                            list: [
                              RadioListTitleModel(value: 1,title: "关闭"),
                              RadioListTitleModel(value: 2,title: "开启"),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

              ValueListenableBuilder<int>(
                valueListenable: isDelayValueNotifier,
                builder: (BuildContext context, int value, Widget child) {
                  print(value);
                  return Offstage(
                    offstage: isDelayValueNotifier.value == 1,
                    child: PrefixiconTextField(prefixText: "超时设置",hintText: "请输入超时设置",textEditingController: timeoutMinutesController,),
                  );
                },
              ),

              ValueListenableBuilder<int>(
                valueListenable: isDelayValueNotifier,
                builder: (BuildContext context, int value, Widget child) {
                  print(value);
                  return Offstage(
                    offstage: isDelayValueNotifier.value == 1,
                    child: PrefixiconTextField(prefixText: "扣费标准",hintText: "请输入扣费标准",textEditingController: deductionStandardController,),
                  );
                },
              ),


              ValueListenableBuilder<int>(
                valueListenable: payTypeValueNotifier,
                builder: (BuildContext context, int value, Widget child) {
                  print("保证金 = $value");
                  return Offstage(
                    offstage: payTypeValueNotifier.value == 0,
                    child: PrefixiconTextField(prefixText: "保证金",hintText: "请输入保证金",textEditingController: depositController,),
                  );
                },
              ),

              ValueListenableBuilder<int>(
                valueListenable: payTypeValueNotifier,
                builder: (BuildContext context, int value, Widget child) {
                  print("最低保证金 = $value");
                  return Offstage(
                    offstage: payTypeValueNotifier.value == 0,
                    child: PrefixiconTextField(prefixText: "最低保证金",hintText: "最低保证金",textEditingController: minimumDepositController,),
                  );
                },
              ),


              PrefixiconTextField(prefixText: "免费使用时间",hintText: "请输入免费使用时间",textEditingController: freeTrialTimeController,),

              ValueListenableBuilder<bool>(
                valueListenable: _bedsideBedsideHospitalViewModel.valueNotifier,
                builder: (BuildContext context, bool value, Widget child){
                  return HospitalUsetimeList(
                    usetimeVOS: usetimeVOS,
                  );
                },
              ),


              ValueListenableBuilder<int>(
                  valueListenable: isDayCardValueNotifier,
                  builder: (BuildContext context, int value, Widget child) {
                    return PrefixiconTextField(prefixText: "时间包段",hintText: "",readOnly: true,suffixIcon: RadioGroupList(
                        groupValue: isDayCardValueNotifier.value,
                        onChanged: (value) {
                          isDayCardController.text = value.toString();
                          isDayCardValueNotifier.value = value;
                        },
                        list: [
                          RadioListTitleModel(value: 1,title: "关闭"),
                          RadioListTitleModel(value: 2,title: "开启"),
                        ],
                      ),
                    );
                  }
              ),

              ValueListenableBuilder<int>(
                valueListenable: isDayCardValueNotifier,
                builder: (BuildContext context, int value, Widget child){
                  return Offstage(
                    offstage: isDayCardValueNotifier.value == 1,
                    child: HospitalUsetimeList(
                      usetimeVOS: usetimesDayCard,
                      suffixText: "天",
                      offstage: false,
                      onTab: false,
                      defaultTimeStr: "15:00:00",
                    ),
                  );
                },
              ),




              // PrefixiconTextField(prefixText: "是否开启自动续费",hintText: "请输入是否开启自动续费",textEditingController: isAutomaticRenewalController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideHospitalViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideHospitalInfo(dto.id,success: (BedsideBedsideHospitalListModelData info) {
                        nameController.text = info.name;
                        passwordController.text = info.password;
                        contactController.text = info.contact;
                        phoneController.text = info.phone;
                        provinceController.text = info.province;
                        cityController.text = info.city;
                        countyController.text = info.county;
                        addressController.text = info.address;
                        moneyController.text = info.money.toString();
                        depositController.text = info.deposit.toString();
                        minimumDepositController.text = info.minimumDeposit.toString();
                        depositBannerController.text = info.depositBanner;
                        freeTrialTimeController.text = info.freeTrialTime.toString();
                        sysUserIdController.text = info.sysUserId.toString();
                        rememberTokenController.text = info.rememberToken;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                        payTypeController.text = info.payType.toString();
                        isDelayController.text = info.isDelay.toString();
                        timeoutMinutesController.text = info.timeoutMinutes.toString();
                        deductionStandardController.text = info.deductionStandard.toString();
                        isDayCardController.text = info.isDayCard.toString();
                        if(info.isAutomaticRenewal != null) {
                          isAutomaticRenewalController.text = info.isAutomaticRenewal.toString();
                        }

                        isDelayValueNotifier.value = info.isDelay;
                        payTypeValueNotifier.value = info.payType;
                        print("info paytype = ${info.payType}");
                        isAutomaticRenewalValueNotifier.value = info.isAutomaticRenewal;
                        isDayCardValueNotifier.value = info.isDayCard;
                        if(info.usetimeVOS.isNotEmpty) {
                          usetimeVOS = info.usetimeVOS;
                        }
                        if(info.usetimesDayCard.isNotEmpty) {
                          usetimesDayCard = info.usetimesDayCard;
                        }
                      });
                    }
                  },
                  viewModel: _bedsideBedsideHospitalViewModel,
                  builder: (c,BedsideBedsideHospitalViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (nameController.text.isEmpty) {
                            EasyLoading.showToast("医院名称不能为空");
                            return;
                        }
                        if (contactController.text.isEmpty) {
                            EasyLoading.showToast("联系人不能为空");
                            return;
                        }
                        if (phoneController.text.isEmpty) {
                            EasyLoading.showToast("手机号不能为空");
                            return;
                        }
                        if (provinceController.text.isEmpty) {
                            EasyLoading.showToast("省不能为空");
                            return;
                        }
                        if (cityController.text.isEmpty) {
                            EasyLoading.showToast("市不能为空");
                            return;
                        }
                        if (countyController.text.isEmpty) {
                            EasyLoading.showToast("区县不能为空");
                            return;
                        }
                        if (addressController.text.isEmpty) {
                            EasyLoading.showToast("详细地址不能为空");
                            return;
                        }

                        if (freeTrialTimeController.text.isEmpty) {
                            EasyLoading.showToast("免费使用时间不能为空");
                            return;
                        }
                        if (payTypeController.text.isEmpty) {
                            EasyLoading.showToast("付款方式不能为空");
                            return;
                        }

                        if (isDayCardController.text.isEmpty) {
                          EasyLoading.showToast("是否开启时间包段不能为空");
                          return;
                        }

                        String name = nameController.text;
                        String password = passwordController.text;
                        String contact = contactController.text;
                        String phone = phoneController.text;
                        String province = provinceController.text;
                        String city = cityController.text;
                        String county = countyController.text;
                        String address = addressController.text;
                        String money = moneyController.text;
                        String deposit = depositController.text;
                        String minimumDeposit = minimumDepositController.text;
                        String depositBanner = depositBannerController.text;
                        String freeTrialTime = freeTrialTimeController.text;
                        String sysUserId = sysUserIdController.text;
                        String rememberToken = rememberTokenController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;
                        String payType = payTypeController.text;
                        String isDelay = isDelayController.text;
                        String timeoutMinutes = timeoutMinutesController.text;
                        String deductionStandard = deductionStandardController.text;
                        String isDayCard = isDayCardController.text;
                        String isAutomaticRenewal = isAutomaticRenewalController.text;

                        BedsideBedsideHospitalListModelData data = BedsideBedsideHospitalListModelData(
                          id: dto.id,
                            name: name,
                            password: password,
                            contact: contact,
                            phone: phone,
                            province: province,
                            city: city,
                            county: county,
                            address: address,
                            money: money.isEmpty ? null : double.parse(money),
                            deposit: deposit.isEmpty ? null : double.parse(deposit),
                            minimumDeposit: minimumDeposit.isEmpty ? null : double.parse(minimumDeposit),
                            depositBanner: depositBanner,
                            freeTrialTime: freeTrialTime.isEmpty ? null : int.parse(freeTrialTime),
                            sysUserId: sysUserId.isEmpty ? null : int.parse(sysUserId),
                            rememberToken: rememberToken,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                            payType: payType.isEmpty ? null : int.parse(payType),
                            isDelay: isDelay.isEmpty ? null : int.parse(isDelay),
                            timeoutMinutes: timeoutMinutes.isEmpty ? null : int.parse(timeoutMinutes),
                            deductionStandard: deductionStandard.isEmpty ? null : double.parse(deductionStandard),
                            isDayCard: isDayCard.isEmpty ? null : int.parse(isDayCard),
                            isAutomaticRenewal: isAutomaticRenewal.isEmpty ? null : int.parse(isAutomaticRenewal),
                            hospitalUsetimes: usetimeVOS,
                            hospitalUsetimesDayCard: usetimesDayCard,
                            usetimeVOS: usetimeVOS,
                            usetimesDayCard: usetimesDayCard
                        );

                        model.bedsideBedsideHospitalSaveUpdate(data,success: (value) {
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
