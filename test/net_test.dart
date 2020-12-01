import 'package:idempierews_dart/src/base.dart';
import 'package:idempierews_dart/src/request.dart';
import 'package:test/test.dart';
import 'package:idempierews_dart/src/net.dart';

void main() {
  String dataRequest =
      '<soapenv:Envelope xmlns:_0="http://idempiere.org/ADInterface/1_0" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"><soapenv:Header/><soapenv:Body><_0:createUpdateData><_0:ModelCRUDRequest><_0:ModelCRUD><_0:serviceType>CreateUpdateUser</_0:serviceType><_0:DataRow><_0:field column="Name"><_0:val>Joe Block</_0:val></_0:field><_0:field column="Phone"><_0:val>555-879-89</_0:val></_0:field><_0:field column="C_BPartner_ID"><_0:val>118</_0:val></_0:field><_0:field column="EMail"><_0:val>joeblock@gardenworld.com</_0:val></_0:field></_0:DataRow></_0:ModelCRUD><_0:ADLoginRequest><_0:user>superuser @ idempiere.com</_0:user><_0:pass>System</_0:pass><_0:ClientID>11</_0:ClientID><_0:RoleID>50004</_0:RoleID><_0:OrgID>11</_0:OrgID><_0:WarehouseID>103</_0:WarehouseID><_0:stage>2</_0:stage></_0:ADLoginRequest></_0:ModelCRUDRequest></_0:createUpdateData></soapenv:Body></soapenv:Envelope>';
  // XmlDocument xmlDocumentRequest = XmlDocument.parse(dataRequest);
  String dataResponse =
      '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ns1:createUpdateDataResponse xmlns:ns1="http://idempiere.org/ADInterface/1_0"><StandardResponse xmlns="http://idempiere.org/ADInterface/1_0" RecordID="1000011"></StandardResponse></ns1:createUpdateDataResponse></soap:Body></soap:Envelope>';
  // XmlDocument xmlDocument = XmlDocument.parse(dataResponse);
  test('Test the return of the web service', () async {
    WebServiceConnection webServiceConnection = WebServiceConnection();
    webServiceConnection.setAttempts = 3;
    webServiceConnection.setTimeout = 5000;
    webServiceConnection.setAttemptsTimeout = 5000;
    webServiceConnection.setAppName = 'Java Test WS Client';
    webServiceConnection.setUrl =
        'https://test.idempiere.org/ADInterface/services/ModelADService';

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
    expect(
        (await webServiceConnection.sendStringRequest(dataRequest)).toString(),
        dataResponse);
  });
}
