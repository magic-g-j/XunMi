import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/entity/post.dart';
import 'package:seekseek/entity/subject.dart';
import 'package:seekseek/ui/detail.dart';
import 'package:seekseek/ui/subjectHome.dart';

import 'package:seekseek/main.dart';

class PersonalHomePage extends StatefulWidget {
  static String tag = 'personalHome-page';
  @override
  _PersonalHomePageState createState() => new _PersonalHomePageState();
}

class _PersonalHomePageState extends State<PersonalHomePage> {
  final controller = TextEditingController();

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  List result;
  String userName;
  String sex;
  String userWords;
  String followCount;
  String fansCount;
  String subjectCount;
  String postCount;

  Color cTimeSortColor, updateTimeSortColor;

//  bool test1Flag=true,test2Flag=true;
  bool hidden1,
      hidden2,
      hidden3,
      hidden40,
      hidden41,
      hidden42,
      hiddenIdentity,
      hiddenFollowBtn,
      hiddenFollows,
      hiddenFans;

  String followText;

  List follows = [];
  List fans = [];
  List subjects = [];
  List posts = [];
  List posts2 = [];

  getUser() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/user/getOne?userId=' +
        MyApp.userId.toString();
    var httpClient = new HttpClient();
//    print("user"+MyApp.userId.toString()+url);
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      Map map = responseBody as Map;
      result = map.values.toList();
//        print(responseBody);
//      print("name"+result[1].toString());
      if (result[1].toString() != null || result[1].toString() != "") {
        userName = result[1].toString() + "";
      }
      if (result[3] == 0) {
        sex = "男";
      }
      if (result[3] == 1) {
        sex = "女";
      }
      if (result[4] == 0) {
//        教师认证（请求）
      }
      if (result[4] == 1) {
//        教师认证（请求）
      }
      if (result[5].toString() != null || result[5].toString() != "") {
        userWords = result[5].toString() + "";
      }
//        print(postsCtime);
    } else {
      print("error");
    }
    setState(() {});
  }

  getFollow() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/follow/getMasters?userId=' +
        MyApp.userId.toString();
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      follows = responseBody;
//      print("follow");
//      print(follows);
    } else {
      print("error");
    }
    setState(() {});
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
//      print("follow"+followCount);
    } else {
      print("error");
    }
    setState(() {});
  }

  getFans() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/follow/getSlaves?userId=' +
        MyApp.userId.toString();
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      fans = responseBody;
//      print("fans");
//      print(fans);
    } else {
      print("error");
    }
    setState(() {});
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
//      print("fans"+fansCount);
    } else {
      print("error");
    }
    setState(() {});
  }

  getSubject() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/subject/getList?userId=' +
        MyApp.userId.toString();
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      subjects = responseBody;
//      print(subjects);
    } else {
      print("error");
    }
    setState(() {});
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
//      print("subject"+subjectCount);
    } else {
      print("error");
    }
    setState(() {});
  }

  getPosts() async {
    var responseBody;
    var url =
        'http://101.132.157.72:8084/posts/getListForMe/createTime?userId=' +
            MyApp.userId.toString();
//    print("post"+MyApp.userId.toString()+url);
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      posts = responseBody;
//      print(posts);
    } else {
      print("error");
    }
    setState(() {});
  }

  getPosts2() async {
    var responseBody;
    var url =
        'http://101.132.157.72:8084/posts/getListForMe/updateTime?userId=' +
            MyApp.userId.toString();
//    print("post"+MyApp.userId.toString()+url);
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      posts2 = responseBody;
//      print(posts);
    } else {
      print("error");
    }
    setState(() {
      posts2 = responseBody;
    });
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
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
//    test1Flag=true;
//    test2Flag=true;
    hidden1 = true;
    hidden2 = true;
    hidden3 = true;
    hidden40 = true;
    hidden41 = true;
    hidden42 = true;
    hiddenIdentity = true;
    hiddenFollowBtn = false;
    hiddenFollows = true;
    hiddenFans = true;
//    需改为变量
    followText = "关注";
    userName = "用户名";
    sex = "性别";
    userWords = "这个人什么都没写";
    followCount = "0";
    fansCount = "0";
    subjectCount = "0";
    postCount = "0";
    cTimeSortColor = Colors.orange;
    updateTimeSortColor = Colors.grey;
    getSubject();
    getUser();
    getFollow();
    getFollowCount();
    getFans();
    getFansCount();
    getSubject();
    getSubjectCount();
    getPosts();
    getPosts2();
    getPostCount();
  }

//  int index = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

//TODO 页内实时加载
    getSubject();
    getUser();
    getFollow();
    getFollowCount();
    getFans();
    getFansCount();
    getSubject();
    getSubjectCount();
    getPosts();
    getPosts2();
    getPostCount();

    final title = new PreferredSize(
        child: AppBar(
      elevation: 3,
      backgroundColor: Colors.white,
      title: InkWell(
        child: Text(
          "个人主页",
          style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
        ),
        onTap: () {},
      ),
      centerTitle: true,
    ));

//    final test1 = Offstage(
//      offstage: test1Flag,//这里控制
//      child: Container(color: Colors.blue,height: 100.0,),
//    );
//    final test2 = Offstage(
//      offstage: test2Flag, //这里控制
//      child: Container(color: Colors.blue,height: 100.0,),
//    );

    final followsList = Offstage(
      offstage: hidden1, //这里控制
      child: Container(
        height: height - 295,
        child: new ListView.builder(
//          保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: follows == null ? 0 : follows.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
//                  Navigator.of(context).pushNamed(SubjectHomePage.tag,
//                      arguments: subjectEntity(subjects[i]['subjectId'],
//                          subjects[i]['subjectName']));
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
                            Padding(
                              padding: EdgeInsets.only(left: 40, right: 20),
                              child: Text(follows[i]['userName'],
//                                color: Colors.blueAccent, fontWeight: FontWeight.w700,
                                  style: new TextStyle(fontSize: 16)),
                            ),
                            Offstage(
                              offstage: hiddenFollows,
                              child: Icon(
                                Icons.verified_user,
                                color: Colors.green,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),
    );

    final fansList = Offstage(
      offstage: hidden2, //这里控制
      child: Container(
        height: height - 295,
        child: new ListView.builder(
//          保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: fans == null ? 0 : fans.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
//                  Navigator.of(context).pushNamed(SubjectHomePage.tag,
//                      arguments: subjectEntity(subjects[i]['subjectId'],
//                          subjects[i]['subjectName']));
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
                            Padding(
                              padding: EdgeInsets.only(left: 40, right: 20),
//                            学科
                              child: Text(fans[i]['userName'],
//                                color: Colors.blueAccent, fontWeight: FontWeight.w700,
                                  style: new TextStyle(fontSize: 16)),
                            ),
                            Offstage(
                              offstage: hiddenFans,
                              child: Icon(
                                Icons.verified_user,
                                color: Colors.green,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),
    );

    final subjectsList = Offstage(
      offstage: hidden3, //这里控制
      child: Container(
        height: height - 295,
        child: new ListView.builder(
//          保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: subjects == null ? 0 : subjects.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(SubjectHomePage.tag,
                      arguments: subjectEntity(subjects[i]['attentionSubid'],
                          subjects[i]['attentionSubject']));
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
                                padding: EdgeInsets.only(left: 40, right: 40),
//                            学科
                                child: Text(
                                    subjects[i]['attentionSubject'].toString(),
//                                color: Colors.blueAccent, fontWeight: FontWeight.w700,
                                    style: new TextStyle(fontSize: 16)),
                              ),
                            ),
//                            圈子的关注人数
//                            Padding(
//                              padding: EdgeInsets.only(
//                                  left: 20, bottom: 6, right: 20),
////                            用户名
//                              child: Text("20" + "个人关注",
//                                  style: new TextStyle(
//                                      fontSize: 12, color: Colors.grey)),
//                            ),
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),
    );

    final postsList = Offstage(
      offstage: hidden41, //这里控制
      child: Container(
        height: height - 345,
        child:ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: posts == null ? 0 : posts.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(DetailPage.tag,
                      arguments: postEntity(
                        posts[i]['postsId'],
                        posts[i]['postsTitle'],
                        posts[i]['postsBelongs'],
                        posts[i]['subjectName'],
                        posts[i]['postsCreator'],
                        posts[i]['creatorName'],
                        posts[i]['postsLikes'],
                        posts[i]['postsDislikes'],
                        posts[i]['collections'],
                        posts[i]['repliesCount'],
                        posts[i]['postsUpdateTime'],
                        posts[i]['postsCtime'],
                      ));
                },
                child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: Color(0xffeeeeee),
                          )),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        width: width,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            学科
                              child: Text(
                                  posts[i]['subjectName'].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            用户名
                              child: Text(posts[i]['postsTitle']
                                          .toString()),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            标题
                              child: Text(
                                  posts[i]['postsCtime'].toString().split('T')[0],
                                  style: new TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.chat_bubble,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 20),
                                    child: Text(
                                        posts[i]['repliesCount']
                                            .toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 20),
                                    child: Text(
                                        posts[i]['postsLikes']
                                            .toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.thumb_down,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 20),
                                    child: Text(
                                        posts[i]['postsDislikes']
                                            .toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                        posts[i]['collections']
                                            .toString(),
                                        style: textStyle),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),);

    final postsList2 = Offstage(
      offstage: hidden42, //这里控制
      child: Container(
        height: height - 345,
        child:ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: posts2 == null ? 0 : posts2.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(DetailPage.tag,
                      arguments: postEntity(
                        posts2[i]['postsId'],
                        posts2[i]['postsTitle'],
                        posts2[i]['postsBelongs'],
                        posts2[i]['subjectName'],
                        posts2[i]['postsCreator'],
                        posts2[i]['creatorName'],
                        posts2[i]['postsLikes'],
                        posts2[i]['postsDislikes'],
                        posts2[i]['collections'],
                        posts2[i]['repliesCount'],
                        posts2[i]['postsUpdateTime'],
                        posts2[i]['postsCtime'],
                      ));
                },
                child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            width: 3,
                            color: Color(0xffeeeeee),
                          )),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        width: width,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            学科
                              child: Text(
                                  posts2[i]['subjectName'].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            用户名
                              child: Text(posts2[i]['postsTitle'].toString()),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            标题
                              child: Text(
                                  "最后回复于："+posts2[i]['postsUpdateTime'].toString().split('T')[0],
                                  style: new TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.chat_bubble,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 20),
                                    child: Text(
                                        posts2[i]['repliesCount']
                                            .toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 20),
                                    child: Text(
                                        posts2[i]['postsLikes']
                                            .toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.thumb_down,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 5, right: 20),
                                    child: Text(
                                        posts2[i]['postsDislikes']
                                            .toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                        posts2[i]['collections']
                                            .toString(),
                                        style: textStyle),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),);

    final sort = Offstage(
      offstage: hidden40,
      child: Container(
        height: 50,
        child: Row(
          children: <Widget>[
            Container(
              width: width*0.5,
              padding:
              EdgeInsets.only(top: 15,bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.only(left: 20,right: 10),
                    child: Icon(Icons.sort,size: 20,color: cTimeSortColor,),
                  ),
                  GestureDetector(
                    child: Text("时间",style: TextStyle(color: cTimeSortColor),),
                    onTap: (){
                      print("click csort");
                      setState(() {
                        cTimeSortColor = Colors.orange;
                        updateTimeSortColor = Colors.grey;
                        hidden41 = false;
                        hidden42 = true;
                      });
                      getPosts();
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: width*0.5,
              padding:
              EdgeInsets.only(top: 15,bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding:
                    EdgeInsets.only(left: 20,right: 10),
                    child: Icon(Icons.sort,size: 20,color: updateTimeSortColor,),
                  ),
                  GestureDetector(
                    child: Text("热度",style: TextStyle(color: updateTimeSortColor),),
                    onTap: (){
                      print("click usort");
                      setState(() {
                        updateTimeSortColor = Colors.orange;
                        cTimeSortColor = Colors.grey;
                        hidden41 = true;
                        hidden42 = false;
                      });
                      getPosts2();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );

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
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Text(
                            userName,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 20,
                                color: Colors.blueAccent),
                          ),
                        ),
                        Offstage(
                          offstage: hiddenFollowBtn,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xffe3f1f8),
                              border: Border.all(
                                  width: 1, color: Color(0xff017cc2)),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 8, top: 3, right: 8, bottom: 3),
                                  child: Text(followText,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12,
                                          color: Colors.blueAccent)),
                                ),
                                onTap: () {
                                  if (followText == "关注") {
                                    setState(() {
                                      followText = "已关注";
                                    });
//                                    请求
                                  } else if (followText == "已关注") {
                                    setState(() {
                                      followText = "关注";
                                    });
//                                    请求
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text(
                      sex + " | " + userWords,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                  Offstage(
                    offstage: hiddenIdentity, //这里控制
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Icon(
                              Icons.verified_user,
                              color: Colors.green,
                              size: 20,
                            ),
                          ),
                          Text(
                            "老师1  浙江大学  计算机圈",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                          child: Container(
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
                          onTap: () {
                            print("click follow");
                            setState(() {
//                                    test1Flag = false;
                              hidden1 = false;
                            });
//                                  test2Flag = true;
                            hidden2 = true;
                            hidden3 = true;
                            hidden40 = true;
                            hidden41 = true;
                            hidden42 = true;
                          }
                      ),
                      GestureDetector(
                          child: Container(
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
                          onTap: () {
                            print("click fans");
                            setState(() {
//                                    test1Flag = false;
                              hidden2 = false;
                            });
//                                  test2Flag = true;
                            hidden1 = true;
                            hidden3 = true;
                            hidden40 = true;
                            hidden41 = true;
                            hidden42 = true;
                          }
                      ),
                      GestureDetector(
                          child: Container(
                            width: (width - 70) * 0.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                          onTap: () {
                            print("click subject");
                            setState(() {
//                                    test1Flag = false;
                              hidden3 = false;
                            });
//                                  test2Flag = true;
                            hidden1 = true;
                            hidden2 = true;
                            hidden40 = true;
                            hidden41 = true;
                            hidden42 = true;
                          }
                      ),
                      GestureDetector(
                        child: Container(
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
                          onTap: () {
                            print("click posts");
                            setState(() {
//                                    test1Flag = false;
                              hidden40 = false;
                              hidden41 = false;
                              hidden42 = true;
                            });
//                                  test2Flag = true;
                            hidden1 = true;
                            hidden2 = true;
                            hidden3 = true;
                          }
                      ),
                    ],
                  )
                ],
              ),
            )),
      ],
    );

    Future<Null> _onRefresh() async {
      await Future.delayed(Duration(seconds: 1), () {
        print('refresh');
        getPosts();
        getPosts2();
        setState(() {});
      });
    }

    return new Scaffold(
      resizeToAvoidBottomInset: false, //固定页面不上移
      backgroundColor: Colors.white,
//      body: pagelist[_currentIndex],
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          title,
          content,
//          test1,
//          test2,
          followsList,
          fansList,
          subjectsList,
          sort,
          new RefreshIndicator(
            onRefresh: _onRefresh,
            child: postsList,
          ),
          new RefreshIndicator(
            onRefresh: _onRefresh,
            child: postsList2,
          ),
//          postsList,
//          postsList2,
          SizedBox(
            height: 45.0,
          ),
//        pagelist[_currentIndex],
        ],
      ),
    );
  }
}
