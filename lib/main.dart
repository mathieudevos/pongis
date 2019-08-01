import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = 'Test App';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(title),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: Firestore.instance.collection('players').where('name', isEqualTo: 'Mathieu').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const CircularProgressIndicator();
                          if (snapshot.data.documents.length == 0) return const Text('no data!');
                          DocumentSnapshot document = snapshot.data.documents[0];
                          return GestureDetector(
                            onTap: () => document.reference.updateData({
                              'score': document['score'] + 1,
                            }),
                            onLongPress: () => document.reference.updateData({
                              'score': document['score'] - 1,
                            }),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(document['name'], style: TextStyle(fontSize: 32)),
                                Text(document['score'].toString(), style: TextStyle(fontSize: 72)),
                              ],
                            ),
                          );
                        }
                      ),
                    ),
                    VerticalDivider(),
                    Expanded(
                      child: StreamBuilder(
                        stream: Firestore.instance.collection('players').where('name', isEqualTo: 'Juanjo').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const CircularProgressIndicator();
                          if (snapshot.data.documents.length == 0) return const Text('no data!');
                          DocumentSnapshot document = snapshot.data.documents[0];
                          return GestureDetector(
                            onTap: () => document.reference.updateData({
                              'score': document['score'] + 1,
                            }),
                            onLongPress: () => document.reference.updateData({
                              'score': document['score'] - 1,
                            }),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(document['name'], style: TextStyle(fontSize: 32)),
                                Text(document['score'].toString(), style: TextStyle(fontSize: 72)),
                              ],
                        ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  final String playerName;
  final int score;
  final DocumentReference reference;

  const ScoreCard({
    Key key,
    this.score,
    this.playerName,
    this.reference,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('hey'),
    );
  }
}