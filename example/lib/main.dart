import 'package:flutter/material.dart';
import 'package:listenable_undo/undo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ListenableStack(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listenable Undo and Redo Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Listenable Undo and Redo Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _revertCounter(int counterValue) {
    setState(() {
      _counter = counterValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Consumer<ListenableStack>(
            builder: (context, value, child) => IconButton(
              onPressed: value.canUndo ? value.undo : null,
              icon: Icon(Icons.undo),
            ),
          ),
          SizedBox(width: 10),
          Consumer<ListenableStack>(
            builder: (context, value, child) => IconButton(
              onPressed: value.canRedo ? value.redo : null,
              icon: Icon(Icons.redo),
            ),
          ),
          SizedBox(width: 60),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headline4),
          ],
        ),
      ),
      floatingActionButton: Consumer<ListenableStack>(
        builder: (context, value, child) => FloatingActionButton(
          onPressed: () {
            value.add(Change(_counter, _incrementCounter, _revertCounter));
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
