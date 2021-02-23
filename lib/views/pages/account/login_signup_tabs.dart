import 'package:flutter/material.dart';

import 'login_page.dart';
import 'sign_up_page.dart';

class LoginSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style =
        Theme.of(context).textTheme.headline1.copyWith(color: Colors.white);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(),
            toolbarHeight: 60,
            bottom: TabBar(
              indicatorPadding: EdgeInsets.only(top: 12),
              labelPadding: EdgeInsets.only(bottom: 12, top: 12),
              tabs: [
                Text(
                  'Login',
                  style: style,
                ),
                Text('SignUp', style: style)
              ],
            ),
          ),
          body: TabBarView(
            children: [LoginPage(), SignUpPage()],
          ),
        ),
      ),
    );
  }
}
