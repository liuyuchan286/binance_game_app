import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';

class RadioListTitle<T> extends StatelessWidget {

  final T groupValue;
  final T value;
  final String title;
  final ValueChanged<T> onChanged;


  RadioListTitle({
    @required this.groupValue,
    @required this.value,
    @required this.title,
    @required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Radio(
            value: value,
            groupValue: groupValue,
            onChanged: this.onChanged,
          ),
          width: 17.w,
          height: 17.h,
        ),
        SizedBox(width: 4.w,),
        Text(this.title,
          style: Theme.of(context).textTheme.headline2.copyWith(color: ThemeColors.COLOR_333333),
        ),
        SizedBox(width: 14.w,),
      ],
    );
  }
}
