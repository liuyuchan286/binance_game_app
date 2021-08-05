import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/model/radio_list_title_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/radio_group_list.dart';
import 'package:binance_game_app/widget/radio_list_title.dart';


class OnlyDataNoborderTextField extends StatelessWidget {

  final String hintText;

  final String suffixText;

  final double width;

  final TextEditingController controller;

  final bool readOnly;

  final GestureTapCallback onTap;

  OnlyDataNoborderTextField({
    this.hintText,
    this.suffixText,
    this.width,
    this.controller,
    this.readOnly = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {

    Widget child = TextField(
      onTap: () => onTap(),
      controller: controller,
      readOnly: readOnly,
      style: Theme.of(context).textTheme.headline5,
      scrollPadding: EdgeInsets.zero,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hintText ?? '无',
        suffixText: suffixText ?? "",
      ),
    );

    if (width == null) {
      child = Expanded(
        child: child,
      );
    }else {
      child = Container(
        width: width,
        child: child,
      );
    }
    return Theme(
      data: ThemeData(
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
      child: child,
    );
  }
}
