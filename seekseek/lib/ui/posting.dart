import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:seekseek/common/toastHelper.dart';
import 'package:seekseek/main.dart';

class PostingPage extends StatefulWidget {
  static String tag = 'posting-page';
  @override
  _PostingPageState createState() => new _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {

  var resultJson = "";

  int subjectId;
  String postTitle;
  String postContent;
  List result;

  @override
  void initState() {
    super.initState();
    postTitle = "";
    postContent = "";
  }

  @override
  Widget build(BuildContext context) {
    subjectId = ModalRoute.of(context).settings.arguments;

    post() async {
      try {
        Response response;
        Dio dio = new Dio();
//      Dio dio = new Dio(options);
        if(postTitle ==null || postTitle=="" || postContent ==null || postContent==""){
          ToastHelper.showToast(context, "内容不能为空");
        }
        else{
          response = await dio.post("http://101.132.157.72:8084/posts/newPosts",data: {
            "postsTitle":postTitle,
            "postsBelongs":subjectId,
            "postsContent":postContent,
            "postsCreator":MyApp.userId,
          }, );
          if (response.statusCode == 200) {
            print("post"+response.toString());
//          Map map = response.data as Map;
//          result = map.values.toList();
            Navigator.pop(context);
          }
        }
      } catch (exception) {
        print('exc:$exception');
      }
//    setState(() {});
    }

    final title = new PreferredSize(
        child: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: InkWell(
            child: Text(
              "发帖",
              style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
            ),
            onTap: () {
            },
          ),
          centerTitle: true,
        ));

    final titleInput = Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child: new TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        decoration: new InputDecoration(
            hintText: '标题',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value){
          setState(() {
            postTitle = value;
          });
        },
//      onSaved
      ),
    );

    final content = new Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0),
      child:  new TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 10,
        decoration: new InputDecoration(
            hintText: '发个帖子吧……',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value){
          setState(() {
            postContent = value;
          });
        },
      ),
    );



    final submit = new Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 50.0),
      child: new MaterialButton(
        color: Colors.blueAccent,
        height: 48.0,
        onPressed: (){
          post();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: new Text('提      交',style: new TextStyle(color: Colors.white),),
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        shrinkWrap: true,
        padding: new EdgeInsets.only(left: 0.0,right: 0.0,top: 0.0),
        children: <Widget>[
          title,
          SizedBox(height: 60.0),
          titleInput,
          SizedBox(height: 30.0),
          content,
          submit
        ],
      ),
    );
  }
}