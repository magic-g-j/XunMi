import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seekseek/entity/post.dart';
import 'package:seekseek/main.dart';

class DetailPage extends StatefulWidget {
  static String tag = 'detail-page';
  @override
  _DetailPageState createState() => new _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.grey);
  TextStyle textStyle2 = const TextStyle(fontSize: 12, color: Colors.orange);

  List repliesList = [];

  postEntity postDetail;
  List result;
  int postId;
  String postcontent = "";
  String postsCtime = "";

  @override
  void initState() {
    super.initState();
  }

  selectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(icon, color: Colors.grey,size: 17,),
            new Text(text,style: new TextStyle(fontSize: 14),),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    postDetail = ModalRoute.of(context).settings.arguments;
    postId = postDetail.postsId;

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
          postcontent = "";
        } else {
          postcontent = result[3].toString();
        }
        if (result[5] == null) {
          postsCtime = "";
        } else {
          postsCtime = result[5].toString();
        }
//        print(postsCtime);
      } else {
        print("error");
      }
      setState(() {});
    }

//    AppBar(
//      elevation: 3,
//      backgroundColor: Colors.white,
//      title: InkWell(
//        child: Text(
//          "问题",
//          style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
//        ),
//        onTap: () {
//        },
//      ),
//      centerTitle: true,
//    )

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
            ]),);

    getDetail();

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
                          bottom:
                              BorderSide(width: 1, color: Color(0xff017cc2)),
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 8, top: 3, right: 8, bottom: 3),
                        child: Text("关注",
                            style: new TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                color: Colors.blueAccent)),
                      )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(postsCtime.split('T')[0], style: textStyle)),
            Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(postcontent)),
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
                      Text(postDetail.repliesCount.toString(),
                          style: textStyle2),
                    ],
                  ),
                ),
                Container(
                  width: (width - 40) * 0.25,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.thumb_up,
                        color: Colors.grey,
                        size: 17,
                      ),
                      Text(postDetail.postsLikes.toString(), style: textStyle2),
                    ],
                  ),
                ),
                Container(
                  width: (width - 40) * 0.25,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.thumb_down,
                        color: Colors.grey,
                        size: 17,
                      ),
                      Text(postDetail.postsDislikes.toString(),
                          style: textStyle2),
                    ],
                  ),
                ),
                Container(
                  width: (width - 40) * 0.25,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                        size: 20,
                      ),
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
      height: height - 185,
      child: ListView(
        children: <Widget>[
          content,
          replyTitle,
          Container(
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
                                  "用户",
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
                                child: Text(postDetail.postsLikes.toString(),
                                    style: textStyle2),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text("2020-5-28", style: textStyle),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child:  Text("回复内容……"),
                        ),
                        Text("查看0条回复 >>",style: new TextStyle(color: Colors.grey)),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                )),
          ),
        ],
      ),
    );

    final repliesListContainer = new Container(
      height: 400,
      child: new ListView.builder(
          itemCount: repliesList == null ? 0 : repliesList.length,
          itemBuilder: (context, i) {
            return new Container(
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
                            padding: EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "同学" +
                                      repliesList[i]['creatorSid'].toString(),
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: new Container(
                                      width: 110,
                                      child: Text(
                                          repliesList[i]['createDate']
                                              .toString()
                                              .replaceAll("T", " "),
                                          style: textStyle),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(left: 70, right: 5),
                                  child: Icon(
                                    Icons.bookmark_border,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ),
//                        Text("0",style: textStyle2),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, right: 5),
                                  child: Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                    size: 18,
                                  ),
                                ),
                                Text(repliesList[i]['zan'].toString(),
                                    style: textStyle2),
                              ],
                            ),
                          ),
                          Text(repliesList[i]['content'].toString(),
                              style: new TextStyle(color: Colors.black)),
                          Padding(
                            padding: EdgeInsets.only(left: 300, top: 10),
                            child: Text(
                              "删除",
                              style: new TextStyle(
                                  color: Colors.red, fontSize: 12),
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ],
                  )),
            );
//              replyList(repliesList[i]['sid'],repliesList[i]['content'],repliesList[i]['creatorSid'],repliesList[i]['createDate'],repliesList[i]['questionSid'],repliesList[i]['zan'],repliesList[i]['mark']);
          }),
    );

    final comment = new Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20, right: 30, top: 30),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                  left: BorderSide(width: 1, color: Colors.grey),
                  right: BorderSide(width: 1, color: Colors.grey),
                  bottom: BorderSide(width: 1, color: Colors.grey),
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 60, top: 8, right: 60, bottom: 8),
                child: Text('回复一下，见证当下……',
                    style: new TextStyle(color: Colors.grey, fontSize: 14)),
              )),
        ),
        Padding(
            padding: EdgeInsets.only(top: 35),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.chat_bubble,
                  color: Colors.grey,
                  size: 17,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 20),
                  child: Text(postDetail.repliesCount.toString(), style: textStyle2),
                ),
              ],
            ),
        )
      ],
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        shrinkWrap: true,
        padding: new EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0),
        children: <Widget>[
          title,
//          模板
          replies,
//          repliesListContainer,
          comment,
        ],
      ),
    );
  }
}
