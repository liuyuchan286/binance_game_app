import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_user_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_user/bedside_bedside_user_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideUserSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideuserSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideUserSaveOrUpadtePage({this.dto});

  final BedsideBedsideUserViewModel _bedsideBedsideUserViewModel = BedsideBedsideUserViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController aliUserIdController = new TextEditingController(text: "");
  final TextEditingController openidController = new TextEditingController(text: "");
  final TextEditingController unionidController = new TextEditingController(text: "");
  final TextEditingController nicknameController = new TextEditingController(text: "");
  final TextEditingController avatarController = new TextEditingController(text: "");
  final TextEditingController genderController = new TextEditingController(text: "");
  final TextEditingController typeController = new TextEditingController(text: "");
  final TextEditingController moneyController = new TextEditingController(text: "");
  final TextEditingController numberController = new TextEditingController(text: "");
  final TextEditingController phoneNumberController = new TextEditingController(text: "");
  final TextEditingController mobileController = new TextEditingController(text: "");
  final TextEditingController countryCodeController = new TextEditingController(text: "");
  final TextEditingController countryController = new TextEditingController(text: "");
  final TextEditingController provinceController = new TextEditingController(text: "");
  final TextEditingController cityController = new TextEditingController(text: "");
  final TextEditingController brandController = new TextEditingController(text: "");
  final TextEditingController modelController = new TextEditingController(text: "");
  final TextEditingController versionController = new TextEditingController(text: "");
  final TextEditingController systemController = new TextEditingController(text: "");
  final TextEditingController platformController = new TextEditingController(text: "");
  final TextEditingController sdkVersionController = new TextEditingController(text: "");
  final TextEditingController ipController = new TextEditingController(text: "");
  final TextEditingController latitudeController = new TextEditingController(text: "");
  final TextEditingController longitudeController = new TextEditingController(text: "");
  final TextEditingController isAuthController = new TextEditingController(text: "");
  final TextEditingController isMobileController = new TextEditingController(text: "");
  final TextEditingController isLocationController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController sourceController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户记录表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "支付宝唯一标识",hintText: "请输入支付宝唯一标识",textEditingController: aliUserIdController,),
              PrefixiconTextField(prefixText: "用户唯一标识",hintText: "请输入用户唯一标识",textEditingController: openidController,),
              PrefixiconTextField(prefixText: "用户在微信开放平台的唯一标识符",hintText: "请输入用户在微信开放平台的唯一标识符",textEditingController: unionidController,),
              PrefixiconTextField(prefixText: "用户昵称",hintText: "请输入用户昵称",textEditingController: nicknameController,),
              PrefixiconTextField(prefixText: "用户头像",hintText: "请输入用户头像",textEditingController: avatarController,),
              PrefixiconTextField(prefixText: "性别 0：未知、1：男、2：女",hintText: "请输入性别 0：未知、1：男、2：女",textEditingController: genderController,),
              PrefixiconTextField(prefixText: "类型 1-客户端用户 2-运维端用户",hintText: "请输入类型 1-客户端用户 2-运维端用户",textEditingController: typeController,),
              PrefixiconTextField(prefixText: "累计消费金额",hintText: "请输入累计消费金额",textEditingController: moneyController,),
              PrefixiconTextField(prefixText: "累计使用次数",hintText: "请输入累计使用次数",textEditingController: numberController,),
              PrefixiconTextField(prefixText: "用户绑定的手机号（国外手机号会有区号）",hintText: "请输入用户绑定的手机号（国外手机号会有区号）",textEditingController: phoneNumberController,),
              PrefixiconTextField(prefixText: "没有区号的手机号",hintText: "请输入没有区号的手机号",textEditingController: mobileController,),
              PrefixiconTextField(prefixText: "区号",hintText: "请输入区号",textEditingController: countryCodeController,),
              PrefixiconTextField(prefixText: "用户所在国家",hintText: "请输入用户所在国家",textEditingController: countryController,),
              PrefixiconTextField(prefixText: "用户所在省份",hintText: "请输入用户所在省份",textEditingController: provinceController,),
              PrefixiconTextField(prefixText: "用户所在城市",hintText: "请输入用户所在城市",textEditingController: cityController,),
              PrefixiconTextField(prefixText: "手机品牌",hintText: "请输入手机品牌",textEditingController: brandController,),
              PrefixiconTextField(prefixText: "手机型号",hintText: "请输入手机型号",textEditingController: modelController,),
              PrefixiconTextField(prefixText: "微信版本号",hintText: "请输入微信版本号",textEditingController: versionController,),
              PrefixiconTextField(prefixText: "操作系统版本",hintText: "请输入操作系统版本",textEditingController: systemController,),
              PrefixiconTextField(prefixText: "客户端平台",hintText: "请输入客户端平台",textEditingController: platformController,),
              PrefixiconTextField(prefixText: "客户端基础库版本",hintText: "请输入客户端基础库版本",textEditingController: sdkVersionController,),
              PrefixiconTextField(prefixText: "ip地址",hintText: "请输入ip地址",textEditingController: ipController,),
              PrefixiconTextField(prefixText: "纬度",hintText: "请输入纬度",textEditingController: latitudeController,),
              PrefixiconTextField(prefixText: "经度",hintText: "请输入经度",textEditingController: longitudeController,),
              PrefixiconTextField(prefixText: "是否获取手机信息 1-未获取 2-已获取",hintText: "请输入是否获取手机信息 1-未获取 2-已获取",textEditingController: isAuthController,),
              PrefixiconTextField(prefixText: "是否获取过用户信息 1-未获取 2-已获取",hintText: "请输入是否获取过用户信息 1-未获取 2-已获取",textEditingController: isMobileController,),
              PrefixiconTextField(prefixText: "是否授权过地理定位 1-否 2-是",hintText: "请输入是否授权过地理定位 1-否 2-是",textEditingController: isLocationController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "",hintText: "请输入",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "来源 1 微信  2支付宝",hintText: "请输入来源 1 微信  2支付宝",textEditingController: sourceController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideUserViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideUserInfo(dto.id,success: (BedsideBedsideUserListModelData info) {
                        aliUserIdController.text = info.aliUserId;
                        openidController.text = info.openid;
                        unionidController.text = info.unionid;
                        nicknameController.text = info.nickname;
                        avatarController.text = info.avatar;
                        genderController.text = info.gender.toString();
                        typeController.text = info.type.toString();
                        moneyController.text = info.money.toString();
                        numberController.text = info.number.toString();
                        phoneNumberController.text = info.phoneNumber;
                        mobileController.text = info.mobile;
                        countryCodeController.text = info.countryCode;
                        countryController.text = info.country;
                        provinceController.text = info.province;
                        cityController.text = info.city;
                        brandController.text = info.brand;
                        modelController.text = info.model;
                        versionController.text = info.version;
                        systemController.text = info.system;
                        platformController.text = info.platform;
                        sdkVersionController.text = info.sdkVersion;
                        ipController.text = info.ip;
                        latitudeController.text = info.latitude;
                        longitudeController.text = info.longitude;
                        isAuthController.text = info.isAuth.toString();
                        isMobileController.text = info.isMobile.toString();
                        isLocationController.text = info.isLocation.toString();
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        sourceController.text = info.source.toString();
                      });
                    }
                  },
                  viewModel: _bedsideBedsideUserViewModel,
                  builder: (c,BedsideBedsideUserViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (aliUserIdController.text.isEmpty) {
                            EasyLoading.showToast("支付宝唯一标识不能为空");
                            return;
                        }
                        if (openidController.text.isEmpty) {
                            EasyLoading.showToast("用户唯一标识不能为空");
                            return;
                        }
                        if (unionidController.text.isEmpty) {
                            EasyLoading.showToast("用户在微信开放平台的唯一标识符不能为空");
                            return;
                        }
                        if (nicknameController.text.isEmpty) {
                            EasyLoading.showToast("用户昵称不能为空");
                            return;
                        }
                        if (avatarController.text.isEmpty) {
                            EasyLoading.showToast("用户头像不能为空");
                            return;
                        }
                        if (genderController.text.isEmpty) {
                            EasyLoading.showToast("性别 0：未知、1：男、2：女不能为空");
                            return;
                        }
                        if (typeController.text.isEmpty) {
                            EasyLoading.showToast("类型 1-客户端用户 2-运维端用户不能为空");
                            return;
                        }
                        if (moneyController.text.isEmpty) {
                            EasyLoading.showToast("累计消费金额不能为空");
                            return;
                        }
                        if (numberController.text.isEmpty) {
                            EasyLoading.showToast("累计使用次数不能为空");
                            return;
                        }
                        if (phoneNumberController.text.isEmpty) {
                            EasyLoading.showToast("用户绑定的手机号（国外手机号会有区号）不能为空");
                            return;
                        }
                        if (mobileController.text.isEmpty) {
                            EasyLoading.showToast("没有区号的手机号不能为空");
                            return;
                        }
                        if (countryCodeController.text.isEmpty) {
                            EasyLoading.showToast("区号不能为空");
                            return;
                        }
                        if (countryController.text.isEmpty) {
                            EasyLoading.showToast("用户所在国家不能为空");
                            return;
                        }
                        if (provinceController.text.isEmpty) {
                            EasyLoading.showToast("用户所在省份不能为空");
                            return;
                        }
                        if (cityController.text.isEmpty) {
                            EasyLoading.showToast("用户所在城市不能为空");
                            return;
                        }
                        if (brandController.text.isEmpty) {
                            EasyLoading.showToast("手机品牌不能为空");
                            return;
                        }
                        if (modelController.text.isEmpty) {
                            EasyLoading.showToast("手机型号不能为空");
                            return;
                        }
                        if (versionController.text.isEmpty) {
                            EasyLoading.showToast("微信版本号不能为空");
                            return;
                        }
                        if (systemController.text.isEmpty) {
                            EasyLoading.showToast("操作系统版本不能为空");
                            return;
                        }
                        if (platformController.text.isEmpty) {
                            EasyLoading.showToast("客户端平台不能为空");
                            return;
                        }
                        if (sdkVersionController.text.isEmpty) {
                            EasyLoading.showToast("客户端基础库版本不能为空");
                            return;
                        }
                        if (ipController.text.isEmpty) {
                            EasyLoading.showToast("ip地址不能为空");
                            return;
                        }
                        if (latitudeController.text.isEmpty) {
                            EasyLoading.showToast("纬度不能为空");
                            return;
                        }
                        if (longitudeController.text.isEmpty) {
                            EasyLoading.showToast("经度不能为空");
                            return;
                        }
                        if (isAuthController.text.isEmpty) {
                            EasyLoading.showToast("是否获取手机信息 1-未获取 2-已获取不能为空");
                            return;
                        }
                        if (isMobileController.text.isEmpty) {
                            EasyLoading.showToast("是否获取过用户信息 1-未获取 2-已获取不能为空");
                            return;
                        }
                        if (isLocationController.text.isEmpty) {
                            EasyLoading.showToast("是否授权过地理定位 1-否 2-是不能为空");
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
                        if (sourceController.text.isEmpty) {
                            EasyLoading.showToast("来源 1 微信  2支付宝不能为空");
                            return;
                        }

                        String aliUserId = aliUserIdController.text;
                        String openid = openidController.text;
                        String unionid = unionidController.text;
                        String nickname = nicknameController.text;
                        String avatar = avatarController.text;
                        String gender = genderController.text;
                        String type = typeController.text;
                        String money = moneyController.text;
                        String number = numberController.text;
                        String phoneNumber = phoneNumberController.text;
                        String mobile = mobileController.text;
                        String countryCode = countryCodeController.text;
                        String country = countryController.text;
                        String province = provinceController.text;
                        String city = cityController.text;
                        String brand = brandController.text;
                        String mmodel = modelController.text;
                        String version = versionController.text;
                        String system = systemController.text;
                        String platform = platformController.text;
                        String sdkVersion = sdkVersionController.text;
                        String ip = ipController.text;
                        String latitude = latitudeController.text;
                        String longitude = longitudeController.text;
                        String isAuth = isAuthController.text;
                        String isMobile = isMobileController.text;
                        String isLocation = isLocationController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String source = sourceController.text;

                        BedsideBedsideUserListModelData data = BedsideBedsideUserListModelData(
                          id: dto.id,
                            aliUserId: aliUserId,
                            openid: openid,
                            unionid: unionid,
                            nickname: nickname,
                            avatar: avatar,
                            gender: gender.isEmpty ? null : int.parse(gender),
                            type: type.isEmpty ? null : int.parse(type),
                            money: money.isEmpty ? null : double.parse(money),
                            number: number.isEmpty ? null : int.parse(number),
                            phoneNumber: phoneNumber,
                            mobile: mobile,
                            countryCode: countryCode,
                            country: country,
                            province: province,
                            city: city,
                            brand: brand,
                            model: mmodel,
                            version: version,
                            system: system,
                            platform: platform,
                            sdkVersion: sdkVersion,
                            ip: ip,
                            latitude: latitude,
                            longitude: longitude,
                            isAuth: isAuth.isEmpty ? null : int.parse(isAuth),
                            isMobile: isMobile.isEmpty ? null : int.parse(isMobile),
                            isLocation: isLocation.isEmpty ? null : int.parse(isLocation),
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            source: source.isEmpty ? null : int.parse(source),
                        );
                        model.bedsideBedsideUserSaveUpdate(data,success: (value) {
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
