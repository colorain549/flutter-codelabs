// STEP 1
// 引入 material 风格
import 'package:flutter/material.dart';
// STEP 4
// 引入 english_words 开源软件包
import 'package:english_words/english_words.dart';
// STEP 2
// 主函数
// void main() => runApp(MyApp());
void main() {
  return runApp(MyApp());
}
// STEP 3
// 静态组件
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // STEP 5
    // 定义 wordPair
    final wordPair = WordPair.random();
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Welcome')
            ),
          body: new Center(
        // child: new Text('hello')
        // STEP 6 
        // 展示内容
        child: new Text(wordPair.asPascalCase),
        ),
      )
    );
  }
}