import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text('Startup Name Generator'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ],
      ),
      body: _buildSuggestions(),
    );

  }

  Widget _buildSuggestions(){
    return ListView.builder(
        padding: EdgeInsets.all(16),
        itemBuilder: (context, i){
          if(i.isOdd) return Divider();

          final index = i ~/ 2;
          if(index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));

          }
          return _buildRow(_suggestions[index]);
        }


    );
  }

  Widget _buildRow(WordPair pair){

    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
        color: alreadySaved ? Colors.deepPurpleAccent : null,
      ),

      onTap: (){

        setState(() {

          if (alreadySaved){
            _saved.remove(pair);
          }
          else {
            _saved.add(pair);
          }

        });

      },
    );

  }

  void _pushSaved(){

    Navigator.of(context).push(

      MaterialPageRoute<void>(
          builder: (context) {

            final tiles = _saved.map(
                    (WordPair pair) {

                  return ListTile(
                    title: Text(
                      pair.asPascalCase,
                      style: _biggerFont,
                    ),
                  );
                }
            );

            final divided = ListTile.divideTiles(
              context: context,
              tiles: tiles,
            ).toList();

            return Scaffold(
              appBar: AppBar(
                title: Text('Saved Suggestions'),
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              body: ListView(children: divided),

            );

          }
      ),
    );

  }

}



