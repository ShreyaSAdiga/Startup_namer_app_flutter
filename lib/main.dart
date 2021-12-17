import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair=WordPair.random(); //Add this line
    return MaterialApp(
      title: 'Welcome to flutter',
      home: RandomWords(),
      /*Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to flutter'),
        ),
        body: Center(   //drop const here
          //child: const Text('Hello world'),  //replace this with the below code line
          child: /*Text(wordPair.asPascalCase,
          style:TextStyle(fontSize: 50)),*/RandomWords()
        ),
      ),*/
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords>{
  final _suggestions=<WordPair>[];
  final _saved=<WordPair>{};
  final _biggerFont= const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context){
    //final wordPair=WordPair.random();
    //return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(icon: const Icon(Icons.list),
              onPressed: _pushSaved,
              tooltip: 'Saved Suggestions',
          )
        ],
      ),
      body:_buildSuggestions(),
    );
  }
  Widget _buildSuggestions(){
    return ListView.builder(
        padding:const EdgeInsets.all(16),
        itemBuilder: (BuildContext _context,int i){
          if(i.isOdd){
            return Divider();
          }
          final int index=i~/2;
          if(index>=_suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }
  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder:(context){
          final tiles=_saved.map(
              (pair){
                return ListTile(
                  title:Text(
                    pair.asPascalCase,
                    style: _biggerFont,
                  ),
                );
              },
          );
          final divided=tiles.isNotEmpty
          ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              :<Widget>[];
          return Scaffold(
            appBar:AppBar(
              title: const Text('Saved suggestions'),
            ),
            body:ListView(children: divided),
          );
        },
      ),
    );
  }
  Widget _buildRow(WordPair pair) {
    final alreadySaved=_saved.contains(pair);
    return ListTile(
      title:Text(
        pair.asPascalCase,
        style:_biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite:Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
        semanticLabel: alreadySaved ? 'Remove from saved' : 'Save' ,
      ),
      onTap: (){
        setState(() {
          if(alreadySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }
}