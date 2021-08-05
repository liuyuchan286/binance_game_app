import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/pages/hospital/hospital_update_page.dart';
import 'package:binance_game_app/pages/index/index_page.dart';
import 'package:binance_game_app/pages/login/login_page.dart';
import 'package:binance_game_app/pages/order/order_list_page.dart';
import 'package:binance_game_app/pages/reset_pwd/reset_pwd.dart';
import 'package:binance_game_app/utils/cache_util.dart';

import 'constant/routes.dart';
import 'pages/boot/boot_page.dart';

void main() {
  // debugProfileBuildsEnabled = true;
  runApp(MyApp());
}
//全局跳转
final GlobalKey<NavigatorState> globalKey = GlobalKey();

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("MyApp buld");
    try {
      if (Platform.isAndroid) {
        // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
        SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.white);
        SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
      }
    }catch(e) {

    }
    return ScreenUtilInit(
      designSize: Size(375, 750),
      builder: () => MaterialApp(
        title: '蒜伴管理后台',
        builder: EasyLoading.init(),
        navigatorKey: globalKey,
        theme: ThemeData(
          cardTheme: CardTheme(
            elevation: 0.0,
            margin: EdgeInsets.zero,
            color: Colors.white,
          ),
          checkboxTheme: CheckboxThemeData(
            shape: CircleBorder()
          ),
          //字体样式
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 16.0.ssp, fontWeight: FontWeight.w500,color: ThemeColors.COLOR_333333),
            headline2: TextStyle(fontSize: 14.0.ssp, fontWeight: FontWeight.w400,color: ThemeColors.COLOR_999999),
            headline3: TextStyle(fontSize: 12.0.ssp, fontWeight: FontWeight.w400,color: ThemeColors.COLOR_333333),
            headline4: TextStyle(fontSize: 16.0.ssp, fontWeight: FontWeight.w400,color: ThemeColors.COLOR_F96164),
            headline5: TextStyle(fontSize: 14.0.ssp, fontWeight: FontWeight.w400,color: ThemeColors.COLOR_333333),


            bodyText2: TextStyle(fontSize: 22.0.ssp, fontWeight: FontWeight.w400),
            button: TextStyle(fontSize: 16.ssp),
          ),
          //appbar样式
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0.0,
            //设置appbar title的全局样式
            textTheme: TextTheme(
              headline6: TextStyle(fontSize: 17.0.ssp, fontWeight: FontWeight.w500,color: ThemeColors.COLOR_030303),
            ),
          ),
          //按钮组样式
          buttonBarTheme: ButtonBarThemeData(
            alignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
          ),
          //按钮样式
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(ThemeColors.COLOR_539FF6),
              shape: MaterialStateProperty.all(StadiumBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 11.h)),
            ),
          ),
          //输入框样式
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            prefixStyle:TextStyle(
              fontSize: 14.ssp,
            ),
            suffixStyle:TextStyle(
              fontSize: 14.ssp,
            ),
            counterStyle:TextStyle(
              fontSize: 14.ssp,
            ),
            errorStyle:TextStyle(
              fontSize: 14.ssp,
            ),
            hintStyle: TextStyle(
              fontSize: 14.ssp,
            ),
            labelStyle: TextStyle(
              fontSize: 14.ssp,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ThemeColors.COLOR_E2E2E2,
                width: 1.0.h
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ThemeColors.COLOR_E2E2E2,
                width: 1.0.h,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: ThemeColors.COLOR_E2E2E2,
                width: 1.0.h,
              ),
            )
          ),
          hintColor: ThemeColors.COLOR_999999,
          primaryColor: Colors.white,
          //scaffold的北京颜色
          scaffoldBackgroundColor: ThemeColors.COLOR_F8F9FA,
        ),
        //路由拦截
        onGenerateRoute:  onGenerateRoute,
        //初始化的路由
        // initialRoute: BootPage.routeName,
        //取消debugbanner
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          const Locale('zh', 'CN'), //设置语言为中文
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: AnimatedSwitcher(
          duration: Duration(seconds: 2),
          child: FutureBuilder(
            future: getInitPage(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: {
                  return BootPage();
                }
                case ConnectionState.done:
                case ConnectionState.active: {
                  if(snapshot.hasData) {
                    return snapshot.data;
                  }else {
                    return LoginPage();
                  }
                }
              }
            },
          ),
          
        ),
      ),
    );
  }


  Future<Widget> getInitPage() async {
    await Future.delayed(Duration(seconds: 2));
    String token = await CacheUtil.getData<String>("token");
    print("token = ${token}");
    if(token == null || token == null) {
      return LoginPage();
    }
    return IndexPage();
  }

}