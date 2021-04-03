import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SavePage extends StatefulWidget {
  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  
  @override
    void initState() {
       Future.delayed(Duration(seconds: 2)).then((value) {
            Navigator.of(context).pop();
          });
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    final style=Theme.of(context).textTheme.headline1;
    return Scaffold(
        body: Container(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
      Container(
          height: 200,
          width: 200,
          child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Color(0xff24B4D6),
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(120)),
              child: Icon(Icons.done,size:100,color: Colors.white,)),
      ),
      SizedBox(height: 25,),
      Text('Saved successfully',style: style,),
      SizedBox(height: 25,),
       Text('Your item is saved for later',),
      SizedBox(height: 25,)
    ]),
        ));
  }
}
