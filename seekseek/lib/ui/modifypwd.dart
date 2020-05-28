import 'package:flutter/material.dart';

class ModifypwdPage extends StatefulWidget {
  static String tag = 'modifypwd-page';
  @override
  _ModifypwdPageState createState() => new _ModifypwdPageState();
}

class _ModifypwdPageState extends State<ModifypwdPage> {

  var _selectType;

  var resultJson = "";

  String _school,_sno, _password;

  @override
  void initState() {
    super.initState();
  }

//  login() async {
//    try {
//      print('登录中');
//      Response response;
//      Dio dio = new Dio();
//      response = await dio.post("http://39.96.76.183:8080/login",data: {
//        "school":_school,
//        "sno":_sno,
//        "password":_password
//      }, );
//      if (response.statusCode == 200) {
//        print(response);
//        Navigator.of(context).pushNamed(HomePage.tag);
//      } else {
//      }
//    } catch (exception) {
//      print('exc:$exception');
//    }
//    setState(() {});
//  }

  @override
  Widget build(BuildContext context) {
    final title = new PreferredSize(
        child: AppBar(
          elevation: 3,
          backgroundColor: Colors.white,
          title: InkWell(
            child: Text(
              "修改密码",
              style: TextStyle(fontSize: 18, color: Color(0xFF000000)),
            ),
            onTap: () {
            },
          ),
          centerTitle: true,
        ));

    final phoneInput = Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child:  new TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        decoration: new InputDecoration(
            hintText: '手机号',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value){
          setState(() {
            _sno = value;
          });
        },
//      onSaved
      ),
    );

    final passwordInput = Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child:  new TextFormField(
        autofocus: false,
        initialValue: '',
        obscureText: true,
        decoration:  new InputDecoration(
            hintText: '请输入原密码',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
//      onSaved
      ),
    );

    final passwordInput2 = Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child:  new TextFormField(
        autofocus: false,
        initialValue: '',
        obscureText: true,
        decoration:  new InputDecoration(
            hintText: '请输入新密码',
            contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
            )
        ),
        onChanged: (value) {
          setState(() {
            _password = value;
          });
        },
//      onSaved
      ),
    );

    final login = new Padding(
      padding: new EdgeInsets.only(left: 50.0,right: 50.0,top: 0.0),
      child: new MaterialButton(
        color: Colors.blueAccent,
        height: 48.0,
        onPressed: (){
//          Navigator.pop(context);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: new Text('登      录',style: new TextStyle(color: Colors.white),),
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new ListView(
        shrinkWrap: true,
        padding: new EdgeInsets.only(left: 0.0,right: 0.0,top: 0.0),
        children: <Widget>[
          title,
          SizedBox(height: 50.0,),
          phoneInput,
          SizedBox(height: 30.0,),
          passwordInput,
          SizedBox(height: 30.0,),
          passwordInput2,
          SizedBox(height: 50.0,),
          login,
        ],
      ),
    );
  }
}