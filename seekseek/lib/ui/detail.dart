import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seekseek/common/toastHelper.dart';
import 'package:seekseek/entity/post.dart';
import 'package:seekseek/main.dart';
import 'package:seekseek/ui/reply.dart';

class DetailPage extends StatefulWidget {
  static String tag = 'detail-page';
  @override
  _DetailPageState createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final controller = TextEditingController();

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.grey);
  TextStyle textStyle2 = const TextStyle(fontSize: 12, color: Colors.orange);

  Color thumbUpColor, thumbDownColor, collectColor;
  int thumbUpCount = 0, thumbDownCount = 0, collectCount = 0;

  String followText;

  List repliesList = [];
  String repliesCount = "0";

  postEntity postDetail;
  List result;
  int postId;
  String postContent = "";

  String replyContent = "";

  @override
  void initState() {
    super.initState();
    thumbUpColor = Colors.grey;
    thumbDownColor = Colors.grey;
    collectColor = Colors.grey;
    thumbUpCount = 0;
    thumbDownCount = 0;
    collectCount = 0;
    followText = "关注";
  }

  selectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(
              icon,
              color: Colors.grey,
              size: 17,
            ),
            new Text(
              text,
              style: new TextStyle(fontSize: 14),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    postDetail = ModalRoute.of(context).settings.arguments;
    postId = postDetail.postsId;

    reply() async {
      try {
        Response response;
        Dio dio = new Dio();
//      Dio dio = new Dio(options);
        if(replyContent ==null || replyContent==""){
          ToastHelper.showToast(context, "内容不能为空");
        }
        else{
          response = await dio.post("http://101.132.157.72:8084/reply/add",data: {
            "replyParent":postId,
            "replyParentType":0,
            "replyCreator":MyApp.userId,
            "replyContent":replyContent,
          }, );
          if (response.statusCode == 200) {
            print("reply"+response.toString());
          }
        }
      } catch (exception) {
        print('exc:$exception');
      }
//    setState(() {});
    }

    getDetail() async {
      var responseBody;
//      print(MyApp.userId.toString());
      var url = 'http://101.132.157.72:8084/posts/getOne?postsId=' +
          postId.toString() +
          '&userId=' +
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
        if (result[3] == null) {
          postContent = "";
        } else {
          postContent = result[3].toString();
        }
//        print(postsCtime);
      } else {
        print("error");
      }
      setState(() {});
    }

//TODO 点赞\踩数更新 查看子回复传参
    thumbUp() async {
      Dio dio = new Dio();
      Response response;
      response = await dio.get(
          "http://101.132.157.72:8084/posts/likeAndDislike/modify?postsId=" +
              postId.toString() +
              "&type=1&add=1"
      );
    }

    thumbUpCancel() async {
      Dio dio = new Dio();
      Response response;
      response = await dio.get(
          "http://101.132.157.72:8084/posts/likeAndDislike/modify?postsId=" +
              postId.toString() +
              "&type=1&add=0"
      );
    }

    thumbDown() async {
      Dio dio = new Dio();
      Response response;
      response = await dio.get(
          "http://101.132.157.72:8084/posts/likeAndDislike/modify?postsId=" +
              postId.toString() +
              "&type=0&add=1"
      );
    }

    thumbDownCancel() async {
      Dio dio = new Dio();
      Response response;
      response = await dio.get(
          "http://101.132.157.72:8084/posts/likeAndDislike/modify?postsId=" +
              postId.toString() +
              "&type=0&add=0"
      );
    }

    getReply() async {
      var responseBody;
      var url = 'http://101.132.157.72:8084/reply/listReply?parentId=' +
          postId.toString() +
          '&parentType=0';
      var httpClient = new HttpClient();
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        responseBody = await response.transform(utf8.decoder).join();
        responseBody = json.decode(responseBody);
        repliesList = responseBody;
//        print(repliesList);
      } else {
        print("error");
      }
      setState(() {
        repliesList = responseBody;
      });
    }

    getReplyCount() async {
      Dio dio = new Dio();
      Response response;
      response = await dio.get(
        "http://101.132.157.72:8084/reply/getReplyCount?parentId=" +
          postId.toString() +
          "&parentType=0"
      );
      if (response.statusCode == 200) {
        repliesCount = response.toString();
//      print(repliesCount);
      } else {
        print("error");
      }
      setState(() {
        repliesCount = response.toString();
      });
    }

    getDetail();
    getReply();
    getReplyCount();

    final title = new PreferredSize(
      child: AppBar(
          title: Text(postDetail.subjectName),
          leading: InkWell(
              onTap: () {
//                  print("点击返回");
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios)),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: <Widget>[
            new PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                this.selectView(Icons.report_problem, '举报', '1'),
                this.selectView(Icons.delete_forever, '删除', '2'),
              ],
              onSelected: (String action) {
                // 点击选项的时候
                switch (action) {
                  case '1':
//                      举报
                    break;
                  case '2':
//                      删除
                    break;
                }
              },
            ),
          ]),
    );

    var content = new Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          width: 3,
          color: Color(0xffeeeeee),
        )),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, top: 5, bottom: 15, right: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Text(postDetail.creatorName,
                        style: new TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.blueAccent)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffe3f1f8),
                      border: Border(
                        top: BorderSide(width: 1, color: Color(0xff017cc2)),
                        left: BorderSide(width: 1, color: Color(0xff017cc2)),
                        right: BorderSide(width: 1, color: Color(0xff017cc2)),
                        bottom: BorderSide(width: 1, color: Color(0xff017cc2)),
                      ),
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
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(postDetail.postsCtime.toString().split('T')[0], style: textStyle)),
            Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(postContent)),
            Row(
              children: <Widget>[
                Container(
                  width: (width - 40) * 0.25,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.chat_bubble,
                        color: Colors.grey,
                        size: 17,
                      ),
                      Text(repliesCount,
                          style: textStyle2),
                    ],
                  ),
                ),
                Container(
                  width: (width - 40) * 0.25,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                          child: Icon(
                            Icons.thumb_up,
                            color: thumbUpColor,
                            size: 17,
                          ),
                          onTap: () {
                            print("click up");
                            thumbUpCount++;
                            print(thumbUpCount);
                            if (thumbUpCount % 2 == 1) {
                              setState(() {
                                thumbUpColor = Colors.orange;
//                                      请求
                              });
                            }
                            if (thumbUpCount % 2 == 0) {
                              setState(() {
                                thumbUpColor = Colors.grey;
//                                        请求
                              });
                            }
                          }),
//TODO 点赞数
                      Text(postDetail.postsLikes.toString(), style: textStyle2),
                    ],
                  ),
                ),
                Container(
                  width: (width - 40) * 0.25,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                          child: Icon(
                            Icons.thumb_down,
                            color: thumbDownColor,
                            size: 17,
                          ),
                          onTap: () {
                            print("click down");
                            thumbDownCount++;
                            print(thumbDownCount);
                            if (thumbDownCount % 2 == 1) {
                              setState(() {
                                thumbDownColor = Colors.orange;
//                                      请求
                              });
                            }
                            if (thumbDownCount % 2 == 0) {
                              setState(() {
                                thumbDownColor = Colors.grey;
//                                        请求
                              });
                            }
                          }),
//TODO 踩数
                      Text(postDetail.postsDislikes.toString(),
                          style: textStyle2),
                    ],
                  ),
                ),
                Container(
                  width: (width - 40) * 0.25,
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                          child: Icon(
                            Icons.star,
                            color: collectColor,
                            size: 20,
                          ),
                          onTap: () {
                            print("click down");
                            collectCount++;
                            print(collectCount);
                            if (collectCount % 2 == 1) {
                              setState(() {
                                collectColor = Colors.orange;
//                                      请求
                              });
                            }
                            if (collectCount % 2 == 0) {
                              setState(() {
                                collectColor = Colors.grey;
//                                        请求
                              });
                            }
                          }),
                      Text(postDetail.collections.toString(),
                          style: textStyle2),
                    ],
                  ),
                )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );

    final replyTitle = new Container(
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
            "全部回复",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          )),
    );

    final replies = new Container(
        child: ListView.builder(
            shrinkWrap: true, //不限高度
            physics: new NeverScrollableScrollPhysics(),
            itemCount: repliesList == null ? 0 : repliesList.length,
            itemBuilder: (context, i) {
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    width: 1,
                    color: Color(0xffeeeeee),
                  )),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: width * 0.78,
                                    child: Text(
                                      repliesList[i]['replyCreatorName'].toString(),
                                      style: new TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.blueAccent),
                                    ),
                                  ),
                                  Icon(
                                    Icons.thumb_up,
                                    color: Colors.grey,
                                    size: 17,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                        repliesList[i]['replyLikes'].toString(),
                                        style: textStyle2),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(repliesList[i]['replyCtime'].toString().split('T')[0], style: textStyle),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(repliesList[i]['replyContent'].toString()),
                            ),
                            GestureDetector(
                                child: Text("回复并查看 >>",
                                    style: new TextStyle(color: Colors.grey)),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(ReplyPage.tag);
                                }),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ],
                    )),
              );
            }));

    final main = new Container(
      height: height - 185,
      child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[content, replyTitle, replies]),
    );

    final comment = new Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, right: 25, top: 20, bottom: 20),
          child: Container(
            width: width * 0.75,
            decoration: BoxDecoration(
              color: Color(0xffeeeeee),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                controller: controller,
                decoration: new InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0.0),
                    hintText: '回复一下，见证当下……',
                    border: InputBorder.none),
                onChanged: (value){
                  setState(() {
                    replyContent = value;
                  });
                },                // onChanged: onSearchTextChanged,
              ),
            ),
          ),
        ),
        GestureDetector(
            child: Text('发送',
                style: new TextStyle(color: Colors.blueAccent, fontSize: 14)),
            onTap: () {
              print("reply");
//              请求
              reply();
//              getDetail();
            }),
      ],
    );

    return new Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: new ListView(
        shrinkWrap: true,
        padding: new EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
        children: <Widget>[
          title,
//          replies,
          main,
          comment,
        ],
      ),
    );
  }
}
