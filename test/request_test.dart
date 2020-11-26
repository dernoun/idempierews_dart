import 'package:test/test.dart';
import 'package:idempierews_dart/idempierews_dart.dart';
import 'package:xml/xml.dart';

void main() {
  group('Test creation of elements', () {
    test('Test Create Element _0', () {
      expect(RequestFactory.createXmlElement_0('operations').toString(),
          '<_0:operations/>');
    });

    test('Test Create Element _0', () {
      expect(
          RequestFactory.createXmlElementChild_0(
              'serviceType', [XmlText('CreateUpdateBPartner')]).toString(),
          '<_0:serviceType>CreateUpdateBPartner</_0:serviceType>');
    });
  });
}
