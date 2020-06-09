import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seekseek/common/toastHelper.dart';
import 'package:seekseek/entity/post.dart';
import 'package:seekseek/entity/reply.dart';
import 'package:seekseek/main.dart';

class ReplyPage extends StatefulWidget {
  static String tag = 'reply-page';
  @override
  _ReplyPageState createState() => new _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  final controller = TextEditingController();

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.grey);
  TextStyle textStyle2 = const TextStyle(fontSize: 12, color: Colors.orange);

  Color thumbUpColor1;
//  Color thumbUpColor2;
  int thumbUpCount1 = 0;
  int thumbUpCount2 = 0;
  List repliesList = [];

  replyEntity replyDetail;
  String replyNum;

  String input;

  @override
  void initState() {
    super.initState();
    thumbUpColor1 = Colors.grey;
//    thumbUpColor2 = Colors.grey;
    thumbUpCount1 = 0;
    replyNum = "0";
    input = "";
    thumbUpCount2 = 0;
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
    replyDetail = ModalRoute.of(context).settings.arguments;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    reply() async {
      try {
        Response response;
        Dio dio = new Dio();
//      Dio dio = new Dio(options);
        if (input == null || input == "") {
          ToastHelper.showToast(context, "内容不能为空");
        } else {
          response = await dio.post(
            "http://101.132.157.72:8084/reply/add",
            data: {
              "replyParent": replyDetail.replyId,
              "replyParentType": 1,
              "replyCreator": MyApp.userId,
              "replyContent": input,
            },
          );
          if (response.statusCode == 200) {
            print("reply" + response.toString());
          }
        }
      } catch (exception) {
        print('exc:$exception');
      }
//    setState(() {});
    }

    getReply() async {
      var responseBody;
      var url = 'http://101.132.157.72:8084/reply/listReply?parentId=' +
          replyDetail.replyId.toString() +
          '&parentType=1';
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
            replyDetail.replyId.toString() +
            "&parentType=1",
      );
      if (response.statusCode == 200) {
        replyNum = response.toString();
//      print("subject"+subjectCount);
      } else {
        print("error");
      }
      setState(() {});
    }

    thumbUp() async {
      Dio dio = new Dio();
      Response response;
      response = await dio.get(
          "http://101.132.157.72:8084/reply/likeAndDislike/modify?replyId=" +
              replyDetail.replyId.toString() +
              "&type=1&add=1");
    }

    thumbUpCancel() async {
      Dio dio = new Dio();
      Response response;
      response = await dio.get(
          "http://101.132.157.72:8084/reply/likeAndDislike/modify?replyId=" +
              replyDetail.replyId.toString() +
              "&type=1&add=0");
    }

    getReply();
    getReplyCount();

    final title = new PreferredSize(
      child: AppBar(
          title: Text("本楼的回复"),
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
                    delete() async {
                      Dio dio = new Dio();
                      Response response;
                      response = await dio.get(
                          "http://101.132.157.72:8084/reply/delete?replyId=" +
                              replyDetail.replyId
                                  .toString()+"&userId="+MyApp.userId.toString());
                      if(response.toString()=="true"){
                        ToastHelper.showToast(context, "删除成功");
                      }
                    }
                    if(replyDetail.replyCreator == MyApp.userId){
                      delete();
                      Navigator.pop(context);
                    }
                    else{
                      ToastHelper.showToast(context, "删除失败：非创建者不能删除");
                    }
                    break;
                }
              },
            ),
          ]),
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
            replyNum + "条回复",
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
                                      width: width * 0.70,
                                      child: Text(
                                        repliesList[i]['replyCreatorName'],
                                        style: new TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: Colors.blueAccent),
                                      ),
                                    ),
                                    GestureDetector(
                                        child: Icon(
                                          Icons.thumb_up,
//                                          color: thumbUpColor2,
                              color: Colors.grey,
                                          size: 17,
                                        ),
                                        onTap: () {
                                          print("click2");
                                          thumbUpCount2++;
                                          print(thumbUpCount2);
                                          if (thumbUpCount2 % 2 == 1) {
                                            thumbUp2() async {
                                              Dio dio = new Dio();
                                              Response response;
                                              response = await dio.get(
                                                  "http://101.132.157.72:8084/reply/likeAndDislike/modify?replyId=" +
                                                      repliesList[i]['replyId']
                                                          .toString() +
                                                      "&type=1&add=1");
                                            }

                                            thumbUp2();
                                            setState(() {
//                                              thumbUpColor2 = Colors.orange;
                                            });
                                          }
                                          if (thumbUpCount2 % 2 == 0) {
                                            thumbUpCancel2() async {
                                              Dio dio = new Dio();
                                              Response response;
                                              response = await dio.get(
                                                  "http://101.132.157.72:8084/reply/likeAndDislike/modify?replyId=" +
                                                      repliesList[i]['replyId']
                                                          .toString() +
                                                      "&type=1&add=0");
                                            }
                                            thumbUpCancel2();
                                            setState(() {
//                                              thumbUpColor2 = Colors.grey;
                                              thumbUpCount2 = 0;
                                            });
                                          }
                                        }),
                                    Container(
                                      width: width * 0.08,
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                          repliesList[i]['replyLikes']
                                              .toString(),
                                          style: textStyle2),
                                    ),
                                    PopupMenuButton<String>(
                                      icon: Icon(
                                        Icons.more_vert,
                                        color: Colors.grey,
                                      ),
                                      itemBuilder: (BuildContext context) =>
                                          <PopupMenuItem<String>>[
                                        this.selectView(
                                            Icons.report_problem, '举报', '1'),
                                        this.selectView(
                                            Icons.delete_forever, '删除', '2'),
                                      ],
                                      onSelected: (String action) {
                                        // 点击选项的时候
                                        switch (action) {
                                          case '1':
//TODO                      举报
                                            break;
                                          case '2':
//TODO                      删除
                                          delete2() async {
                                            Dio dio = new Dio();
                                            Response response;
                                            response = await dio.get(
                                                "http://101.132.157.72:8084/reply/delete?replyId=" +
                                                    repliesList[i]['replyId']
                                                        .toString()+"&userId="+MyApp.userId.toString());
                                            print(response.toString());
                                            if(response.toString()=="true"){
                                              ToastHelper.showToast(context, "删除成功");
                                            }
                                          }
                                          if(repliesList[i]['replyCreator'] == MyApp.userId){
                                            delete2();
                                          }
                                          else{
                                            ToastHelper.showToast(context, "删除失败：非创建者不能删除");
                                          }
                                            break;
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(
                                    repliesList[i]['replyCtime']
                                        .toString()
                                        .split('T')[0],
                                    style: textStyle),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Text(repliesList[i]['replyContent']),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ],
                      )));
            }));

    final main = new Container(
      height: height - 185,
      child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                  width: 3,
                  color: Color(0xffeeeeee),
                )),
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 15),
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
                                    replyDetail.replyCreatorName,
                                    style: new TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.blueAccent),
                                  ),
                                ),
                                GestureDetector(
                                    child: Icon(
                                      Icons.thumb_up,
                                      color: thumbUpColor1,
                                      size: 17,
                                    ),
                                    onTap: () {
                                      print("click1");
                                      thumbUpCount1++;
                                      print(thumbUpCount1);
                                      if (thumbUpCount1 % 2 == 1) {
                                        thumbUp();
                                        setState(() {
                                          replyDetail.replyLikes =
                                              replyDetail.replyLikes + 1;
                                          thumbUpColor1 = Colors.orange;
//                                      请求
                                        });
                                      }
                                      if (thumbUpCount1 % 2 == 0) {
                                        thumbUpCancel();
                                        setState(() {
                                          replyDetail.replyLikes =
                                              replyDetail.replyLikes - 1;
                                          thumbUpColor1 = Colors.grey;
//                                        请求
                                        });
                                      }
                                    }),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(replyDetail.replyLikes.toString(),
                                      style: textStyle2),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                                replyDetail.replyCtime.toString().split('T')[0],
                                style: textStyle),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(replyDetail.replyContent),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ],
                  )),
            ),
            replyTitle,
            replies
          ]),
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
                onChanged: (value) {
                  setState(() {
                    input = value;
                  });
                }, // on
                // onChanged: onSearchTextChanged,
              ),
            ),
          ),
        ),
        GestureDetector(
            child: Text('发送',
                style: new TextStyle(color: Colors.blueAccent, fontSize: 14)),
            onTap: () {
              print("reply");
              reply();
//              请求
            }),
      ],
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
