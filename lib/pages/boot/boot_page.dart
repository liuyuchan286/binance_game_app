import 'package:flutter/material.dart';


class BootPage extends StatelessWidget {

  static const routeName = '/bootPage';

  const BootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Image.asset("assets/images/boot_page.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
