import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';


class PrefixiconTextField extends StatelessWidget {

  final String hintText;
  final String prefixText;
  final TextEditingController textEditingController;
  final bool readOnly;
  final bool required;
  final bool obscureText;
  final Widget suffixIcon;
  final double horizontal;
  final int maxLines;
  final GestureTapCallback onTap;

  PrefixiconTextField({this.hintText, this.prefixText, this.textEditingController,this.readOnly=false,this.required=true,this.obscureText,this.suffixIcon,this.horizontal,this.maxLines,this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.end,
      controller: textEditingController,
      readOnly: readOnly,
      onTap: () {
        if(this.onTap != null) {
          this.onTap();
        }
      },
      obscureText: obscureText ?? false,
      style: Theme.of(context).textTheme.headline3.copyWith(fontSize: 14.ssp),
      maxLines: this.maxLines ?? 1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: this.horizontal ?? 15.w,vertical: 15.h),
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: Row(
          children: [
            SizedBox(width: 15.w,),
            Text("${required ? '*' : ''}",
              style: Theme.of(context).textTheme.headline2.copyWith(
                  color: ThemeColors.COLOR_FF5454
              ),
            ),
            Text(prefixText,
              style: Theme.of(context).textTheme.headline2.copyWith(
                  color: ThemeColors.COLOR_333333,
              ),
            )
          ],
        ),
        prefixIconConstraints: BoxConstraints(
          maxWidth: 150.w,
          minWidth: 150.w,
          minHeight: 20.h,
          maxHeight: 20.h,
        )
      ),
    );
  }
}
