import 'package:flutter/material.dart';
import 'package:interfacelogin/View/LoginView.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edit Profile Example',
      home: LoginView(),
    );
  }
}
