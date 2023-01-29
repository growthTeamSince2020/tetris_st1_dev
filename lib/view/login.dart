import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class login extends StatelessWidget {
  static final googleLogin = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  void logIn() async {

    // Google認証を行う
    final account = await googleLogin.signIn();

    // ログインに失敗したら処理終了
    if(account == null) return;

    // 認証情報の取得？
    GoogleSignInAuthentication auth = await account.authentication;

    //
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
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
              image: AssetImage('assets/images/white_wood.jpg'),
              //image: AssetImage(''),
              fit: BoxFit.fill,
            )),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ElevatedButton(
                // 立体的なボタンコメント追加
                onPressed: () => logIn(),
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
            ],
          ),
        ),
      ),
    );
  }
}
