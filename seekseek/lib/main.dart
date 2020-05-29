import 'package:flutter/material.dart';
import 'package:seekseek/ui/detail.dart';
import 'package:seekseek/ui/home.dart';
import 'package:seekseek/ui/index.dart';
import 'package:seekseek/ui/login.dart';
import 'package:seekseek/ui/modifypwd.dart';
import 'package:seekseek/ui/register.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  static int userId = 0;

  final routes = <String,WidgetBuilder>{
    IndexPage.tag:(context)=>IndexPage(),
    LoginPage.tag:(context)=>LoginPage(),
    RegisterPage.tag:(context)=>RegisterPage(),
    ModifypwdPage.tag:(context)=>ModifypwdPage(),
    HomePage.tag:(context)=>HomePage(),
    DetailPage.tag:(context)=>DetailPage(),
//    QuestionPage.tag:(context)=>QuestionPage(),
//    AnswerPage.tag:(context)=>AnswerPage(),
//    DetailPage.tag:(context)=>DetailPage(),
//    TestPage.tag:(context)=>TestPage(),
//    QuestionList.tag(context)=>QuestionList(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Seek Seek',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: new IndexPage(),
      routes: routes,
    );
  }
}
