import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungnoti/models/user_model.dart';
import 'package:ungnoti/utility/my_constant.dart';
import 'package:ungnoti/widget/show_listdata.dart';
import 'package:ungnoti/widget/show_webview.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String email;
  UserModel userModel;
  List<String> titles = ['Show WebView', 'Show ListData'];
  List<Widget> widgets = [ShowWebView(), ShowListData()];
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUserLogin();
  }

  Future<Null> findUserLogin() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        email = event.email;
        print('### email logined = $email');
        String api =
            '${MyConstant.domain}/aic/getUserWhereUser.php?isAdd=true&user=$email';
        await Dio().get(api).then((value) {
          print('### value ==>> $value');
          for (var item in json.decode(value.data)) {
            setState(() {
              userModel = UserModel.fromMap(item);
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            buildMySignOut(),
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                buildMenuShowWebView(context),
                buildMenuShowListData(context),
              ],
            ),
          ],
        ),
      ),
      body: widgets[index],
    );
  }

  ListTile buildMenuShowWebView(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.filter_1),
      title: Text(titles[0]),
      onTap: () {
        setState(() {
          index = 0;
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildMenuShowListData(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.filter_2),
      title: Text(titles[1]),
      onTap: () {
        setState(() {
          index = 1;
        });
        Navigator.pop(context);
      },
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(userModel == null ? 'Name ?' : userModel.name),
      accountEmail: Text(email == null ? 'Email ?' : email),
    );
  }

  Column buildMySignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Color(0xffffffff),
          ),
          title: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
          tileColor: Colors.red[700],
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
        ),
      ],
    );
  }
}
