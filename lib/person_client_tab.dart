import 'package:flutter/material.dart';

import 'client/person_client.dart';

class PersonClientTab extends StatefulWidget {
  final PersonClient personClient;

  const PersonClientTab({Key key, this.personClient}) : super(key: key);

  @override
  _PersonClientTabState createState() => _PersonClientTabState();
}

class _PersonClientTabState extends State<PersonClientTab> {
  int _minAge;
  int _maxAge;
  GetPeopleResponse _lastResponse;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
            title: Text(
                'The SOAP web service will send a response with all users having ages in the given range.')),
        ListTile(
          leading: Icon(Icons.keyboard_arrow_right),
          title: TextField(
            decoration: InputDecoration(hintText: 'Min. age'),
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              setState(() {
                _minAge = int.parse(newValue);
              });
            },
          ),
        ),
        ListTile(
          leading: Icon(Icons.keyboard_arrow_left),
          title: TextField(
            decoration: InputDecoration(hintText: 'Max. age'),
            keyboardType: TextInputType.number,
            onChanged: (newValue) {
              setState(() {
                _maxAge = int.parse(newValue);
              });
            },
          ),
        ),
        ListTile(
          title: RaisedButton(
            child: Text('Send request'),
            onPressed: () async {
              final response = await widget.personClient.getPeopleByAge(
                GetPeopleByAgeRequest(minAge: _minAge, maxAge: _maxAge),
              );
              setState(() {
                _lastResponse = response;
              });
            },
          ),
        ),
        Divider(),
        ..._lastResponse?.people?.map((person) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(person.name),
                      subtitle: Text(
                          "${person.age}, ${person.occupation} at ${person.company}"),
                    ),
                  ],
                )) ??
            [SizedBox.shrink()]
      ],
    );
  }
}
