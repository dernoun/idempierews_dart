import 'package:idempierews_dart/src/base.dart';
import 'package:idempierews_dart/src/enums.dart';
import 'package:idempierews_dart/src/net.dart';
import 'package:idempierews_dart/src/request.dart';
import 'package:test/test.dart';

void main() {
  // XmlDocument xmlDocument = XmlDocument.parse(dataResponse);
  test('Test the return of the web service', () async {
    WebServiceConnection webServiceConnection = WebServiceConnection();
    webServiceConnection.setAttempts = 3;
    webServiceConnection.setTimeout = 5000;
    webServiceConnection.setAttemptsTimeout = 5000;
    webServiceConnection.setAppName = 'Java Test WS Client';
    webServiceConnection.setUrl =
        'https://demo.globalqss.com/ADInterface/services/ModelADService';

    LoginRequest _login = new LoginRequest();
    _login.setUser = 'SuperUser';
    _login.setPass = 'System';
    _login.setClientID = 11;
    _login.setRoleID = 50004;
    _login.setOrgID = 11;
    _login.setStage = 9;
    _login.setLang = Language.en_US;
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
    WebServiceResponse webServiceResponse =
        await webServiceConnection.sendRequest(createData);
    expect(webServiceResponse.getStatus, WebServiceResponseStatus.Successful);
  });
}
