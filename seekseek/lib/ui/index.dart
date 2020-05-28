import 'package:flutter/material.dart';
import 'package:seekseek/ui/login.dart';

class IndexPage extends StatefulWidget {
  static String tag = 'index-page';
  @override
  _IndexPageState createState() => new _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final cover = new Image.asset(
        "assets/images/cover.png",
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.fitHeight,
    );

    return Listener(
      child: cover,
      onPointerUp: (event) {
        Navigator.pop(context);
        Navigator.of(context).pushNamed(LoginPage.tag);
      },
    );

    return new Scaffold(
      backgroundColor: Colors.white,

      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          cover,
        ],
      ),
    );
  }
}