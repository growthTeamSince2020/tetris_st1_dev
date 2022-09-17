import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tetris_st1_dev/view/singlePlay.dart';
import 'package:tetris_st1_dev/view/top.dart';

import '../domain/state/tetrisData.dart';

//main.dartはルーティングのみ実装
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => Data(),
      child: MyApp(),
    ),
  );
}

// MyApp： 自分で作成したWidget____
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //常に画面を縦向きにする
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(home: top(), routes: <String, WidgetBuilder>{
      '/top': (BuildContext context) => top(), // 最初のページ
      '/singlePlay': (BuildContext context) => singlePlay() // 次のページ
    });
  }
}

//テスト　糸井
