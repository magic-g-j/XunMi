import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/entity/post.dart';
import 'package:seekseek/entity/subject.dart';
import 'package:seekseek/ui/detail.dart';
import 'file:///C:/Users/DELL/Desktop/JAVAEE/seekseek/lib/ui/preface/modifypwd.dart';
import 'package:seekseek/ui/posting.dart';
import 'file:///C:/Users/DELL/Desktop/JAVAEE/seekseek/lib/ui/preface/register.dart';
import 'package:seekseek/ui/subject.dart';

import '../main.dart';
import 'home.dart';

class SubjectHomePage extends StatefulWidget {
  static String tag = 'subjectHome-page';
  @override
  _SubjectHomePageState createState() => new _SubjectHomePageState();
}

class _SubjectHomePageState extends State<SubjectHomePage> {
  final controller = TextEditingController();

  String followText;

  subjectEntity subject;

  Color timeSortColor,hotSortColor;

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  bool hidden1,hidden2;

  @override
  void initState() {
    super.initState();
    //    需改为变量
    followText = "关注";
    timeSortColor=Colors.orange;
    hotSortColor=Colors.grey;
    hidden1 = false;
    hidden2 = true;
  }

  List posts = [];
  List posts2 = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    subject = ModalRoute.of(context).settings.arguments;

    getPosts() async {
      var responseBody;
      var url = 'http://101.132.157.72:8084/posts/getListForSubject/createTime?subjectId=' +
          subject.subjectId.toString();
      var httpClient = new HttpClient();
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        responseBody = await response.transform(utf8.decoder).join();
        responseBody = json.decode(responseBody);
        posts = responseBody;
//        print(posts);
      } else {
        print("error");
      }
      setState(() {
        posts = responseBody;
      });
    }

    getPosts();

    getPosts2() async {
      var responseBody;
      var url = 'http://101.132.157.72:8084/posts/getListForSubject/updateTime?subjectId=' +
          subject.subjectId.toString();
      var httpClient = new HttpClient();
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        responseBody = await response.transform(utf8.decoder).join();
        responseBody = json.decode(responseBody);
        posts2 = responseBody;
//        print(posts);
      } else {
        print("error");
      }
      setState(() {
        posts2 = responseBody;
      });
    }

    getPosts2();

    final title = new PreferredSize(
        child: AppBar(
      elevation: 3,
      backgroundColor: Colors.white,
      title: InkWell(
        child: Row(
          children: <Widget>[
            Container(
              width: width * 0.60,
              child: Text(
                subject.subjectName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffe3f1f8),
                border: Border.all(
                    width: 1, color: Color(0xff017cc2)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  GestureDetector(
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
                    if(followText == "关注"){
                      setState(() {
                        followText = "已关注";
                      });
//                                    请求
                    }
                    else if(followText == "已关注"){
                      setState(() {
                        followText = "关注";
                      });
//                                    请求
                    }
                  }),
            ),
          ],
        ),
      ),
      centerTitle: true,
    ));

    final search = Row(
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
//              请求
            }),
      ],
    );

    final teachers = new Row(
      children: <Widget>[
        Container(
          width: width*0.333,
          child: Padding(
              padding:
              EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
              child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xfffadada),
                    border:Border.all(color: Color(0xffbbbbbb),width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
//            color: Color(0xfffadada),
                  child: Padding(
                    padding:
                    EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  width: width*0.143,
                                  child:Text("老师1",
                                      textAlign: TextAlign.center,
                                      style: new TextStyle(
                                        fontSize: 14,))
                              ),
                              Icon(Icons.verified_user,
                                color: Colors.green,
                                size: 20,)
                            ],
                          ),
                        ),
                        Text("浙江大学",
                            textAlign: TextAlign.center,
                            style: new TextStyle(
                              fontSize: 14,color: Colors.black54)),
                      ],
                    ),
                  )),
          ),
        ),
        Container(
          width: width*0.333,
          child: Padding(
            padding:
            EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
            child: Container(
                decoration: BoxDecoration(
                  color: Color(0xfff8f0c5),
                  border:Border.all(color: Color(0xffbbbbbb),width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
//            color: Color(0xfffadada),
                child: Padding(
                  padding:
                  EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: width*0.143,
                                child:Text("老师1",
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                      fontSize: 14,))
                            ),
                            Icon(Icons.verified_user,
                              color: Colors.green,
                              size: 20,)
                          ],
                        ),
                      ),
                      Text("浙江大学",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontSize: 14,color: Colors.black54)),
                    ],
                  ),
                )),
          ),
        ),
        Container(
          width: width*0.333,
          child: Padding(
            padding:
            EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
            child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffdef1c5),
                  border:Border.all(color: Color(0xffbbbbbb),width: 1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
//            color: Color(0xfffadada),
                child: Padding(
                  padding:
                  EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: width*0.143,
                                child:Text("老师1",
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(
                                      fontSize: 14,))
                            ),
                            Icon(Icons.verified_user,
                              color: Colors.green,
                              size: 20,)
                          ],
                        ),
                      ),
                      Text("浙江大学",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontSize: 14,color: Colors.black54)),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );

    final sort =Container(
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
                  child: Icon(Icons.sort,size: 20,color: timeSortColor,),
                ),
                GestureDetector(
                  child: Text("时间",style: TextStyle(color: timeSortColor),),
                  onTap: (){
                    print("click csort");
                    setState(() {
                      timeSortColor = Colors.orange;
                      hotSortColor = Colors.grey;
                      hidden1 = false;
                      hidden2 = true;
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
                  child: Icon(Icons.sort,size: 20,color: hotSortColor,),
                ),
                GestureDetector(
                  child: Text("热度",style: TextStyle(color: hotSortColor),),
                  onTap: (){
                    print("click usort");
                    setState(() {
                      hotSortColor = Colors.orange;
                      timeSortColor = Colors.grey;
                      hidden2 = false;
                      hidden1 = true;
                    });
                    getPosts2();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );

    final postsList = Offstage(
      offstage: hidden1,
      child: Container(
        height: height - 220,
        child: new ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
//            Container(
//              width: width,
//              decoration: BoxDecoration(
//                border: Border(
//                    bottom: BorderSide(
//                  width: 3,
//                  color: Color(0xffeeeeee),
//                )),
//              ),
////      color: Colors.blueAccent,
//              child: Padding(
//                  padding:
//                      EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 20),
//                  child: Text(
//                    "认证老师推荐",
//                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
//                  )),
//            ),
//            teachers,
              ListView.builder(
                  shrinkWrap: true, //不限高度
                  physics: new NeverScrollableScrollPhysics(),
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
                                    child: Text(
                                        posts[i]['postsTitle'].toString(),
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
                                            fontSize: 12,
                                            color: Colors.blueAccent)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, bottom: 6, right: 20),
//                            标题
                                    child: Text(posts[i]['postsCtime'].toString().split('T')[0],
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
            ]),
      ),
    );

    final postsList2 = Offstage(
      offstage: hidden2,
      child: Container(
        height: height - 200,
        child: new ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: <Widget>[
              ListView.builder(
                  shrinkWrap: true, //不限高度
                  physics: new NeverScrollableScrollPhysics(),
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
                                    child: Text(
                                        posts2[i]['postsTitle'].toString(),
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
                                            fontSize: 12,
                                            color: Colors.blueAccent)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, bottom: 6, right: 20),
//                            标题
                                    child: Text("最后回复于："+posts2[i]['postsUpdateTime'].toString().split('T')[0],
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
            ]),
      ),
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
//          search,
//          teachers,
          SizedBox(
            height: 10.0,
          ),
          sort,
          new RefreshIndicator(
            onRefresh: _onRefresh,
            child: postsList,
          ),
          new RefreshIndicator(
            onRefresh: _onRefresh,
            child: postsList2,
          ),
//        pagelist[_currentIndex],
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
//          加上创建者id传参
          Navigator.of(context).pushNamed(PostingPage.tag,arguments:subject.subjectId);
        },
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
        elevation: 3.0,
        highlightElevation: 2.0,
        backgroundColor: Colors.blueAccent, // 红色
      ),
    );
  }
}
