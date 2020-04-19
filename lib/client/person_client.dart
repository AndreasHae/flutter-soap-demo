import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';

import 'soap_client.dart';

class PersonClient extends SoapClient {
  Future<GetPeopleResponse> getPeopleByAge(
      GetPeopleByAgeRequest request) async {
    return GetPeopleResponse.fromXml(await post(request.toXml()));
  }
}

@immutable
class GetPeopleResponse {
  final List<Person> people;

  GetPeopleResponse(this.people);

  factory GetPeopleResponse.fromXml(XmlParent document) {
    final people = List<Person>();
    final uri = 'http://spengergasse.at/hae17487/soapdemo/schema';
    for (final personNode
        in document.findAllElements('person', namespace: uri)) {
      people.add(Person.fromXml(personNode));
    }
    return GetPeopleResponse(people);
  }
}

@immutable
class Person {
  final String name;
  final int age;
  final String occupation;
  final String company;

  Person({this.name, this.age, this.occupation, this.company});

  factory Person.fromXml(XmlElement personNode) {
    final uri = 'http://spengergasse.at/hae17487/soapdemo/schema';
    return Person(
        name: personNode.findElements('name', namespace: uri).first.text,
        age: int.parse(
            personNode.findElements('age', namespace: uri).first.text),
        occupation:
            personNode.findElements('occupation', namespace: uri).first.text,
        company: personNode.findElements('company', namespace: uri).first.text);
  }
}

@immutable
class GetPeopleByAgeRequest {
  final int minAge;
  final int maxAge;

  GetPeopleByAgeRequest({this.minAge, this.maxAge});

  XmlElement toXml() {
    final uri = 'http://spengergasse.at/hae17487/soapdemo/schema';
    final xml = XmlBuilder();
    xml.element('getPeopleByAgeRequest', namespace: uri, nest: () {
      xml.namespace(uri, 'ws');
      xml.element('minAge', namespace: uri, nest: minAge);
      xml.element('maxAge', namespace: uri, nest: maxAge);
    });
    return (xml.build() as XmlDocument).rootElement;
  }
}
