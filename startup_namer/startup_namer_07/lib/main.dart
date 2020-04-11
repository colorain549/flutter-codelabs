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
      // STEP 24
      theme: new ThemeData(
        primaryColor: Colors.green
      ),
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
  // 定义 用于保存 单词的 列表  
  final List<WordPair> _suggestions = <WordPair>[];
  // STEP 15
  // 定义 用于保存 收藏单词的 列表
  final Set<WordPair> _saved = new Set<WordPair>(); 
  // STEP 10 
  // 定义 字体大小的 变量
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0); 
  // STEP 20
  // 添加 _pushSaved() 方法 
  void _pushSaved(){
    // STEP 21
    // 添加 Navigator.push 调用，这会使路由入栈（以后路由入栈均指推入到导航管理器的栈）
    Navigator.of(context).push(
      // STEP 22
      // 添加 MaterialPageRoute 及其 builder
      // 添加生成 ListTile 行的代码，ListTile 的 divideTiles() 方法在每个 ListTile 之间添加 1 像素的分割线。
      // 该 divided 变量持有最终的列表项，并通过 toList()方法非常方便的转换成列表显示。
      // builder 返回一个 Scaffold，其中包含名为"Saved Suggestions"的新路由的应用栏。
      // 新路由的body 由包含 ListTiles 行的 ListView 组成；每行之间通过一个分隔线分隔。
      new MaterialPageRoute<void>(
        builder: (BuildContext context){
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair){
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList(); 
          // STEP 23 
          // 添加水平分隔符
        return new Scaffold(
          appBar: new AppBar(
            title: new Text('Saved')
          ),
          body: new ListView(children: divided),
        );
        }
      )
    );
  }
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
        title: new Text('Welcome'),
        // STEP 19
        // 将该图标及其相应的操作添加到 build 方法中
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved),
        ],
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
    // STEP 16
    // 添加 alreadySaved 来检查确保单词对还没有添加到收藏夹中。
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // STEP 17
      // 向列表添加图标
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      // STEP 18
      // 添加交互
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}