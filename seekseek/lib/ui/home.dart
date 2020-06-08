import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:seekseek/entity/post.dart';
import 'package:seekseek/ui/detail.dart';
import 'package:seekseek/ui/person/person.dart';
import 'package:seekseek/ui/search.dart';
import 'package:seekseek/ui/subject.dart';

import '../main.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();

  int _currentIndex = 0;
  List<Widget> pagelist = List();

  TextStyle textStyle = const TextStyle(fontSize: 12, color: Colors.orange);

  @override
  void initState() {
//  导航栏页面
    pagelist..add(HomePage())..add(SubjectPage())..add(PersonPage());
    super.initState();
    getPosts();
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

  List posts = [];
  int index = 0;
  getPosts() async {
    var responseBody;
    var url = 'http://101.132.157.72:8084/posts/myList?userId=' +
        MyApp.userId.toString();
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    getPosts();

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

//    初始模板
    new Container(
      color: Colors.blueAccent,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Container(
          height: 68.0,
          child: new Padding(
              padding: const EdgeInsets.all(6.0),
              child: new Card(
                  child: new Container(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
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
                    new IconButton(
                      icon: new Icon(Icons.cancel),
                      color: Colors.grey,
                      iconSize: 18.0,
                      onPressed: () {
                        controller.clear();
                        // onSearchTextChanged('');
                      },
                    ),
                  ],
                ),
              ))),
        ),
      ),
    );

//    final list = new Container(
//      width: width,
//      height: 520,
//      child: ListView(
//        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(
//              border: Border(bottom:BorderSide(width: 3,color: Color(0xffeeeeee),)),
//            ),
//            child: Padding(
//                padding: EdgeInsets.only(top: 15,bottom: 15),
//                child: Row(
//                  children: <Widget>[
//                    Container(
//                      width: width,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Padding(
//                            padding: EdgeInsets.only(left:20,bottom: 6,right: 20),
//                            child: Text("学科圈",style: new TextStyle(fontWeight: FontWeight.w700,fontSize: 16)),
//                          ),
//                          Padding(
//                            padding: EdgeInsets.only(left:20,bottom: 6,right: 20),
//                            child: Text("@"+"柒月夏",style: new TextStyle(fontSize: 12,color: Colors.blueAccent)),
//                          ),
//                          Padding(
//                            padding: EdgeInsets.only(left:20,bottom: 6,right: 20),
//                            child: Text("问题内容问题内容问题内容问题内容问题内容问题内容",style: new TextStyle(fontSize: 12,color: Colors.grey)),
//                          ),
//                          Padding(
//                            padding: EdgeInsets.only(left:20,bottom: 6,right: 20),
//                            child: Row (
//                              children: <Widget>[
//                                Icon(Icons.chat_bubble,color: Colors.grey,size: 17,),
//                                Padding(
//                                  padding: EdgeInsets.only(left: 5,right: 20),
//                                  child: Text("0",style: textStyle),
//                                ),
//                                Icon(Icons.thumb_up,color: Colors.grey,size: 17,),
//                                Padding(
//                                  padding: EdgeInsets.only(left: 5,right: 20),
//                                  child: Text("0",style: textStyle),
//                                ),
//                                Icon(Icons.thumb_down,color: Colors.grey,size: 17,),
//                                Padding(
//                                  padding: EdgeInsets.only(left: 5,right: 20),
//                                  child: Text("0",style: textStyle),
//                                ),
//                                Icon(Icons.star,color: Colors.grey,size: 20,),
//                                Padding(
//                                  padding: EdgeInsets.only(left: 5),
//                                  child: Text("0",style: textStyle),
//                                ),
//                              ],
//                            ),
//                          ),
//                        ],
//                      ),
//                    )
//                  ],
//                )
//            ),
//          ),
//        ],
//      ),
//    );

    final postsList = new Container(
      height: height - 170,
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
                            padding:
                                EdgeInsets.only(left: 20, bottom: 6, right: 20),
//                            学科
                            child: Text(posts[i]['subjectName'].toString(),
                                style: new TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 16)),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, bottom: 6, right: 20),
//                            用户名
                            child: Text(
                                "@ " + posts[i]['creatorName'].toString(),
                                style: new TextStyle(
                                    fontSize: 12, color: Colors.blueAccent)),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 20, bottom: 6, right: 20),
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
                                  padding: EdgeInsets.only(left: 5, right: 20),
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
                                  padding: EdgeInsets.only(left: 5, right: 20),
                                  child: Text(posts[i]['postsLikes'].toString(),
                                      style: textStyle),
                                ),
                                Icon(
                                  Icons.thumb_down,
                                  color: Colors.grey,
                                  size: 17,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5, right: 20),
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
    );

    Future<Null> _onRefresh() async {
      await Future.delayed(Duration(seconds: 1), () {
        print('refresh');
        getPosts();
        setState(() {});
      });
    }

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
//          模板
//          list,
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
