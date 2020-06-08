import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/entity/post.dart';
import 'package:seekseek/ui/detail.dart';

import '../../main.dart';

class IdentifyPage extends StatefulWidget {
  static String tag = 'identify-page';
  @override
  _IdentifyPageState createState() => new _IdentifyPageState();
}

class _IdentifyPageState extends State<IdentifyPage> {
  final controller = TextEditingController();

  var _selectType;
  String _name,_code,_school;
  int _sex;
  int _subject;

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  @override
  void initState() {
    super.initState();
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
              "教师认证",
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
            hintText: '真实姓名',
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

    final snoInput = Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child: new TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        decoration: new InputDecoration(
            hintText: '工号',
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

    final schoolInput = new Padding(
        padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
        child: new Container(
          decoration: BoxDecoration(
            border: new Border.all(width: 1,color: Color(0xff9d9d9d)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              items: [
                new DropdownMenuItem(
                  child: new Padding(padding: new EdgeInsets.only(left: 20.0),child: Text('浙江大学'),),
                  value: "浙江大学",
                ),
                new DropdownMenuItem(
                  child: new Padding(padding: new EdgeInsets.only(left: 20.0),child: Text('浙大城市学院'),),
                  value: "浙大城市学院",
                ),
              ],
              hint: new Text('     学校',style: new TextStyle(color: Colors.grey),),
              onChanged: (value){
                setState(() {
//                  _selectType = value;
                  _school = value;
                });
              },
              value: _school,
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

    final subjectInput = new Padding(
        padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
        child: new Container(
          decoration: BoxDecoration(
            border: new Border.all(width: 1,color: Color(0xff9d9d9d)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: new DropdownButtonHideUnderline(
            child: new DropdownButton(
              items: [
                new DropdownMenuItem(
                  child: new Padding(padding: new EdgeInsets.only(left: 20.0),child: Text('大数据圈'),),
                  value: 1,
                ),
                new DropdownMenuItem(
                  child: new Padding(padding: new EdgeInsets.only(left: 20.0),child: Text('计算机圈'),),
                  value: 2,
                ),
                new DropdownMenuItem(
                  child: new Padding(padding: new EdgeInsets.only(left: 20.0),child: Text('软件工程圈'),),
                  value: 3,
                ),
                new DropdownMenuItem(
                  child: new Padding(padding: new EdgeInsets.only(left: 20.0),child: Text('自动化圈'),),
                  value: 4,
                ),
                new DropdownMenuItem(
                  child: new Padding(padding: new EdgeInsets.only(left: 20.0),child: Text('土木工程圈'),),
                  value: 5,
                ),
              ],
              hint: new Text('     专业圈',style: new TextStyle(color: Colors.grey),),
              onChanged: (value){
                setState(() {
//                  _selectType = value;
                  _subject = value;
                });
              },
              value: _subject,
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


    final submmit = new Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child: new MaterialButton(
        color: Colors.blueAccent,
        height: 48.0,
        onPressed: (){

        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: new Text('保  存  并  修  改',style: new TextStyle(color: Colors.white),),
      ),
    );

    final  tip = new Center(
      child: new Text('一旦提交不可修改，请谨慎填写',style: new TextStyle(color: Colors.grey),),
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
          snoInput,
          SizedBox(height: 30.0,),
          schoolInput,
          SizedBox(height: 30.0,),
          subjectInput,
          SizedBox(height: 50.0,),
          submmit,
          SizedBox(height: 30.0,),
          tip,
          SizedBox(
            height: 45.0,
          ),
        ],
      ),
    );
  }
}