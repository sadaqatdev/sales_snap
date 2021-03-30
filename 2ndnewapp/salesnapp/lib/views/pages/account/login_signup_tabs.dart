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
            toolbarHeight: 90,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24))),
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(top: 16, left: 12, right: 12),
              child: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
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
          ), 
          body: TabBarView(
            children: [LoginPage(), SignUpPage()],
          ),
        ),
      ),
    );
  }
}
