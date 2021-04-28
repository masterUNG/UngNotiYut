import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungnoti/states/authen.dart';
import 'package:ungnoti/states/create_account.dart';
import 'package:ungnoti/states/my_service.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/myService': (BuildContext context) => MyService(),
};

String initialRoute;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        initialRoute = '/authen';
        runApp(MyApp());
      } else {
        initialRoute = '/myService';
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}
