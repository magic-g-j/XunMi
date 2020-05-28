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

  TextStyle textStyle = const TextStyle(fontSize: 12,color: Colors.grey );
  TextStyle textStyle2 = const TextStyle(fontSize: 12,color: Colors.orange );

  List answersList = [];

  postEntity postDetail;
  List result;
  int postId;
  String postcontent = "";
  String postsCtime = "";

  @override
  void initState() {
    super.initState();
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
      var url='http://101.132.157.72:8084/posts/getOne?postsId='+postId.toString()+'&userId='+MyApp.userId.toString();
      var httpClient = new HttpClient();
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == 200) {
        responseBody = await response.transform(utf8.decoder).join();
        responseBody=json.decode(responseBody);
        Map map = responseBody as Map;
        result = map.values.toList();
//        print(responseBody);
        if(result[3]==null){
          postcontent = "";
        }
        else{
          postcontent = result[3].toString();
        }
        if(result[5]==null){
          postsCtime = "";
        }
        else{
          postsCtime = result[5].toString();
        }
//        print(postsCtime);
      }else{
        print("error");
      }
      setState(() {

      });
    }

    final title = new PreferredSize(
        child: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: InkWell(
            child: Text(
              postDetail.subjectName,
              style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
            ),
            onTap: () {
            },
          ),
          centerTitle: true,
        ));

    getDetail();

    var content = new Container(
      width: width,
      decoration: BoxDecoration(
        border: Border(bottom:BorderSide(width: 3,color: Color(0xffeeeeee),)),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20,top: 15,bottom: 15,right: 20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(postDetail.creatorName,style: new TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.blueAccent)),
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Color(0xffe3f1f8),
                          border: Border(
                            top: BorderSide(width: 1,color: Color(0xff017cc2)),
                            left: BorderSide(width: 1,color: Color(0xff017cc2)),
                            right: BorderSide(width: 1,color: Color(0xff017cc2)),
                            bottom: BorderSide(width: 1,color: Color(0xff017cc2)),
                          ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 8,top: 3,right: 8,bottom: 3),
                        child: Text("关注",style: new TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color: Colors.blueAccent)),
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15.0),
              child: Text(postsCtime.split('T')[0],style: textStyle)
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: Text(postcontent)
            ),
            Row(
              children: <Widget>[
                Container(
                  width: (width-40)*0.25,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.chat_bubble,
                        color: Colors.grey,
                        size: 17,
                      ),
                      Text(postDetail.repliesCount.toString(),style: textStyle2),
                    ],
                  ),
                ),
                Container(
                  width: (width-40)*0.25,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.thumb_up,
                        color: Colors.grey,
                        size: 17,
                      ),
                      Text(postDetail.postsLikes.toString(),style: textStyle2),
                    ],
                  ),
                ),
                Container(
                  width: (width-40)*0.25,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.thumb_down,
                        color: Colors.grey,
                        size: 17,
                      ),
                      Text(postDetail.postsDislikes.toString(),style: textStyle2),
                    ],
                  ),
                ),
                Container(
                  width: (width-40)*0.25,
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.grey,
                        size: 20,
                      ),
                      Text(postDetail.collections.toString(), style: textStyle2),
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

    final answerTitle = new Container(
      decoration: BoxDecoration(
        border: Border(bottom:BorderSide(width: 1,color: Color(0xffeeeeee),)),
      ),
//      color: Colors.blueAccent,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 20,bottom: 10),
          child: Text(
            "回答",
            style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16),
          ),
        ),
      ),
    );

//    final answers = new Container(
//      height: 360,
//      child: ListView(
//        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(
//              border: Border(bottom:BorderSide(width: 1,color: Color(0xffeeeeee),)),
//            ),
//            child: Padding(
//                padding: EdgeInsets.only(left: 20,top: 15,bottom: 15),
//                child: Row(
//                  children: <Widget>[
//                    Column(
//                      children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.only(bottom: 6),
//                          child: Row(
//                            children: <Widget>[
//                              Text("同学2",style: new TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
//                              Padding(
//                                padding: EdgeInsets.only(left: 20),
//                                child: Text("2020-4-30 13:35:36",style: textStyle),
//                              ),
//                              Padding(
//                                padding: EdgeInsets.only(left: 70,right: 5),
//                                child: Icon(Icons.bookmark_border,color: Colors.grey,size: 20,),
//                              ),
////                              Text("0",style: textStyle2),
//                              Padding(
//                                padding: EdgeInsets.only(left: 30,right: 5),
//                                child: Icon(Icons.favorite_border,color: Colors.grey,size: 18,),
//                              ),
//                              Text("0",style: textStyle2),
//                            ],
//                          ),
//                        ),
//                        Text("问题内容问题内容问题内容……",style: new TextStyle(color: Colors.black)),
//                        Padding(
//                          padding: EdgeInsets.only(left: 290,top: 10),
//                          child: Text("删除", style:new TextStyle(color:Colors.red,fontSize: 12),),
//                        ),
//                      ],
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                    ),
//                  ],
//                )
//            ),
//          ),
//        ],
//      ),
//    );

    final answersListContainer = new Container(
      height: 400,
      child: new ListView.builder(
          itemCount: answersList == null ? 0 : answersList.length,
          itemBuilder: (context,i){
            return new Container(
              decoration: BoxDecoration(
                border: Border(bottom:BorderSide(width: 1,color: Color(0xffeeeeee),)),
              ),
              child: Padding(
                  padding: EdgeInsets.only(left: 20,top: 15,bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: <Widget>[
                                Text("同学"+answersList[i]['creatorSid'].toString(),style: new TextStyle(fontWeight: FontWeight.w700,fontSize: 16),),
                                Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: new Container(
                                      width: 110,
                                      child: Text(answersList[i]['createDate'].toString().replaceAll("T", " "),style: textStyle),
                                    )

                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 70,right: 5),
                                  child: Icon(Icons.bookmark_border,color: Colors.grey,size: 20,),
                                ),
//                        Text("0",style: textStyle2),
                                Padding(
                                  padding: EdgeInsets.only(left: 30,right: 5),
                                  child: Icon(Icons.favorite_border,color: Colors.grey,size: 18,),
                                ),
                                Text(answersList[i]['zan'].toString(),style: textStyle2),
                              ],
                            ),
                          ),
                          Text(answersList[i]['content'].toString(),style: new TextStyle(color: Colors.black)),
                          Padding(
                            padding: EdgeInsets.only(left: 300,top: 10),
                            child: Text("删除", style:new TextStyle(color:Colors.red,fontSize: 12),),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ],
                  )
              ),
            );
//              AnswerList(answersList[i]['sid'],answersList[i]['content'],answersList[i]['creatorSid'],answersList[i]['createDate'],answersList[i]['questionSid'],answersList[i]['zan'],answersList[i]['mark']);
          }
      ),
    );

    final commentAndStar = new Row(
      children: <Widget>[
        Padding(
          padding: new EdgeInsets.only(left: 40.0,right: 35.0,top: 60.0),
          child: new MaterialButton(
            color: Colors.blueAccent,
            height: 40.0,
            minWidth: 250.0,
            onPressed: (){
//              Navigator.of(context).pushNamed(AnswerPage.tag);
//              Navigator.of(context).pushNamed(AnswerPage.tag,arguments: q.sid);
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: new Text('写 回 答 ……',style: new TextStyle(color: Colors.white),),
          ),
        ),
        Padding(
          padding: new EdgeInsets.only(top: 60.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.star_border,color: Colors.orange,size: 20,),
              Text("收藏",style: textStyle2),
            ],
          ),
        )

      ],
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        shrinkWrap: true,
        padding: new EdgeInsets.only(left: 0.0,right: 0.0,top: 0.0),
        children: <Widget>[
          title,
          SizedBox(height: 20.0),
          content,
//          questionDetail,
          answerTitle,
//          answers,
          answersListContainer,
          commentAndStar
        ],
      ),
    );
  }
}