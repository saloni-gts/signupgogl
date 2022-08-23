import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FbPage extends StatefulWidget {
  final User fbuserdata;
  const FbPage({Key? key,required this.fbuserdata}) : super(key: key);

  @override
  State<FbPage> createState() => _FbPageState();
}

class _FbPageState extends State<FbPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FB Page"
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 20.0,),




          SizedBox(height: 20.0,),
          Center(child: Text("Name:${widget.fbuserdata.displayName}")),
          Center(child: Text("Email:${widget.fbuserdata.email}")),

          Center(child: TextButton(
              onPressed: (){logout(context);},
              child: Text("sign out"))),


        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FacebookAuth.instance.logOut();
    print("---------Log out-----------");
    Navigator.pop(context);

  }

}
