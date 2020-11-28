// Copyright (c) 2020 Mohamed Dernoun <med.dernoun@gmail.com>.
//
// This file is part of idempierews_dart.
//
// idempierews_dart is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// idempierews_dart is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with idempierews_dart.  If not, see <http://www.gnu.org/licenses/>.
//

import 'dart:io';
import 'dart:typed_data';

import 'package:hex/hex.dart' show HEX;
import 'package:idempierews_dart/idempierews_dart.dart';

abstract class TestWS {
  LoginRequest _login;
  WebServiceConnection _client;

  TestWS() {
    _login = new LoginRequest();
    _login.setUser = 'superuser @ idempiere.com';
    _login.setPass = 'System';
    _login.setClientID = 11;
    _login.setRoleID = 50004;
    _login.setOrgID = 11;
    _login.setStage = 2;
    _login.setWarehouseID = 103;

    _client = new WebServiceConnection();
    _client.setAttempts = 3;
    _client.setTimeout = 5000;
    _client.setAttemptsTimeout = 5000;
    _client.setUrl = getUrlBase();
    _client.setAppName = 'Java Test WS Client';
    runTest();
  }

  LoginRequest get getLogin => _login;

  String getUrlBase() {
    return 'https://test.idempiere.org';
  }

  WebServiceConnection get getClient => _client;

  void printTotal() {
    print('--------------------------');
    print('Web Service: ${getWebServiceType()}');
    print('Attempts: ${_client.getAttemptsRequest}');
    print('Time: ${_client.getTimeRequest}');
    print('--------------------------');
  }

  void saveRequestResponse() {
    try {
      getClient.writeRequest('../documents/${getWebServiceType()}_request.xml');
      getClient
          .writeResponse('../documents/${getWebServiceType()}_response.xml');
    } catch (e) {
      print(e);
    }
  }

  runTest() async {
    await testPerformed();
    saveRequestResponse();
    printTotal();
    print('');
  }

  String getWebServiceType();

  Future<void> testPerformed();
}

class TestQueryData extends TestWS {
  @override
  String getWebServiceType() => 'QueryBPartner';

  @override
  Future<void> testPerformed() async {
    QueryDataRequest ws = QueryDataRequest();
    ws.setWebServiceType = getWebServiceType();
    ws.setLogin = getLogin;
    ws.setLimit = 2;
    ws.setOffset = 0;

    DataRow data = DataRow();
    data.addField('C_BP_Group_ID', '104');
    ws.setDataRow = data;
    WebServiceConnection client = getClient;

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
}

class TestCreateData extends TestWS {
  @override
  String getWebServiceType() => 'CreateBPartner';

  @override
  Future<void> testPerformed() async {
    CreateDataRequest createData = new CreateDataRequest();
    createData.setLogin = getLogin;
    createData.setWebServiceType = getWebServiceType();

    DataRow data = new DataRow();
    data.addField('C_BP_Group_ID', '104');
    data.addField('Name', 'Test BPartner Dart');
    data.addField(
        'Value', 'Test_BPartner${DateTime.now().millisecondsSinceEpoch}');
    data.addField('TaxID', '123456');
    createData.setDataRow = data;

    WebServiceConnection client = getClient;
    try {
      StandardResponse response = await client.sendRequest(createData);

      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
      } else {
        print('RecordID: ${response.getRecordID}');
        print('');

        for (int i = 0; i < response.getOutputFields.getFieldsCount(); i++) {
          print(
              'Column ${i + 1}: ${response.getOutputFields.getFieldAt(i).getColumn} = ${response.getOutputFields.getFieldAt(i).getValue}');
        }
        print('');
      }
    } catch (e) {
      print(e);
    }
  }
}

class TestDeleteData extends TestWS {
  @override
  String getWebServiceType() => 'DeleteBPartner';

  @override
  Future<void> testPerformed() async {
    DeleteDataRequest deleteData = new DeleteDataRequest();
    deleteData.setLogin = getLogin;
    deleteData.setWebServiceType = getWebServiceType();
    deleteData.setRecordID = 1000000;

    WebServiceConnection client = getClient;
    try {
      StandardResponse response = await client.sendRequest(deleteData);

      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
      } else {
        print('RecordID: ${response.getRecordID}');
        print('');
      }
    } catch (e) {
      print(e);
    }
  }
}

class TestReadData extends TestWS {
  @override
  String getWebServiceType() => 'ReadBPartner';

  @override
  Future<void> testPerformed() async {
    ReadDataRequest ws = new ReadDataRequest();
    ws.setWebServiceType = getWebServiceType();
    ws.setLogin = getLogin;
    ws.setRecordID = 50003;

    WebServiceConnection client = getClient;
    try {
      WindowTabDataResponse response = await client.sendRequest(ws);
      if (response.getStatus == WebServiceResponseStatus.Error)
        print(response.getErrorMessage);
      else if (response.getStatus == WebServiceResponseStatus.Unsuccessful)
        print('Unsuccessful');
      else {
        print('Total rows: ${response.getNumRows}');
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
}

class TestUpdateData extends TestWS {
  @override
  String getWebServiceType() => 'UpdateBPartner';

  @override
  Future<void> testPerformed() async {
    UpdateDataRequest updateData = new UpdateDataRequest();
    updateData.setLogin = getLogin;
    updateData.setWebServiceType = getWebServiceType();
    updateData.setRecordID = 118;

    DataRow data = new DataRow();
    data.addField('URL', 'https://test.idempiere.org');
    updateData.setDataRow = data;

    WebServiceConnection client = getClient;
    try {
      StandardResponse response = await client.sendRequest(updateData);

      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
      } else {
        print('RecordID: ${response.getRecordID}');
        print('');

        for (int i = 0; i < response.getOutputFields.getFieldsCount(); i++) {
          print(
              'Column ${i + 1}: ${response.getOutputFields.getFieldAt(i).getColumn} = ${response.getOutputFields.getFieldAt(i).getValue}');
        }
        print('');
      }
    } catch (e) {
      print(e);
    }
  }
}

class TestCreateUpdateData extends TestWS {
  @override
  String getWebServiceType() => 'CreateUpdateUser';

  @override
  Future<void> testPerformed() async {
    CreateUpdateDataRequest createData = new CreateUpdateDataRequest();
    createData.setLogin = getLogin;
    createData.setWebServiceType = getWebServiceType();

    DataRow data = new DataRow();
    data.addField('Name', 'Joe Block');
    data.addField('Phone', '555-879-89');
    data.addField('C_BPartner_ID', '118');
    data.addField('EMail', 'joeblock@gardenworld.com');
    createData.setDataRow = data;

    WebServiceConnection client = getClient;
    try {
      StandardResponse response = await client.sendRequest(createData);

      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
      } else {
        print('RecordID: ${response.getRecordID}');
        print('');

        for (int i = 0; i < response.getOutputFields.getFieldsCount(); i++) {
          print(
              'Column ${i + 1}: ${response.getOutputFields.getFieldAt(i).getColumn} = ${response.getOutputFields.getFieldAt(i).getValue}');
        }
        print('');
      }
    } catch (e) {
      print(e);
    }
  }
}

class TestGetListData extends TestWS {
  @override
  String getWebServiceType() => 'GetListSalesRegions';

  @override
  Future<void> testPerformed() async {
    GetListRequest getListRequest = new GetListRequest();
    getListRequest.setWebServiceType = getWebServiceType();
    getListRequest.setLogin = getLogin;

    WebServiceConnection client = getClient;

    try {
      WindowTabDataResponse response = await client.sendRequest(getListRequest);
      if (response.getStatus == WebServiceResponseStatus.Error)
        print(response.getErrorMessage);
      else if (response.getStatus == WebServiceResponseStatus.Unsuccessful)
        print('Unsuccessful');
      else {
        print('Total Rows: ${response.getNumRows}');
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
}

class TestRunProcess extends TestWS {
  Future<File> writeToFile(Uint8List data, String path) async {
    try {
      var file = File(path);
      return await file.writeAsBytes(data);
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  String getWebServiceType() => 'RunStorageDetail';

  @override
  Future<void> testPerformed() async {
    RunProcessRequest process = new RunProcessRequest();
    process.setWebServiceType = getWebServiceType();
    process.setLogin = getLogin;

    ParamValues params = new ParamValues();
    params.addField('M_Product_ID', '128');
    process.setParamValues = params;

    WebServiceConnection client = getClient;
    try {
      RunProcessResponse response = await client.sendRequest(process);

      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
      } else {
        print(response.getReportFormat);
        var list = HEX.decode(response.getSummary);
        Uint8List bytes = Uint8List.fromList(list);
        writeToFile(
            bytes, '../../documents/ReadFileTest.${response.getReportFormat}');
      }
    } catch (e) {}
  }
}

class TestDocAction extends TestWS {
  @override
  String getWebServiceType() => 'ActionCompleteOrder';

  @override
  Future<void> testPerformed() async {
    SetDocActionRequest action = new SetDocActionRequest();
    action.setDocAction = DocAction.Complete;
    action.setLogin = getLogin;
    action.setRecordID = 1000000; // Change the recordId
    action.setWebServiceType = getWebServiceType();

    WebServiceConnection client = getClient;

    try {
      StandardResponse response = await client.sendRequest(action);

      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
      } else {
        print('RecordID: ${response.getRecordID}');
      }
    } catch (e) {
      print(e);
    }
  }
}

class TestComposite extends TestWS {
  @override
  String getWebServiceType() => 'SyncOrder';

  @override
  Future<void> testPerformed() async {
    // Define the composite
    CompositeOperationRequest compositeOperation = CompositeOperationRequest();
    compositeOperation.setLogin = getLogin;
    compositeOperation.setWebServiceType = getWebServiceType();

    // Create BPartner
    CreateDataRequest createBPartner = new CreateDataRequest();
    createBPartner.setWebServiceType = 'CreateBPartner';

    DataRow dataPartner = new DataRow();
    dataPartner.addField('C_BP_Group_ID', '104');
    dataPartner.addField('Name', 'iTBridge');
    dataPartner.addField(
        'Value', 'iTBridge${DateTime.now().millisecondsSinceEpoch}');
    dataPartner.addField('TaxID', '123456');
    createBPartner.setDataRow = dataPartner;

    // Create User for BP
    CreateUpdateDataRequest createUser = new CreateUpdateDataRequest();
    createUser.setLogin = getLogin;
    createUser.setWebServiceType = 'CreateUpdateUser';
    DataRow dataUser = new DataRow();
    dataUser.addField('Name', 'iTBridge');
    dataUser.addField('Phone', '555-879-89');
    dataUser.addField('EMail', 'joeblock@gardenworld.com');
    dataUser.addField('C_BPartner_ID', '@C_BPartner.C_BPartner_ID');
    createUser.setDataRow = dataUser;

    // Create Location for user
    CreateDataRequest createLocation = new CreateDataRequest();
    createLocation.setWebServiceType = 'CreateUpdateLocation1';

    DataRow dataLocation = new DataRow();
    dataLocation.addField('Address1', '36 lot kadri Brahim iTBridge');
    dataLocation.addField('C_Country_ID', '112');
    dataLocation.addField('City', 'Constantine');
    dataLocation.addField('Postal', '25004');
    createLocation.setDataRow = dataLocation;

    // Create BPartner Location from the location
    CreateDataRequest createBPLocation = new CreateDataRequest();
    createBPLocation.setWebServiceType = 'CreateUpdateBPLocation';

    DataRow dataBPLocation = new DataRow();
    dataBPLocation.addField('IsShipTo', 'Y');
    dataBPLocation.addField('IsBillTo', 'Y');
    dataBPLocation.addField('C_BPartner_ID', '@C_BPartner.C_BPartner_ID');
    dataBPLocation.addField('C_Location_ID', '@C_Location.C_Location_ID');
    createBPLocation.setDataRow = dataBPLocation;

    // Create Sales Order Header
    CreateDataRequest createOrder = new CreateDataRequest();
    createOrder.setWebServiceType = 'createOrderRecord';
    DataRow dataOrder = new DataRow();
    dataOrder.addField('C_DocTypeTarget_ID', '135');
    dataOrder.addField('C_BPartner_ID', '@C_BPartner.C_BPartner_ID');
    dataOrder.addField('C_BPartner_Location_ID',
        '@C_BPartner_Location.C_BPartner_Location_ID');
    dataOrder.addField('Bill_BPartner_ID', '@C_BPartner.C_BPartner_ID');
    dataOrder.addField(
        'Bill_Location_ID', '@C_BPartner_Location.C_BPartner_Location_ID');
    dataOrder.addField('AD_User_ID', '@AD_User.AD_User_ID');
    dataOrder.addField('M_Warehouse_ID', '103');
    createOrder.setDataRow = dataOrder;

    // Create Sales Order Line
    CreateDataRequest createOrderLine = new CreateDataRequest();
    createOrderLine.setWebServiceType = 'CreateOrderLine';
    DataRow dataLine = new DataRow();
    dataLine.addField('C_Order_ID', '@C_Order.C_Order_ID');
    dataLine.addField('M_Product_ID', '128');
    dataLine.addField('QtyEntered', '10');
    dataLine.addField('QtyOrdered', '10');
    createOrderLine.setDataRow = dataLine;

    // Complete the order
    SetDocActionRequest docAction = new SetDocActionRequest();
    docAction.setDocAction = DocAction.Complete;
    docAction.setWebServiceType = 'CompleteOrder';
    docAction.setRecordIDVariable = '@C_Order.C_Order_ID';

    compositeOperation.addOperationInit(createBPartner, false, true);
    compositeOperation.addOperationInnerWS(createUser);
    compositeOperation.addOperationInnerWS(createLocation);
    compositeOperation.addOperationInnerWS(createBPLocation);
    compositeOperation.addOperationInnerWS(createOrder);
    compositeOperation.addOperationInnerWS(createOrderLine);
    compositeOperation.addOperationInnerWS(docAction);

    WebServiceConnection client = getClient;

    try {
      CompositeResponse response = await client.sendRequest(compositeOperation);
      if (response.getStatus == WebServiceResponseStatus.Error)
        print(response.getErrorMessage);
      else {
        for (int i = 0; i < response.getResponsesCount(); i++) {
          if (response.getResponse(i).getStatus ==
              WebServiceResponseStatus.Error) {
            print(response.getResponse(i).getErrorMessage);
          } else {
            print(
                'Response: ${response.getResponse(i).getWebServiceResponseModel().toString().split('.').last}');
            print('Request:  ${response.getResponse(i).getWebServiceType}');
          }
          print('');
        }
      }
    } catch (e) {}
  }
}

class TestCreateImage extends TestWS {
  // from StackOverFlow
  Future<Uint8List> _readFileByte(String filePath) async {
    File imageFile = new File(filePath);
    Uint8List bytes;
    await imageFile.readAsBytes().then((value) {
      bytes = Uint8List.fromList(value);
      print('reading of bytes is completed');
    }).catchError((onError) {
      print('Exception Error while reading image from path:' +
          onError.toString());
    });
    return bytes;
  }

  @override
  String getWebServiceType() => 'CreateImageTest';

  @override
  Future<void> testPerformed() async {
    CreateDataRequest createImage = CreateDataRequest();
    createImage.setWebServiceType = 'CreateImageTest';
    createImage.setLogin = getLogin;
    String imageName = '../../documents/ImageTest.png';

    DataRow data = new DataRow();
    data.addField('Name', imageName.split('/').last);
    data.addField('Description', 'Test Create image');
    var file = await _readFileByte(imageName);

    data.addField("BinaryData", file);

    createImage.setDataRow = data;

    WebServiceConnection client = getClient;
    try {
      StandardResponse response = await client.sendRequest(createImage);

      if (response.getStatus == WebServiceResponseStatus.Error) {
        print(response.getErrorMessage);
      } else {
        print('RecordID: ${response.getRecordID}');
        print('');

        for (int i = 0; i < response.getOutputFields.getFieldsCount(); i++) {
          print(
              'Column ${i + 1}: ${response.getOutputFields.getFieldAt(i).getColumn} = ${response.getOutputFields.getFieldAt(i).getValue}');
        }
        print('');
      }
    } catch (e) {
      print(e);
    }
  }
}

class TestReadImage extends TestWS {
  Future<void> writeToFile(Uint8List data, String path) async {
    try {
      var file = File(path);
      await file.writeAsBytes(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  String getWebServiceType() => 'ReadImageTest';

  @override
  Future<void> testPerformed() async {
    ReadDataRequest ws = new ReadDataRequest();
    ws.setWebServiceType = getWebServiceType();
    ws.setLogin = getLogin;
    ws.setRecordID = 1000000;

    WebServiceConnection client = getClient;

    try {
      WindowTabDataResponse response = await client.sendRequest(ws);
      if (response.getStatus == WebServiceResponseStatus.Error)
        print(response.getErrorMessage);
      else if (response.getStatus == WebServiceResponseStatus.Unsuccessful)
        print('Unsuccessful');
      else {
        print('Total rows: ${response.getNumRows}');
        print('');
        for (int i = 0; i < response.getDataSet.getRowsCount(); i++) {
          print('Row: ${i + 1}');
          for (int j = 0;
              j < response.getDataSet.getRow(i).getFieldsCount();
              j++) {
            Field field = response.getDataSet.getRow(i).getFields.elementAt(j);
            print('Column: ${field.getColumn} = ${field.getValue}');
            if (field.getColumn == 'BinaryData' && field.getColumn.isNotEmpty)
              await writeToFile(
                  field.getByteValue(), "../../documents/ReadImageTest.png");
          }
          print('');
        }
      }
    } catch (e) {}
  }
}

class TestQueryImage extends TestWS {
  Future<void> writeToFile(Uint8List data, String path) async {
    try {
      var file = File(path);
      await file.writeAsBytes(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  String getWebServiceType() => 'QueryImageTest';

  @override
  Future<void> testPerformed() async {
    QueryDataRequest ws = new QueryDataRequest();
    ws.setWebServiceType = getWebServiceType();
    ws.setLogin = getLogin;
    ws.setLimit = 3;
    ws.setOffset = 3;

    WebServiceConnection client = getClient;

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
            print(response.getDataSet
                .getRow(i)
                .getField('AD_Image_ID')
                .getValue
                .toString());
            print(response.getDataSet
                .getRow(i)
                .getField('AD_Image_ID')
                .getValue
                .toString());
            if (field.getColumn == 'BinaryData' && field.getColumn.isNotEmpty)
              await writeToFile(field.getByteValue(),
                  "../../documents/QueryImageTest_${response.getDataSet.getRow(i).getField('AD_Image_ID').getValue.toString()}");
          }
          print('');
        }
      }
    } catch (e) {}
  }
}

main(List<String> args) async {
  print('Uncomment the function that you want to test on main.dart');

  TestQueryData();

  // TestCreateData();

  // TestDeleteData();

  // TestReadData();

  // TestUpdateData();

  // TestCreateUpdateData();

  // TestGetListData();

  // TestRunProcess();

  // TestDocAction();

  // TestComposite();

  // to test this web service you have to pack in https://github.com/dernoun/idempiere-utils/blob/master/Image%20WS%202Pack.zip

  // TestCreateImage();

  // TestReadImage();

  // TestQueryImage();
}
