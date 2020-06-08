import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/entity/subject.dart';
import 'package:seekseek/ui/person/person.dart';
import 'package:seekseek/ui/search.dart';
import 'package:seekseek/ui/subjectHome.dart';

import '../main.dart';
import 'home.dart';

class SubjectPage extends StatefulWidget {
  static String tag = 'subject-page';
  @override
  _SubjectPageState createState() => new _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final controller = TextEditingController();

  int _currentIndex = 1;
  List<Widget> pagelist = List();

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  @override
  void initState() {
//  导航栏页面
    pagelist
      ..add(HomePage())
      ..add(SubjectPage())
      ..add(PersonPage());
    super.initState();
    getSubjects();
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

  List subjects = [];
  int index = 0;
  getSubjects() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/subject/getList?userId='+MyApp.userId.toString();
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      subjects = responseBody;
      print(subjects);
    } else {
      print("error");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final search = GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Container(
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding:
                  EdgeInsets.only(left: 20, top: 8, right: 10, bottom: 8),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                Text('搜索',
                    style: new TextStyle(color: Colors.black54, fontSize: 14)),
              ],
            )),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(SearchPage.tag);
      },
    );

    final title = new Container(
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
          padding: EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
          child: Text(
            "关注的圈子",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          )),
    );

    final list = new Container(
      height: height - 230,
      child: new ListView.builder(
//          保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: subjects == null ? 0 : subjects.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: (){
                Navigator.of(context).pushNamed(SubjectHomePage.tag,arguments: subjectEntity(subjects[i]['attentionSubid'],subjects[i]['attentionSubject']));
              },
              child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Color(0xffeeeeee),
                        )),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    child: Container(
                      width: width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 160,
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: 20, right: 20),
//                            学科
                              child: Text(subjects[i]['attentionSubject'].toString(),
//                                color: Colors.blueAccent, fontWeight: FontWeight.w700,
                                  style: new TextStyle(fontSize: 16)),
                            ),
                          ),
//                          圈子的关注数
//                          Padding(
//                            padding:
//                            EdgeInsets.only(left: 20, bottom: 6, right: 20),
////                            用户名
//                            child: Text( "20"+"个人关注",style: new TextStyle(fontSize: 12, color: Colors.grey)),
//                          ),
                        ],
                      ),
                    ),
                  )
              ),
            );
          }),
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
          search,
          title,
          list,
          SizedBox(
            height: 45.0,
          ),
//        pagelist[_currentIndex],
        ],
      ),
    );
  }
}
