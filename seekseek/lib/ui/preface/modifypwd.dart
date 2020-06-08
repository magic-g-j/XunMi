import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seekseek/common/toastHelper.dart';
import 'package:seekseek/ui/preface/login.dart';

import 'package:seekseek/main.dart';

import '../home.dart';

class ModifypwdPage extends StatefulWidget {
  static String tag = 'modifypwd-page';
  @override
  _ModifypwdPageState createState() => new _ModifypwdPageState();
}

class _ModifypwdPageState extends State<ModifypwdPage> {
  var _selectType;

  var resultJson = "";

  String _phone, _password, _newPassword;

  @override
  void initState() {
    super.initState();
  }

  modifyPwd() async {
//    var responseBody;
    try {
      print('登录中');
      Response response, response2;
      Dio dio = new Dio();
      if (_phone == null || _password == null ||  _newPassword == null) {
        ToastHelper.showToast(context, "修改失败：手机号或密码不能为空");
      }
      response = await dio.post(
        "http://101.132.157.72:8084/user/login",
        data: {
          "userPhone": _phone,
          "userPwd": generateMd5(_password),
        },
      );
      if (response.statusCode == 200) {
//        responseBody = await response.transform(utf8.decoder).join();
//        responseBody = json.decode(responseBody);
        print(response);
        if (response.toString() == "" &&
            _phone != null &&
            _password != null &&
            _phone != "" &&
            _password != "") {
          ToastHelper.showToast(context, "修改失败：手机号或原密码错误");
        }
        else if (response.toString() == "" &&
            (_phone == null ||
                _password == null ||  _newPassword == null ||
                _phone == "" ||
                _password == "" ||  _newPassword == "")) {
          ToastHelper.showToast(context, "修改失败：手机号或密码不能为空");
        }
        else{
          Map map = response.data as Map;
          int userId = map.values.toList()[0];
          print('修改中');
          response2 = await dio.post(
            "http://101.132.157.72:8084/user/modify/password",
            data: {
              "userId": userId,
              "userPhone": _phone,
              "userOldPassword": generateMd5(_password),
              "userPassword": generateMd5(_newPassword),
            },
          );
          print(response2.toString());
          if (response2.statusCode == 200 && response2.toString() == "true") {
            ToastHelper.showToast(context, "修改成功");
//          Navigator.pop(context);
//          Navigator.of(context).pushNamed(LoginPage.tag);
          }
          if (response2.statusCode == 200 && response2.toString() == "false") {
            ToastHelper.showToast(context, "修改失败");
//          Navigator.pop(context);
//          Navigator.of(context).pushNamed(LoginPage.tag);
          }
        }
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
    final title = new PreferredSize(
        child: AppBar(
      elevation: 3,
      backgroundColor: Colors.white,
      title: InkWell(
        child: Text(
          "修改密码",
          style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
        ),
        onTap: () {},
      ),
      centerTitle: true,
    ));

    final phoneInput = Padding(
      padding: new EdgeInsets.only(left: 50.0, right: 50.0, top: 0.0),
      child: new TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        decoration: new InputDecoration(
            hintText: '手机号',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onChanged: (value) {
          setState(() {
            _phone = value;
          });
        },
//      onSaved
      ),
    );

    final passwordInput = Padding(
      padding: new EdgeInsets.only(left: 50.0, right: 50.0, top: 0.0),
      child: new TextFormField(
        autofocus: false,
        initialValue: '',
        obscureText: true,
        decoration: new InputDecoration(
            hintText: '请输入原密码',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
//      onSaved
      ),
    );

    final passwordInput2 = Padding(
      padding: new EdgeInsets.only(left: 50.0, right: 50.0, top: 0.0),
      child: new TextFormField(
        autofocus: false,
        initialValue: '',
        obscureText: true,
        decoration: new InputDecoration(
            hintText: '请输入新密码',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0))),
        onChanged: (value) {
          setState(() {
            _newPassword = value;
          });
        },
//      onSaved
      ),
    );

    final modify = new Padding(
      padding: new EdgeInsets.only(left: 50.0, right: 50.0, top: 0.0),
      child: new MaterialButton(
        color: Colors.blueAccent,
        height: 48.0,
        onPressed: () {
          modifyPwd();
//          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: new Text(
          '保 存 并 修 改',
          style: new TextStyle(color: Colors.white),
        ),
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        shrinkWrap: true,
        padding: new EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
        children: <Widget>[
          title,
          SizedBox(
            height: 50.0,
          ),
          phoneInput,
          SizedBox(
            height: 30.0,
          ),
          passwordInput,
          SizedBox(
            height: 30.0,
          ),
          passwordInput2,
          SizedBox(
            height: 50.0,
          ),
          modify,
        ],
      ),
    );
  }
}
