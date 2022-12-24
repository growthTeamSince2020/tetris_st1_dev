import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatelessWidget {
  static final googleLogin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  void logIn() async {
    GoogleSignInAccount sAccount = await googleLogin.signIn();

    GoogleSignInAuthentication auth = await sAccount.authentication;
    final credential = GoogleAuthProvider.getCredential(
      idToken: auth.idToken,
      accessToken: auth.accessToken,
    );
    FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.orange,
            image: DecorationImage(
               // image: AssetImage('assets/images/white_wood.jpg'),
              image: AssetImage(''),
              fit: BoxFit.fill,
            )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                // 立体的なボタンコメント追加
                onPressed: () =>
                    Navigator.of(context).pushNamed("/"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                  onPrimary: Colors.black,
                  side: const BorderSide(
                    color: Colors.black, //枠線!
                    width: 3, //枠線！ß
                  ),
                ),
                child: const Text(
                  "克基",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                // 立体的なボタン
                onPressed: () =>
                    Navigator.pop(context), // 次の画面を乗せる
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  elevation: 0,
                  onPrimary: Colors.black,
                  side: const BorderSide(
                    color: Colors.black, //枠線!
                    width: 3, //枠線！
                  ),
                ),
                child: const Text(
                  "戻る",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
