import 'package:flutter/material.dart';

import 'calculation_client_tab.dart';
import 'client/calculation_client.dart';
import 'client/person_client.dart';
import 'person_client_tab.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOAP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SOAP Demo Client'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  final List<Widget> tabs = [
    PersonClientTab(
      personClient: PersonClient(),
    ),
    CalculationClientTab(
      calculationClient: CalculationClient(),
    )
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.tabs[tab],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text('Person Client')),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_1), title: Text('Calculation Client'))
        ],
        currentIndex: tab,
        onTap: (newTab) {
          setState(() {
            tab = newTab;
          });
        },
      ),
    );
  }
}
