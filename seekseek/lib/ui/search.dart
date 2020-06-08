import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/ui/subject.dart';

class SearchPage extends StatefulWidget {
  static String tag = 'search-page';
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  @override
  void initState() {
//  导航栏页面
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            width: width,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                width: 3,
                color: Color(0xffeeeeee),
              )),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 25, top: 20, bottom: 20),
                        child: Container(
                          width: width * 0.75,
                          decoration: BoxDecoration(
                            color: Color(0xffeeeeee),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      left: 20),
                                  child: TextField(
                                    controller: controller,
                                    decoration: new InputDecoration(
                                        contentPadding: EdgeInsets.only(top: 0.0),
                                        hintText: '搜索',
                                        border: InputBorder.none),
                                    // onChanged: onSearchTextChanged,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 20),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    print("search");
//                                请求
                                  }),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          child: Text('取消',
                              style: new TextStyle(color: Colors.blueAccent, fontSize: 14)),
                          onTap: () {
                            print("cancel");
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: width * 0.333,
                        child: Text(
                          "帖子",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                      Container(
                        width: width * 0.333,
                        child: Text(
                          "圈子",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                      Container(
                        width: width * 0.333,
                        child: Text(
                          "用户",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ],
    );

    return new Scaffold(
      resizeToAvoidBottomInset: false, //固定页面不上移
      backgroundColor: Colors.white,
//      body: pagelist[_currentIndex],
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          content,
          SizedBox(
            height: 45.0,
          ),
//        pagelist[_currentIndex],
        ],
      ),
    );
  }
}
