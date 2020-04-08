# idempierewsc_dart
# Description
iDempiere Dart WebService Client is a Soap Client for iDempiere ERP [http://www.idempiere.org](http://www.idempiere.org). It allows the programmer to abstract the generation of XML requests, making development easier. This implementation can be used in Dart and Flutter.

You have to add Data on GardenWorld: [Packout.zip](https://github.com/ingeint/idempierewsc-python/blob/master/documents/Test%20WebServices%202Pack.zip). Examples are available in the exemple folder.
# Features

- License: LGPL 3
- Language: Dart
- IDE: VSCode
- Venrion: v0.0.2

# Links
- iDempiere Web Services: [https://wiki.idempiere.org/en/Web_services](https://wiki.idempiere.org/en/Web_services)
# Example Query data
- Source:
```dart
import 'package:idempierews_dart/idempierews.dart';

main(List<String> args) async {
  LoginRequest login;
  WebServiceConnection client;

  login = LoginRequest();
  login.setUser = 'superuser @ idempiere.com';
  login.setPass = 'System';
  login.setClientID = 11;
  login.setRoleID = 102;
  login.setOrgID = 0;
  login.setStage = 2;

  client = WebServiceConnection();
  client.setAttempts = 3;
  client.setTimeout = 5000;
  client.setAttemptsTimeout = 5000;
  client.setUrl = 'https://test.idempiere.org';
  client.setAppName = 'Dart Test WS Client';

  QueryDataRequest ws = new QueryDataRequest();
  ws.setWebServiceType = 'QueryBPartnerTest';
  ws.setLogin = login;
  ws.setLimit = 2;
  ws.setOffset = 3;

  DataRow data = DataRow();
  data.addField('Name', '%Store%');
  ws.setDataRow = data;

  try {
    WindowTabDataResponse response = await client.sendRequest(ws);

    if (response.getStatus == WebServiceResponseStatus.Error)
      print(response.getErrorMessage);
    else {
      print('Total rows: ${response.getTotalRows}');
      print('Num rows: ${response.getNumRows}');
      print('Start row: ${response.getStartRow}');
      print('');
      for (int i = 0; i < response.getDataSet.getRowsCount(); i++) {
        print('Row: ${i + 1}');
        for (int j = 0;
            j < response.getDataSet.getRow(i).getFieldsCount();
            j++) {
          Field field = response.getDataSet.getRow(i).getFields.elementAt(j);
          print('Column: ${field.getColumn} = ${field.getValue}');
        }
        print('');
      }
    }
  } catch (e) {
    print(e);
  }
}
```
- Output:
```XML
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <ns1:queryDataResponse xmlns:ns1="http://idempiere.org/ADInterface/1_0">
      <WindowTabData xmlns="http://idempiere.org/ADInterface/1_0" NumRows="2" TotalRows="5" StartRow="3">
        <DataSet>
          <DataRow>
            <field column="C_BPartner_ID">
              <val>50008</val>
            </field>
            <field column="Value">
              <val>Store South</val>
            </field>
            <field column="Name">
              <val>Store South</val>
            </field>
            <field column="TaxID">
              <val xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"></val>
            </field>
            <field column="Logo_ID">
              <val xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"></val>
            </field>
          </DataRow>
          <DataRow>
            <field column="C_BPartner_ID">
              <val>50009</val>
            </field>
            <field column="Value">
              <val>Store West</val>
            </field>
            <field column="Name">
              <val>Store West</val>
            </field>
            <field column="TaxID">
              <val xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"></val>
            </field>
            <field column="Logo_ID">
              <val xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:nil="true"></val>
            </field>
          </DataRow>
        </DataSet>
        <RowCount>2</RowCount>
        <Success>true</Success>
      </WindowTabData>
    </ns1:queryDataResponse>
  </soap:Body>
</soap:Envelope>

```
