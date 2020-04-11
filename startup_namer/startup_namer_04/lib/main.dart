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
// StatelessWidget 组件
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // STEP 5
    // 定义 wordPair
    // final wordPair = WordPair.random();
    return new MaterialApp(
      // STEP 6 略
      // STEP 14 
      // 展示内容
      home: new RandomWords(),
    );
  }
}
// STEP 8
//  StatefulWidge 组件
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
// STEP 7 
// State 组件
class RandomWordsState extends State<RandomWords> {
  // STEP 10
  // 定义 用于保存单词的 列表 和 关于字体大小的 变量 
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0); 
  @override
  Widget build(BuildContext context) {
    // STEP 9
    // 返回内容
    // final wordPair = WordPair.random();
    // return new Text(wordPair.asPascalCase);
    // STEP 13
    // 返回 Scaffold
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome')
      ),
      // STEP 14
      // 调用 _buildSuggestions()函数
      body: _buildSuggestions()
    );
  }
  // STEP 11
  // _buildSuggestions()函数
  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      // 对于每个建议的单词对都会调用一次 itemBuilder，
      // 然后将单词对添加到 ListTile 行中
      // 在偶数行，该函数会为单词对添加一个 ListTile row.
      // 在奇数行，该函数会添加一个分割线的 widget，来分隔相邻的词对。
      // 注意，在小屏幕上，分割线看起来可能比较吃力。
      itemBuilder: (BuildContext _context, int i){
        // 在每一列之前，添加一个1像素高的分隔线widget
        if(i.isOdd){
          return new Divider();
        }
        // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整）
        // 比如 i 为：1, 2, 3, 4, 5 时，结果为 0, 1, 1, 2, 2，
        // 这可以计算出 ListView 中减去分隔线后的实际单词对数量
        final int index = i ~/ 2;
        // 如果是建议列表中最后一个单词对
        if (index >= _suggestions.length){
          // ...接着再生成10个单词对，然后添加到建议列表
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      }
    );
  }
  // STEP 12
  // _buildRow()函数
  Widget _buildRow(WordPair pair){
    return ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}