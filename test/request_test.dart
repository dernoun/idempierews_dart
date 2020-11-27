import 'package:test/test.dart';
import 'package:idempierews_dart/idempierews_dart.dart';
import 'package:xml/xml.dart';

void main() {
  String dataRequest =
      '<soapenv:Envelope xmlns:_0="http://idempiere.org/ADInterface/1_0" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body><_0:createUpdateData><_0:ModelCRUDRequest><_0:ModelCRUD><_0:serviceType>CreateUpdateUser</_0:serviceType><_0:DataRow><_0:field column="Name"><_0:val>Joe Block</_0:val></_0:field><_0:field column="Phone"><_0:val>555-879-89</_0:val></_0:field><_0:field column="C_BPartner_ID"><_0:val>118</_0:val></_0:field><_0:field column="EMail"><_0:val>joeblock@gardenworld.com</_0:val></_0:field></_0:DataRow></_0:ModelCRUD><_0:ADLoginRequest><_0:user>superuser @ idempiere.com</_0:user><_0:pass>System</_0:pass><_0:ClientID>11</_0:ClientID><_0:RoleID>50004</_0:RoleID><_0:OrgID>11</_0:OrgID><_0:WarehouseID>103</_0:WarehouseID><_0:stage>5</_0:stage></_0:ADLoginRequest></_0:ModelCRUDRequest></_0:createUpdateData></soapenv:Body></soapenv:Envelope>';
  group('Xml Documents Test', () {
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

    test('Test Creating the request ', () {
      LoginRequest _login = new LoginRequest();
      _login.setUser = 'superuser @ idempiere.com';
      _login.setPass = 'System';
      _login.setClientID = 11;
      _login.setRoleID = 50004;
      _login.setOrgID = 11;
      _login.setStage = 5;
      _login.setWarehouseID = 103;
      CreateUpdateDataRequest createData = new CreateUpdateDataRequest();
      createData.setLogin = _login;
      createData.setWebServiceType = 'CreateUpdateUser';

      DataRow data = new DataRow();
      data.addField('Name', 'Joe Block');
      data.addField('Phone', '555-879-89');
      data.addField('C_BPartner_ID', '118');
      data.addField('EMail', 'joeblock@gardenworld.com');
      createData.setDataRow = data;
      expect(RequestFactory.createRequest(createData).toString(), dataRequest);
    });
  });
}
