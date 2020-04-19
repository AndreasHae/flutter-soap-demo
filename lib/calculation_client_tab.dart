import 'package:flutter/material.dart';

import 'client/calculation_client.dart';

class CalculationClientTab extends StatefulWidget {
  final CalculationClient calculationClient;

  const CalculationClientTab({Key key, this.calculationClient})
      : super(key: key);

  @override
  _CalculationClientTabState createState() => _CalculationClientTabState();
}

class _CalculationClientTabState extends State<CalculationClientTab> {
  List<int> _numbers = [0, 0];
  AddNumbersResponse _lastResponse;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
            title: Text(
                'The SOAP web service will add all given numbers together and return the result.')),
        ..._numbers.asMap().entries.map((entry) => ListTile(
          leading: Icon(Icons.filter_1),
          title: TextField(
            decoration: InputDecoration(hintText: 'A number'),
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              setState(() {
                _numbers[entry.key] = int.parse(newValue);
              });
            },
          ),
        )),
        ListTile(
          title: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _numbers.add(0);
              });
            },
          ),
        ),
        ListTile(
            title: RaisedButton(
              child: Text('Send request'),
              onPressed: () async {
                print(_numbers);
                final response = await widget.calculationClient
                    .addNumbers(AddNumbersRequest(_numbers));
                setState(() {
                  _lastResponse = response;
                });
              },
            )),
        Divider(),
        _lastResponse != null
            ? ListTile(
          title: Text("Result: ${_lastResponse.result}"),
        )
            : SizedBox.shrink()
      ],
    );
  }
}
