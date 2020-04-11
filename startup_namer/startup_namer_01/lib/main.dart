// STEP 1
// 引入 material 风格 
import 'package:flutter/material.dart';
// STEP 2
// 主函数
// void main() => runApp(MyApp());
void main(){
  return runApp(MyApp());
}
// STEP 3
// 静态组件
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome')
        ),
        body: new Center(
          child: new Text('hello')
        ),
      )
    );
  }
}