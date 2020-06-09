import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/ui/subject.dart';

import 'browse.dart';
import 'identify.dart';
import 'messageCenter.dart';
import 'personalEdit.dart';
import 'personalHome.dart';
import 'collect.dart';
import '../home.dart';

import 'package:seekseek/main.dart';

class PersonPage extends StatefulWidget {
  static String tag = 'person-page';
  @override
  _PersonPageState createState() => new _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  final controller = TextEditingController();

  int _currentIndex = 2;
  List<Widget> pagelist = List();

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  List result;
  String userName;
  String followCount;
  String fansCount;
  String subjectCount;
  String postCount;

  getUser() async {
    var responseBody;
//    print("user" + MyApp.userId.toString());
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
//        print(responseBody);
      if (result[1].toString() != null || result[1].toString() != "") {
        userName = result[1].toString() + "";
      }
//        print(postsCtime);
    } else {
      print("error");
    }
    setState(() {
      userName = result[1].toString() + "";
    });
  }

  getFollowCount() async {
    Dio dio = new Dio();
    Response response;
    response = await dio.get(
      "http://101.132.157.72:8084/follow/getCount?userId=" +
          MyApp.userId.toString(),
    );
    if (response.statusCode == 200) {
      followCount = response.toString();
//      print("follow" + followCount);
    } else {
      print("error");
    }
//    setState(() {});
  }

  getFansCount() async {
    Dio dio = new Dio();
    Response response;
    response = await dio.get(
      "http://101.132.157.72:8084/follow/getSlaveCount?userId=" +
          MyApp.userId.toString(),
    );
    if (response.statusCode == 200) {
      fansCount = response.toString();
//      print("fans" + fansCount);
    } else {
      print("error");
    }
//    setState(() {});
  }

  getSubjectCount() async {
    Dio dio = new Dio();
    Response response;
    response = await dio.get(
      "http://101.132.157.72:8084/subject/getCount?userId=" +
          MyApp.userId.toString(),
    );
    if (response.statusCode == 200) {
      subjectCount = response.toString();
//      print("subject" + subjectCount);
    } else {
      print("error");
    }
//    setState(() {});
  }

  getPostCount() async {
    Dio dio = new Dio();
    Response response;
    response = await dio.get(
      "http://101.132.157.72:8084/posts/getListForMe/count?userId=" +
          MyApp.userId.toString(),
    );
    if (response.statusCode == 200) {
      postCount = response.toString();
//      print("post" + postCount);
    } else {
      print("error");
    }
//    setState(() {});
  }

  @override
  void initState() {
//  导航栏页面
    pagelist..add(HomePage())..add(SubjectPage())..add(PersonPage());
    super.initState();
    userName = "用户名";
    followCount = "0";
    fansCount = "0";
    subjectCount = "0";
    postCount = "0";
    getUser();
    getFollowCount();
    getFansCount();
    getSubjectCount();
    getPostCount();
  }

  final List<BottomNavigationBarItem> _list = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
      //backgroundColor: Colors.orange
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book),
      title: Text('专业圈'),
      //backgroundColor: Colors.orange
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('我的'),
      //backgroundColor: Colors.orange
    ),
  ];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

//TODO 页内实时加载
    getUser();
    getFollowCount();
    getFansCount();
    getSubjectCount();
    getPostCount();

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
//      color: Colors.blueAccent,
            child: Padding(
              padding:
                  EdgeInsets.only(left: 35, top: 20, bottom: 15, right: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      userName,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Colors.blueAccent),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: GestureDetector(
                        child: Text(
                          "查看个人主页 >",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(PersonalHomePage.tag);
                        }),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: (width - 70) * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                followCount,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Text(
                              "关注",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (width - 70) * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                fansCount,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Text(
                              "粉丝",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (width - 70) * 0.25,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                subjectCount,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Text(
                              "关注的圈子",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (width - 70) * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text(
                                postCount,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            Text(
                              "帖子",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
        Padding(
            padding: EdgeInsets.only(left: 35, top: 30, bottom: 15, right: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                      child: Text(
                        "我的收藏",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(CollectPage.tag);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                      child: Text(
                        "浏览历史",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(BrowsePage.tag);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                      child: Text(
                        "消息中心",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(MessageCenterPage.tag);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                      child: Text(
                        "教师认证",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(IdentifyPage.tag);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                      child: Text(
                        "个人信息",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed(PersonalEditPage.tag);
                      }),
                ),
              ],
            )),
      ],
    );

    void onTabTapped(int index) {
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return pagelist[index];
      }));
      print(index);
      setState(() {
        _currentIndex = index;
      });
    }

    return new Scaffold(
      resizeToAvoidBottomInset: false, //固定页面不上移
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: _list,
      ),
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
