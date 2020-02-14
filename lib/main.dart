import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bug Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<int>> list =
      Future.delayed(const Duration(milliseconds: 3000), () {
    return List.generate(10000, (int index) => index + 1);
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: list, // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        Widget startButton;

        if (snapshot.hasData) {
          snapshot.data.shuffle();

          startButton = RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewView(data: snapshot.data),
                    ));
              },
              child: const Text('Go'));
        } else {
          startButton = SizedBox(
            child: CircularProgressIndicator(),
            width: 60,
            height: 60,
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Homepage"),
          ),
          body: Center(child: startButton),
        );
      },
    );
  }
}

class NewView extends StatefulWidget {
  NewView({Key key, this.data}) : super(key: key);

  final List<int> data;

  @override
  _NewViewState createState() => _NewViewState();
}

class _NewViewState extends State<NewView> {
  List<int> data;
  int state = 1;

  @override
  void initState() {
    data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewView"),
      ),
      body: Column(
        children: <Widget>[
          Text("data is " + data[0].toString()),
          Text("state is " + state.toString()),
          RaisedButton(
              onPressed: () {
                setState(() {
                  state++;
                });
              },
              child: const Text('Increment State')),
        ],
      ),
    );
  }
}
