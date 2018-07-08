import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Math Time',
      theme: new ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: new MyHomePage(title: 'Math Time'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String question = "";
  int answer = 0;
  Random rand = new Random();

  final inputController = TextEditingController();

  void _newQuestion(){
    setState(() {

          int r = rand.nextInt(100);

          if(r < 10) {
            int num1 = rand.nextInt(5) + 1;
            int num2 = rand.nextInt(12) + 1;
            
            question = num1.toString() + " ^ " + num2.toString();
            answer = pow(num1, num2);

          } else if(r < 70){
            int num1 = rand.nextInt(30) + 1;
            int num2 = rand.nextInt(30) + 1;
            
            question = num1.toString() + " x " + num2.toString();
            answer = num1 * num2;
          } else if(r < 80 ){
            int num1 = rand.nextInt(1000);
            int num2 = rand.nextInt(1000);

            question = num1.toString() + " + " + num2.toString();
            answer = num1 + num2;
          } else {
            int num1 = rand.nextInt(1000);
            int num2 = rand.nextInt(1000);
            
            question = num1.toString() + " - " + num2.toString();
            answer = num1 - num2;
          }
          
    });
  }

  void _checkAnswer(){
    
    if(int.tryParse(inputController.text) == answer){
      inputController.text = "";
      _newQuestion();
    }
  }

  @override
  void initState() {
    super.initState();

    _newQuestion();

    inputController.addListener(_checkAnswer);
  }

  @override
  Widget build(BuildContext context) {

    final input = new TextField(
      controller: inputController,
      textAlign: TextAlign.center,
      decoration: new InputDecoration.collapsed(
        hintText: "answer",
        hintStyle: Theme.of(context).textTheme.display1
      ),
      obscureText: false,
      style: Theme.of(context).textTheme.display1,
    );

    return new Scaffold(
      body: new Center(        
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              question,
              style: Theme.of(context).textTheme.display3,
            ),
            new Center(
              child: input
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _newQuestion,
        tooltip: 'New Question',
        child: new Icon(Icons.loop),
      ),
    );
  }

  @override
  void dispose(){
    inputController.dispose();
    super.dispose();
  }
}
