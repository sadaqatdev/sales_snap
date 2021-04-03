import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SpalshScreen extends StatefulWidget {
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    final storage = GetStorage();
    bool isLogin = false;
    String login = storage.read('isLogin');
    login?.contains('yes') ?? false ? isLogin = true : isLogin = false;
    Future.delayed(Duration(seconds: 3)).then((value) {
      // Widget page = isLogin ? BottomNavBar() : LoginPage();
      // Get.offAll(page);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.4,
              0.6,
              0.9,
            ],
            // background-image: linear-gradient(to right top, #24b4d6, #81c4e9, #b9d4f3, #e3e8f9, #ffffff);
            colors: [
              Color(0Xffffffff),
              Color(0Xffb9d4f3),
              Color(0Xff81c4e9),
              Color(0Xff24b4d6),
            ],
          )),
          child: Image.asset('assets/splash.png'),
        ),
      ),
    );
  }
}
