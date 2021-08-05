import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/model/sys_menu_nav_model.dart';
import 'package:binance_game_app/pages/login/login_page.dart';
import 'package:binance_game_app/pages/reset_pwd/reset_pwd.dart';
import 'package:binance_game_app/utils/cache_util.dart';
import 'package:binance_game_app/view_model/sys_menu/sys_menu_view_model.dart';
import 'package:binance_game_app/view_model/sys_user/sys_user_view_model.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';

class IndexPage extends StatelessWidget {

  static const routeName = '/indexPage';

  SysUserViewModel _sysUserViewModel = SysUserViewModel();

  SysMenuViewModel _sysMenuViewModel = SysMenuViewModel();

  @override
  Widget build(BuildContext context) {
    print("index page build");
    return Scaffold(
      appBar: AppBar(
        title: Text("管理后台",
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 15.w),
        child: ListView(
          cacheExtent: 2000,
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 10.w),
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 15.r,
                      minRadius: 15.r,
                      backgroundImage: NetworkImage("https://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTLz6XElOL5V5aecI2SLPS3vjRO7GD9WibmqNz7FyWdvhFbJIia1V5QlZB1HaRibt9HOpJiaDg7Q1DpDZQ/132"),
                    ),
                    SizedBox(width: 6.w,),
                    ProviderWidget(
                      viewModel: _sysUserViewModel,
                      init: (SysUserViewModel model) {
                        model.initUserInfo();
                      },
                      builder: (c,SysUserViewModel model,_) {
                        print("ProviderWidget build");
                        return AnimatedSwitcher(
                          duration: Duration(seconds: 1),
                          child: model.loading ?
                          CupertinoActivityIndicator() :
                          Text(model.sysUserInfoModel.username, style: Theme.of(context).textTheme.headline1,)
                        );
                      }
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context,ResetPwd.routeName,arguments: _sysUserViewModel.sysUserInfoModel.username);
                      },
                      child: Text("修改密码",
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                    SizedBox(width: 4.w,),
                    Container(
                      width: 8.w,
                      height: 13.h,
                      child: Image.asset("assets/images/more.png",fit: BoxFit.cover,),
                    )

                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h,),
            Card(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
                child: ProviderWidget(
                  viewModel: _sysMenuViewModel,
                  init: (SysMenuViewModel model) {
                    model.initSysMenuNav();
                  },
                  builder: (c,SysMenuViewModel model,_) {
                    return AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: model.loading ?
                      CupertinoActivityIndicator() :
                      Column(
                        children: [
                          for (SysMenuNavModel item in model.list)
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(item.name,
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                              SizedBox(height: 15.h,),
                              Container(
                                width: double.infinity,
                                // color: Colors.red,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  spacing: 30.w,
                                  runSpacing: 22.h,
                                  children: [
                                    for (SysMenuNavModel lastItem in item.list)
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context,"/${lastItem.appIcon}Page");
                                        },
                                        child: Column(
                                          children: [
                                            Image.asset(lastItem.appIcon != null ? "assets/images/${lastItem.appIcon}.png" : "assets/images/default_${lastItem.menuId % 4 + 1}.png",
                                              width: 40.w,
                                              height: 40.h,
                                              errorBuilder: (BuildContext context, Object error, StackTrace stackTrace) {
                                                return Image.asset("assets/images/default_${lastItem.menuId % 4 + 1}.png");
                                              },
                                            ),
                                            SizedBox(height: 4.h,),
                                            Container(
                                              child: Text(lastItem.name,
                                                style: Theme.of(context).textTheme.headline3,
                                                maxLines: 2,
                                                overflow: TextOverflow.visible,
                                              ),
                                              width: 50.w,
                                            )
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h,),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h,),
            Card(
              child: InkWell(
                onTap: () {
                  EasyLoading.show(
                    maskType: EasyLoadingMaskType.black,
                    dismissOnTap: true,
                  );

                  CacheUtil.removeData<String>("token").then((flag){
                    if (flag) {
                      EasyLoading.dismiss();
                      Navigator.pushNamedAndRemoveUntil(context, LoginPage.routeName,(Route<dynamic> route) => false);
                    }else {
                      EasyLoading.showToast("退出失败");
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 44.h,
                  child: Text("退出登录",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h,),
          ],
        ),
      ),
    );
  }
}
