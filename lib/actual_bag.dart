import 'package:binance_game_app/utils/cache_util.dart';
import 'package:flutter/material.dart';

class ActualBagPage extends StatefulWidget {
  const ActualBagPage({Key key}) : super(key: key);

  @override
  _ActualBagPageState createState() => _ActualBagPageState();
}

class _ActualBagPageState extends State<ActualBagPage> {

  String key1 = "app Bar;";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("${key1}"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("get key1"),
            onPressed: () async {
              String bindData_key1 = await CacheUtil.getData<String>('bindData_key1');
              setState(() {
                key1 = bindData_key1;
              });
            },
          ),
        ),
      ),
    );
  }
}
