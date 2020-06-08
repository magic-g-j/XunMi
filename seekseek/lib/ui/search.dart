import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/entity/post.dart';
import 'package:seekseek/entity/subject.dart';
import 'package:seekseek/ui/subject.dart';
import 'package:seekseek/ui/subjectHome.dart';

import '../main.dart';
import 'detail.dart';

class SearchPage extends StatefulWidget {
  static String tag = 'search-page';
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

  String searchContent;
  List posts = [];
  List posts2 = [];
  List subjects = [];
  List users = [];
  bool hidden0, hidden10, hidden11, hidden12, hidden2, hidden3;

  Color cTimeSortColor, updateTimeSortColor;

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  @override
  void initState() {
//  导航栏页面
    super.initState();
    searchContent = "";
    hidden0 = true;
    hidden10 = true;
    hidden11 = true;
    hidden12 = true;
    hidden2 = true;
    hidden3 = true;
    cTimeSortColor = Colors.orange;
    updateTimeSortColor = Colors.grey;
  }

  getPosts() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/posts/search/createTime?key=' +
        searchContent;
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      posts = responseBody;
//      if (posts == [] || posts == null) {
//        setState(() {
//          hidden0 = false;
//        });
//      }
//      print(posts);
    } else {
      print("error");
    }
    setState(() {
      posts = responseBody;
    });
  }

  getPosts2() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/posts/search/updateTime?key=' +
        searchContent;
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      posts2 = responseBody;
//      print(posts);
//      if (posts2 == []) {
//        setState(() {
//          hidden0 = false;
//        });
//      }
    } else {
      print("error");
    }
    setState(() {
      posts2 = responseBody;
    });
  }

  getSubject() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/subject/search/?key=' + searchContent;
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      subjects = responseBody;
//      if (subjects == []) {
//        setState(() {
//          hidden0 = false;
//        });
//      }
//      print(posts);
    } else {
      print("error");
    }
    setState(() {
      subjects = responseBody;
    });
  }

  getUser() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/user/search/?key=' + searchContent;
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      users = responseBody;
//      if (users == []) {
//        setState(() {
//          hidden0 = false;
//        });
//      }
//      print(users);
    } else {
      print("error");
    }
    setState(() {
      users = responseBody;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

//    getPosts();

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
                                  padding: EdgeInsets.only(left: 20),
                                  child: TextField(
                                    controller: controller,
                                    decoration: new InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(top: 0.0),
                                        hintText: '搜索',
                                        border: InputBorder.none),
                                    onChanged: (value) {
                                      setState(() {
                                        searchContent = value;
                                        if (value == "" || value == null) {
                                          searchContent = "";
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    print("search");
                                    posts = [];
                                    subjects = [];
                                    users = [];
//                                请求
                                    setState(() {
                                      hidden2 = true;
                                      hidden3 = true;
                                      hidden10 = false;
                                      hidden11 = false;
                                    });
                                    if (searchContent.length >= 2) {
//                                      TODO 12 s u
                                      getPosts();
                                      getPosts2();
                                      getSubject();
                                      getUser();
                                      hidden10 = false;
                                      hidden11 = false;
                                    } else {
                                      setState(() {
                                        posts = [];
//                                        hidden10 = true;
//                                        hidden11 = true;
                                      });
                                      getSubject();
                                      getUser();
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                          child: Text('取消',
                              style: new TextStyle(
                                  color: Colors.blueAccent, fontSize: 14)),
                          onTap: () {
                            print("cancel");
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          width: width * 0.333,
                          child: Text(
                            "帖子",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                        onTap: () {
                          print("click post");
                          setState(() {
                            hidden10 = false;
                            hidden11 = false;
                            hidden12 = true;
                            hidden2 = true;
                            hidden3 = true;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: width * 0.333,
                          child: Text(
                            "圈子",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                        onTap: () {
                          print("click subject");
                          setState(() {
                            hidden10 = true;
                            hidden11 = true;
                            hidden12 = true;
                            hidden2 = false;
                            hidden3 = true;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          width: width * 0.333,
                          child: Text(
                            "用户",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ),
                        onTap: () {
                          print("click user");
                          setState(() {
                            hidden10 = true;
                            hidden11 = true;
                            hidden12 = true;
                            hidden2 = true;
                            hidden3 = false;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            )),
      ],
    );

    final sort = Offstage(
        offstage: hidden10,
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Container(
                width: width * 0.5,
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: Icon(
                        Icons.sort,
                        size: 20,
                        color: cTimeSortColor,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        "时间",
                        style: TextStyle(color: cTimeSortColor),
                      ),
                      onTap: () {
                        print("click csort");
                        setState(() {
                          cTimeSortColor = Colors.orange;
                          updateTimeSortColor = Colors.grey;
                          hidden11 = false;
                          hidden12 = true;
                        });
                        getPosts();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: width * 0.5,
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: Icon(
                        Icons.sort,
                        size: 20,
                        color: updateTimeSortColor,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        "热度",
                        style: TextStyle(color: updateTimeSortColor),
                      ),
                      onTap: () {
                        print("click usort");
                        setState(() {
                          updateTimeSortColor = Colors.orange;
                          cTimeSortColor = Colors.grey;
                          hidden11 = true;
                          hidden12 = false;
                        });
                        getPosts2();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));

    final postsList = Offstage(
      offstage: hidden11,
      child: Container(
        height: height - 205,
        child: new ListView.builder(
//          保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            学科
                              child: Text(posts[i]['subjectName'].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            用户名
                              child: Text(
                                  "@ " + posts[i]['creatorName'].toString(),
                                  style: new TextStyle(
                                      fontSize: 12, color: Colors.blueAccent)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            标题
                              child: Text(posts[i]['postsTitle'].toString(),
                                  style: new TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.chat_bubble,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 20),
                                    child: Text(
                                        posts[i]['repliesCount'].toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 20),
                                    child: Text(
                                        posts[i]['postsLikes'].toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.thumb_down,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 20),
                                    child: Text(
                                        posts[i]['postsDislikes'].toString(),
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
                                        posts[i]['collections'].toString(),
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
      ),
    );

    final postsList2 = Offstage(
      offstage: hidden12,
      child: Container(
        height: height - 205,
        child: new ListView.builder(
//          保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            学科
                              child: Text(posts2[i]['subjectName'].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            用户名
                              child: Text(
                                  "@ " + posts2[i]['creatorName'].toString(),
                                  style: new TextStyle(
                                      fontSize: 12, color: Colors.blueAccent)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20, bottom: 6, right: 20),
//                            标题
                              child: Text(posts2[i]['postsTitle'].toString(),
                                  style: new TextStyle(
                                      fontSize: 12, color: Colors.grey)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.chat_bubble,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 20),
                                    child: Text(
                                        posts2[i]['repliesCount'].toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 20),
                                    child: Text(
                                        posts2[i]['postsLikes'].toString(),
                                        style: textStyle),
                                  ),
                                  Icon(
                                    Icons.thumb_down,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 5, right: 20),
                                    child: Text(
                                        posts2[i]['postsDislikes'].toString(),
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
                                        posts2[i]['collections'].toString(),
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
      ),
    );

    final subjectsList = Offstage(
      offstage: hidden2, //这里控制
      child: Container(
        height: height - 205,
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

    final userList = Offstage(
      offstage: hidden3, //这里控制
      child: Container(
        height: height - 205,
        child: new ListView.builder(
//          保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: users == null ? 0 : users.length,
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
                              child: Text(users[i]['userName'],
//                                color: Colors.blueAccent, fontWeight: FontWeight.w700,
                                  style: new TextStyle(fontSize: 16)),
                            ),
//                            Offstage(
//                              offstage: hiddenUsers,
//                              child: Icon(
//                                Icons.verified_user,
//                                color: Colors.green,
//                                size: 20,
//                              ),
//                            )
                          ],
                        ),
                      ),
                    )),
              );
            }),
      ),
    );

    final tip = Offstage(
      offstage: hidden0,
      child: Container(
        width: width,
        padding: EdgeInsets.only(top: 30),
        child: Text(
          "什么都没找到~",
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return new Scaffold(
      resizeToAvoidBottomInset: false, //固定页面不上移
      backgroundColor: Colors.white,
//      body: pagelist[_currentIndex],
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          content,
          sort,
//          tip,
          postsList,
          postsList2,
          subjectsList,
          userList,
        ],
      ),
    );
  }
}
