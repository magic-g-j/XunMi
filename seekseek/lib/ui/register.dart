import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seekseek/main.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String imgurl ="http://101.132.157.72:8084/user/verifyCode?"+ DateTime.now().millisecondsSinceEpoch.toString();

  var _selectType;

  var resultJson = "";
  String _name,_phone, _password,_words,_code;
  int _sex;

  @override
  void initState() {
    super.initState();
  }

  register() async {
    try {
      print('注册中');
      Response response;
      Dio dio = new Dio();
      response = await dio.post("http://101.132.157.72:8084/user/register",data: {
        "userName":_name,
        "userPhone":_phone,
        "userPassword":generateMd5(_password),
        "userSex":_sex,
        "userWords":_words,
        "verifyCode":_code,
      }, );
      if (response.statusCode == 200 ) {
        print(response);
        Navigator.pop(context);
//        Navigator.of(context).pushNamed(HomePage.tag);
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
              "注册账号",
              style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
            ),
            onTap: () {
            },
          ),
          centerTitle: true,
        ));

    final nameInput = Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child: new TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        decoration: new InputDecoration(
            hintText: '用户名',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value){
          setState(() {
            _name = value;
          });
        },
//      onSaved
      ),
    );

    final sex = new Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child: new Container(
        decoration: BoxDecoration(
            border: new Border(
              top: BorderSide(width: 1,color: Color(0xff9d9d9d)),
              left: BorderSide(width: 1,color: Color(0xff9d9d9d)),
              right: BorderSide(width: 1,color: Color(0xff9d9d9d)),
              bottom: BorderSide(width: 1,color: Color(0xff9d9d9d)),
            ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: new DropdownButtonHideUnderline(
          child: new DropdownButton(
            items: [
              new DropdownMenuItem(
                child: new Padding(padding: new EdgeInsets.only(left: 20.0),child: Text('男'),),
                value: 0,
              ),
              new DropdownMenuItem(
                child: new Padding(padding: new EdgeInsets.only(left: 20.0),child: Text('女'),),
                value: 1,
              ),
            ],
            hint: new Text('     性别',style: new TextStyle(color: Colors.grey),),
            onChanged: (value){
              setState(() {
                _selectType = value;
                _sex = value;
              });
            },
            value: _selectType,
            style: new TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            iconSize: 30.0,
            isDense: false,
          ),
        ),
      )
    );

    final words = new Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0),
      child:  new TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        decoration: new InputDecoration(
            hintText: '设置个性签名……',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value){
          setState(() {
            _words = value;
          });
        },
      ),
    );


    final phoneInput = Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child: new TextFormField(
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
      ),
    );

    final passwordInput = Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child:  new TextFormField(
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
      ),
    );

    final codeInput = new Container(
      width: 175.0,
      child: TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        decoration: new InputDecoration(
            hintText: '请输入验证码',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value){
          setState(() {
            _code = value;
          });
        },
//      onSaved
      ),
    );

    var codeimg = Image(image: new NetworkImage(imgurl),height: 40.0);

    final registerBtn = new Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child: new MaterialButton(
        color: Colors.blueAccent,
        height: 48.0,
        onPressed: (){
          register();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: new Text('注     册',style: new TextStyle(color: Colors.white),),
      ),
    );

    final  tip = new Center(
      child: new Text('个人信息不可修改，请谨慎填写',style: new TextStyle(color: Colors.grey),),
    );

    return new Scaffold(
      resizeToAvoidBottomInset:false, //固定页面不上移
      backgroundColor: Colors.white,
      body: new ListView(
        shrinkWrap: true,
        padding: new EdgeInsets.only(left: 0.0,right: 0.0,top: 0.0),
        children: <Widget>[
          SizedBox(height: 0.0,),
          title,
          SizedBox(height: 50.0,),
          nameInput,
          SizedBox(height: 30.0,),
          sex,
          SizedBox(height: 30.0,),
          words,
          SizedBox(height: 30.0,),
          phoneInput,
          SizedBox(height: 30.0,),
          passwordInput,
          SizedBox(height: 30.0,),
          new Padding(
            padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
            child:  new Row(
              children: <Widget>[
                codeInput,
                Listener(
                  child: codeimg,
                  onPointerUp: (event){
                    print("click img");
                    setState(() {
                      this.imgurl = "http://101.132.157.72:8084/user/verifyCode?"+ DateTime.now().millisecondsSinceEpoch.toString();
                      print(imgurl);
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 50.0,),
          registerBtn,
          SizedBox(height: 30.0,),
          tip
        ],
        ),
    );
  }
}