import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seekseek/entity/user.dart';
import 'package:seekseek/main.dart';
import 'package:seekseek/ui/modifypwd.dart';
import 'package:seekseek/ui/register.dart';
import 'package:oktoast/oktoast.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _selectType;

  var resultJson = "";
  String _phone, _password;

  @override
  void initState() {
    super.initState();
  }

  AlertDialog dialog = new AlertDialog(
    content: new Text(
      "登陆失败：输入不能为空",
      style: new TextStyle(fontSize: 16.0, color: Colors.red),
    ),
  );

  AlertDialog dialog2 = new AlertDialog(
    content: new Text(
      "登陆失败：用户名或密码错误",
      style: new TextStyle(fontSize: 16.0, color: Colors.red),
    ),
  );

  login() async {
//    var responseBody;
    try {
      print('登录中');
      Response response;
      Dio dio = new Dio();
      response = await dio.post("http://101.132.157.72:8084/user/login",data: {
        "userPhone":_phone,
        "userPwd":generateMd5(_password),
      }, );
      if (response.statusCode == 200) {
        print(response);
//        responseBody = await response.transform(utf8.decoder).join();
//        responseBody = json.decode(responseBody);
        Map map = response.data as Map;
        int userId = map.values.toList()[0];
        MyApp.userId = userId;
        print(MyApp.userId);
        Navigator.pop(context);
        Navigator.of(context).pushNamed(HomePage.tag);
      } else {
        print(response);
      }
    } catch (exception) {
      print('exc:$exception');
    }
    setState(() {});
  }

  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    print(hex.encode(digest.bytes));
    return hex.encode(digest.bytes);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final logo = new Image.asset(
      "assets/images/name.png",
      height: 140.0,
      alignment: Alignment.center,
    );

    final phoneInput = new TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      initialValue: '',
      decoration: new InputDecoration(
          hintText: '手机号',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
          )
      ),
      onChanged: (value){
        setState(() {
          _phone = value;
        });
      },
//      onSaved
    );

    final passwordInput = new TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration:  new InputDecoration(
          hintText: '密码',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0)
          )
      ),
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
//      onSaved
    );

    final  modify =new FlatButton(
      onPressed: (){
        Navigator.of(context).pushNamed(ModifypwdPage.tag);
      },
      child: new Text('修 改 密 码', style: new TextStyle(color: Colors.grey),),
    );

    final loginButton = new Padding(
      padding: new EdgeInsets.symmetric(vertical: 16.0),
      child: new MaterialButton(
        color: Colors.blueAccent,
        height: 48.0,
        onPressed: (){
//          showToast("hello world");
          login();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: new Text('登      录',style: new TextStyle(color: Colors.white),),
      ),
    );

    final  register = new FlatButton(
      onPressed: (){
        Navigator.of(context).pushNamed(RegisterPage.tag);
      },
      child: new Text('注      册',style: new TextStyle(color: Colors.blueAccent),),
    );

    return new Scaffold(
      resizeToAvoidBottomInset:false,
      backgroundColor: Colors.white,
      body:new ListView(
      shrinkWrap: true,
      padding: new EdgeInsets.only(left: 50.0,right: 50.0),
      children: <Widget>[
        SizedBox(height: 150.0),
        logo,
        SizedBox(height: 30.0,),
        phoneInput,
        SizedBox(height: 30.0,),
        passwordInput,
//        codeInput,
        SizedBox(height: 30.0,),
//        codeimg,
        modify,
        loginButton,
        register,
      ],
    ),
    );
  }
}