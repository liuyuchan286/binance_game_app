import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';

class ListClickTextButton extends StatelessWidget {

  final bool isSelect;
  final String buttonText;

  final VoidCallback onPressed;


  ListClickTextButton(this.buttonText,{
    this.isSelect = false,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    Color foregroundColor = ThemeColors.COLOR_666666;
    Color sideColor = ThemeColors.COLOR_CDCDCD;
    Color otherColor = Colors.white;
    if(isSelect) {
      foregroundColor = ThemeColors.COLOR_539FF6;
      sideColor = foregroundColor;
      otherColor = sideColor.withOpacity(0.1);
    }


    return Theme(
      data: Theme.of(context).copyWith(
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(Theme.of(context).textTheme.headline3.copyWith(
              color: foregroundColor,
            )),
            foregroundColor:  MaterialStateProperty.all(foregroundColor),
            shadowColor: MaterialStateProperty.all(otherColor),
            overlayColor: MaterialStateProperty.all(otherColor),
            backgroundColor: MaterialStateProperty.all(otherColor),
            shape: MaterialStateProperty.all(StadiumBorder()),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 15.w,vertical: 6.h)),
            side: MaterialStateProperty.all(BorderSide(color: sideColor)),
          ),
        )
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10.w),
        height: 30.h,
        child: TextButton(
          onPressed: this.onPressed,
          child: Text(this.buttonText),
        ),
      ),
    );
  }
}
