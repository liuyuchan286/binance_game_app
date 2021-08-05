import 'package:flutter/material.dart';
import 'package:binance_game_app/model/radio_list_title_model.dart';
import 'package:binance_game_app/widget/radio_list_title.dart';

class RadioGroupList<T> extends StatefulWidget {

  T groupValue;
  List<RadioListTitleModel> list;
  final ValueChanged onChanged;

  RadioGroupList({this.groupValue,this.list,this.onChanged});

  @override
  _RadioGroupListState<T> createState() => _RadioGroupListState<T>();
}

class _RadioGroupListState<T> extends State<RadioGroupList<T>> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (RadioListTitleModel model in widget.list)
        RadioListTitle(
          groupValue: widget.groupValue,
          value: model.value,
          title: model.title,
          onChanged: (value) {
            setState(() {
              widget.groupValue = value;
              widget.onChanged(value);
            });
          },
        ),
      ],
    );
  }
}
