import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'FbPage.dart';
import 'homepage.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignInPage _googleSignIn = GoogleSignInPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB54tdYAwEtiaoxPAdtd5Oc0KyihZ9XWWg",
          appId: "1:1003494178830:android:dd00c6d939e31af5e27c5f",
          messagingSenderId: "",
          projectId: "signupgogl"));
  runApp(MainScreen());
  print("-------------firebase initialised-----------");
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GoogleSignInPage(),
    );
  }
}

class GoogleSignInPage extends StatefulWidget {
  const GoogleSignInPage({Key? key}) : super(key: key);

  @override
  State<GoogleSignInPage> createState() => _GoogleSignInPageState();
}

class _GoogleSignInPageState extends State<GoogleSignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("signup"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: TextButton(
                    onPressed: () {
                      signup(context);
                    },
                    child: Text("sign up with google"))),
            SizedBox(height: 20.0),
            Center(
                child: TextButton(
                    onPressed: () {
                      initiateFacebookLogin();
                    },
                    child: Text("sign up with facebook"))),
          ],
        ));
  }

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn google = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await google.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      print("============");
      UserCredential result = await auth.signInWithCredential(authCredential);
      print(result.user);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    userdata: result.user!,
                  )));
    }
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn();

    final AccessToken? currentAccessToken =
        await FacebookAuth.instance.accessToken;

    if (currentAccessToken != null) {

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(
              facebookLoginResult.accessToken!.token);
      UserCredential res =
          await auth.signInWithCredential(facebookAuthCredential);
      print("---------------");
      print(res.user);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FbPage(
                    fbuserdata: res.user!,
                  )));


    }
  }
}
