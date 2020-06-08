import 'package:flutter/material.dart';
import 'package:seekseek/ui/person/browse.dart';
import 'package:seekseek/ui/person/collect.dart';
import 'package:seekseek/ui/detail.dart';
import 'package:seekseek/ui/home.dart';
import 'package:seekseek/ui/person/identify.dart';
import 'package:seekseek/ui/preface/index.dart';
import 'package:seekseek/ui/preface/login.dart';
import 'package:seekseek/ui/person/messageCenter.dart';
import 'package:seekseek/ui/preface/modifypwd.dart';
import 'package:seekseek/ui/person/person.dart';
import 'package:seekseek/ui/person/personalEdit.dart';
import 'package:seekseek/ui/person/personalHome.dart';
import 'package:seekseek/ui/posting.dart';
import 'package:seekseek/ui/preface/register.dart';
import 'package:seekseek/ui/reply.dart';
import 'package:seekseek/ui/search.dart';
import 'package:seekseek/ui/subject.dart';
import 'package:seekseek/ui/subjectHome.dart';

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
    SubjectPage.tag:(context)=>SubjectPage(),
    SubjectHomePage.tag:(context)=>SubjectHomePage(),
    PersonPage.tag:(context)=>PersonPage(),
    PostingPage.tag:(context)=>PostingPage(),
    ReplyPage.tag:(context)=>ReplyPage(),
    CollectPage.tag:(context)=>CollectPage(),
    BrowsePage.tag:(context)=>BrowsePage(),
    MessageCenterPage.tag:(context)=>MessageCenterPage(),
    PersonalHomePage.tag:(context)=>PersonalHomePage(),
    IdentifyPage.tag:(context)=>IdentifyPage(),
    PersonalEditPage.tag:(context)=>PersonalEditPage(),
    SearchPage.tag:(context)=>SearchPage(),
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
