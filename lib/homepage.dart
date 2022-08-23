import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User userdata;
  const HomePage({Key? key,required this.userdata}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home Page"
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(child: Text("Name:${widget.userdata.displayName}")),
        Center(child: Text("Email:${widget.userdata.email}")),
        SizedBox(height: 20.0,),
        Center(child: TextButton(
            onPressed: (){signout(context);},
            child: Text("sign out"))),

        // SizedBox(height: 20.0,),
        // Center(child: Text("Name:${widget.fbuserdata.displayName}")),
        // Center(child: Text("Email:${widget.fbuserdata.email}")),
        //

      ],
      ),
    );
  }

  Future<void> signout(BuildContext context) async {
    await   FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    print("================Sign out===================");
  }
}
