import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/entity/post.dart';
import 'package:seekseek/ui/detail.dart';

import '../../main.dart';

class CollectPage extends StatefulWidget {
  static String tag = 'collect-page';
  @override
  _CollectPageState createState() => new _CollectPageState();
}

class _CollectPageState extends State<CollectPage> {
  final controller = TextEditingController();

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  List posts = [];

  getPosts() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/posts/myList?userId='+MyApp.userId.toString();
    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if (response.statusCode == 200) {
      responseBody = await response.transform(utf8.decoder).join();
      responseBody = json.decode(responseBody);
      posts = responseBody;
      print(posts);
    } else {
      print("error");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final title = new PreferredSize(
        child: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: InkWell(
            child: Text(
              "我的收藏",
              style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
            ),
            onTap: () {
            },
          ),
          centerTitle: true,
        ));

    final postsList = new Container(
      height: height - 80,
      child: new ListView.builder(
//          保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: posts == null ? 0 : posts.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: (){
//                Navigator.of(context).pushNamed(DetailPage.tag,arguments: postEntity(posts[i]['postsId'],posts[i]['postsTitle'],posts[i]['postsBelongs'],posts[i]['subjectName'],posts[i]['postsCreator'],posts[i]['creatorName'],posts[i]['postsLikes'],posts[i]['postsDislikes'],posts[i]['collections'],posts[i]['repliesCount'],));
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
                            padding:
                            EdgeInsets.only(left: 20, bottom: 6, right: 20),
//                            用户名
                            child: Text(posts[i]['creatorName'].toString(),style: new TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.blueAccent)),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 20, bottom: 6, right: 20),
//                            标题
                            child: Text(posts[i]['postsTitle'].toString(),
                                style: new TextStyle(
                                    fontSize: 14)),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(left: 20, bottom: 6, right: 20),
//                            标题
                            child: Text(posts[i]['postsUpdateTime'].toString().split('T')[0],
                                style: new TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            );
          }),
    );

    Future<Null> _onRefresh() async {
      await Future.delayed(Duration(seconds: 1), () {
        print('refresh');
        getPosts();
        setState(() {
        });
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
          new RefreshIndicator(
            onRefresh: _onRefresh,
            child: postsList,
          ),
          SizedBox(
            height: 45.0,
          ),
//        pagelist[_currentIndex],
        ],
      ),
    );
  }
}
