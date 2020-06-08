import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/common/toastHelper.dart';

import '../../main.dart';

class PersonalEditPage extends StatefulWidget {
  static String tag = 'personalEdit-page';
  @override
  _PersonalEditPageState createState() => new _PersonalEditPageState();
}

class _PersonalEditPageState extends State<PersonalEditPage> {
  final controller = TextEditingController();

  var _selectType;

  List result;
  String name,sex,words;
  String newName,newWords;
  int newSex;

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  getUser() async {
    var responseBody;
    print("user" + MyApp.userId.toString());
    var url = 'http://101.132.157.72:8084/user/getOne?userId=' +
        MyApp.userId.toString();
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      Map map = responseBody as Map;
      result = map.values.toList();
//        print(result);
      if(result[1].toString()!=null || result[1].toString()!=""){
        name = result[1].toString()+"";
      }
      if(result[3]==0){
        sex = "男";
      }
      if(result[3]==1){
        sex = "女";
      }
      if(result[1].toString()!=null || result[1].toString()!=""){
        words = result[5].toString()+"";
      }

//        print(postsCtime);
    } else {
      print("error");
    }
    setState(() {});
  }

  modify() async {
    try {
      Response response;
      Dio dio = new Dio();
//      Dio dio = new Dio(options);
      if(newName ==null || newName=="" || newSex == null || newWords ==null || newWords==""){
//        newName = name;
//        newSex = result[3];
//        newWords = words;
        ToastHelper.showToast(context, "内容不能为空");
      }
      else{
        response = await dio.post("http://101.132.157.72:8084/user/modify/msg",data: {
          "userId":MyApp.userId,
          "userName":newName,
//          后续要删掉
//          "userPhone":result[2],
          "userSex":newSex,
          "userWords":newWords,
        }, );
        if (response.statusCode == 200) {
          print("modify"+response.toString());
          ToastHelper.showToast(context, "修改成功");
//          Map map = response.data as Map;
//          result = map.values.toList();
          Navigator.pop(context);
        }
      }
    } catch (exception) {
      print('exc:$exception');
    }
//    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    name = "用户名";
    sex = "性别";
    words = "这个人什么都没写";
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final title = new PreferredSize(
        child: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: InkWell(
            child: Text(
              "个人信息",
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
            hintText: name,
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value){
          setState(() {
            newName = value;
          });
        },
//      onSaved
      ),
    );

    final sexInput = new Padding(
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
              hint: new Text('     '+sex,style: new TextStyle(color: Colors.grey),),
              onChanged: (value){
                setState(() {
                  _selectType = value;
                  newSex = value;
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

    final wordsInput = new Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0),
      child:  new TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        decoration: new InputDecoration(
            hintText: words,
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value){
          setState(() {
            newWords = value;
          });
        },
      ),
    );

    final edit = new Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child: new MaterialButton(
        color: Colors.blueAccent,
        height: 48.0,
        onPressed: (){
          modify();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: new Text('保  存  并  修  改',style: new TextStyle(color: Colors.white),),
      ),
    );

    return new Scaffold(
      resizeToAvoidBottomInset: false, //固定页面不上移
      backgroundColor: Colors.white,
//      body: pagelist[_currentIndex],
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          title,
          SizedBox(height: 50.0,),
          nameInput,
          SizedBox(height: 30.0,),
          sexInput,
          SizedBox(height: 30.0,),
          wordsInput,
          SizedBox(height: 50.0,),
          edit,
          SizedBox(
            height: 45.0,
          ),
        ],
      ),
    );
  }
}