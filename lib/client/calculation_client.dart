import 'package:flutter/foundation.dart';
import 'package:xml/xml.dart';

import 'soap_client.dart';

class CalculationClient extends SoapClient {
  Future<AddNumbersResponse> addNumbers(AddNumbersRequest request) async {
    return AddNumbersResponse.fromXml(await post(request.toXml()));
  }
}

@immutable
class AddNumbersRequest {
  final List<int> numbers;

  AddNumbersRequest(this.numbers);

  XmlElement toXml() {
    final uri = 'http://spengergasse.at/hae17487/soapdemo/schema';
    final xml = XmlBuilder();
    xml.element('addNumbersRequest', namespace: uri, nest: () {
      xml.namespace(uri, 'ws');
      for (final number in numbers) {
        xml.element('number', namespace: uri, nest: number);
      }
    });
    return (xml.build() as XmlDocument).rootElement;
  }
}

@immutable
class AddNumbersResponse {
  final int result;

  AddNumbersResponse(this.result);

  factory AddNumbersResponse.fromXml(XmlParent document) {
    final uri = 'http://spengergasse.at/hae17487/soapdemo/schema';
    return AddNumbersResponse(int.parse(
        document.findAllElements('result', namespace: uri).first.text));
  }
}
