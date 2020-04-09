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

import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'enums.dart';

class LoginRequest {
  String user;
  String pass;
  Language lang;
  int clientID;
  int roleID;
  int orgID;
  int warehouseID;
  int stage;

  String get getUser => user;

  set setUser(String user) => this.user = user;

  String get getPass => pass;

  set setPass(String pass) => this.pass = pass;

  Language get getLang => lang;

  set setLang(Language lang) => this.lang = lang;

  int get getClientID => clientID;

  set setClientID(int clientID) => this.clientID = clientID;

  int get getRoleID => roleID;

  set setRoleID(int roleID) => this.roleID = roleID;

  int get getOrgID => orgID;

  set setOrgID(int orgID) => this.orgID = orgID;

  int get getWarehouseID => warehouseID;

  set setWarehouseID(int warehouseID) => this.warehouseID = warehouseID;

  int get getStage => stage;

  set setStage(int stage) => this.stage = stage;
}

class Field {
  dynamic _value;
  String _column;
  String _type;
  String _lval;
  bool _disp;
  bool _edit;
  bool _error;
  String _errorVal;

  dynamic get getValue => _value;

  set setValue(dynamic value) => this._value = value;

  String get getColumn => _column;

  set setColumn(String column) => this._column = column;

  String get getType => _type;

  set setType(String type) => this._type = type;

  String get getLval => _lval;

  set setLval(String lval) => this._lval = lval;

  bool get getDisp => _disp;

  set setDisp(bool disp) => this._disp = disp;

  bool get getEdit => _edit;

  set setEdit(bool edit) => this._edit = edit;

  bool get getError => _error;

  set setError(bool error) => this._error = error;

  String get getErrorVal => _errorVal;

  set setErrorVal(String errorVal) => this._errorVal = errorVal;

  Field();

  /// Constructor column
  /// @param column

  Field.fromColumn(this._column);

  /// Constructor column and value
  ///
  /// @param value
  /// @param column

  Field.fromColumnValue(this._column, this._value);

  String getStringValue() {
    return getValue == null ? null : getValue.toString();
  }

  int getIntValue() {
    if (getValue == null) return null;

    if (getValue is String) return int.parse(getValue.toString());

    return int.parse(getValue);
  }

  double getDoubleValue() {
    if (getValue == null) return null;

    if (getValue is String) return double.parse(getValue.toString());

    return double.parse(getValue);
  }

  bool getboolValue() {
    if (getValue == null) return null;

    if (getValue is String) {
      String value = getValue.toString().toUpperCase();

      if (value == 'Y' || value == 'YES') return true;

      if (value == 'N' || value == 'NO') return false;
    }
    return null;
  }

  Uint8List getByteValue() {
    if (getValue == null) return null;

    if (getValue is String) {
      Uint8List uint8list = base64.decode(getValue.toString());
      return uint8list;
    }
    return getValue;
  }

  DateTime getDateValue() {
    if (getValue == null) return null;
    if (getValue is String) return DateTime.parse(getValue);
    return DateTime.now();
  }

  DocStatus getDocStatusValue() {
    if (getValue == null) return null;

    if (getValue is String) {
      List<DocStatus> values = DocStatus.values;

      for (DocStatus docStatus in values) {
        if (getValue == docStatus.value) return docStatus;
      }
    }
    // return getValue;
    return getValue.cast();
  }

  DocAction getDocActionValue() {
    if (getValue == null) return null;

    if (getValue is String) {
      List<DocAction> values = DocAction.values;

      for (DocAction docAction in values) {
        if (getValue == docAction.value) return docAction;
      }
    }
    // return getValue;
    return getValue.cast();
  }
}

abstract class WebServiceRequest {
  LoginRequest _login;
  String _webServiceType;

  WebServiceRequest() {
    this._login = new LoginRequest();
  }

  LoginRequest get getLogin => _login;

  set setLogin(LoginRequest login) => this._login = login;

  /// Gets the Web Service Type Name. Table: WS_WebServiceType
  ///
  /// @return The Web Service Type Name

  String get getWebServiceType => _webServiceType;

  /// Sets the Web Service Type Name. Table: WS_WebServiceType
  ///
  /// @param webServiceType
  ///            The Web Service Type Name to set

  set setWebServiceType(String webServiceType) =>
      this._webServiceType = webServiceType;

  /// Web Service Method
  ///
  /// @return Web Service Method

  WebServiceMethod getWebServiceMethod();

  /// Web Service Definition
  ///
  /// @return Web Service Definition

  WebServiceDefinition getWebServiceDefinition();

  /// Web Service Request Type
  ///
  /// @return Web Service Request Type

  WebServiceRequestModel getWebServiceRequestModel();

  /// Web Service Response Type
  ///
  /// @return Web Service Response Type

  WebServiceResponseModel getWebServiceResponseModel();
}

abstract class WebServiceResponse {
  WebServiceResponseStatus _status;
  String _errorMessage;
  String _webServiceType;

  /// Gets the web service response type
  ///
  /// @return WebServiceResponseModel

  WebServiceResponseModel getWebServiceResponseModel();

  WebServiceResponseStatus get getStatus => _status;

  set setStatus(WebServiceResponseStatus status) => this._status = status;

  String get getErrorMessage => _errorMessage;

  set setErrorMessage(String errorMessage) => this._errorMessage = errorMessage;

  String get getWebServiceType => _webServiceType;

  set setWebServiceType(String webServiceType) =>
      this._webServiceType = webServiceType;
}

class ComponentInfo {
  static final String name = 'iDempiere Web Service Client';
  static final String componentName = 'idempierewsc';
  static final String version = '1.6.0';

  /// Get Component info
  ///
  /// @return Map info

  static Map<String, String> toMap() {
    Map<String, String> info = new HashMap<String, String>();
    info.putIfAbsent('NAME', () => name);
    info.putIfAbsent('COMPONENT_NAME', () => componentName);
    info.putIfAbsent('VERSION', () => version);
    return info;
  }
}

abstract class ModelGetListRequest extends WebServiceRequest {
  int _adReferenceID;
  String _filter;

  int get getAdReferenceID => _adReferenceID;

  set setAdReferenceID(int adReferenceID) =>
      this._adReferenceID = adReferenceID;

  String get getFilter => _filter;

  set setFilter(String filter) => this._filter = filter;

  @override
  WebServiceRequestModel getWebServiceRequestModel() {
    return WebServiceRequestModel.ModelGetListRequest;
  }
}

abstract class ModelSetDocActionRequest extends WebServiceRequest {
  String tableName;
  int recordID;
  String recordIDVariable;
  DocAction docAction;

  String get getTableName => tableName;

  set setTableName(String tableName) => this.tableName = tableName;

  int get getRecordID => recordID;

  set setRecordID(int recordID) => this.recordID = recordID;

  String get getRecordIDVariable => recordIDVariable;

  set setRecordIDVariable(String recordIDVariable) =>
      this.recordIDVariable = recordIDVariable;

  DocAction get getDocAction => docAction;

  set setDocAction(DocAction docAction) => this.docAction = docAction;

  @override
  WebServiceRequestModel getWebServiceRequestModel() {
    return WebServiceRequestModel.ModelSetDocActionRequest;
  }
}

//  WebServiceFieldsContainer For field collections

abstract class FieldsContainer {
  List<Field> _fields;

  FieldsContainer() {
    _fields = List<Field>();
  }

  List<Field> get getFields {
    List<Field> temp = new List<Field>();
    temp.addAll(_fields);
    return temp;
  }

  /// Removes the field
  ///
  /// @param pos
  ///            Position
  /// @return The field

  void removeField(Field field) {
    _fields.remove(field);
  }

  /// Removes the field
  ///
  /// @param columnName
  ///            Column name
  /// @return The field

  Field removeFieldAt(int pos) {
    return _fields.removeAt(pos);
  }

  Field removeFieldFromColumn(String columnName) {
    Field returnField = getField(columnName);
    _fields.remove(returnField);
    return returnField;
  }

  /// Removes the field
  ///
  /// @param columnName
  ///            Column name
  /// @return The field

  void addField(String columnName, Object value) {
    addFieldfromField(new Field.fromColumnValue(columnName, value));
  }

  /// Add a new field
  ///
  /// @param field
  ///            New Field

  void addFieldfromField(Field field) {
    Field findField = getField(field.getColumn);
    if (findField != null) _fields.remove(findField);
    _fields.add(field);
  }

  /// Find a field from colum name value
  ///
  /// @param columnName
  ///            Key for column name
  /// @return Field

  Field getField(String columnName) {
    for (int i = 0; i < _fields.length; i++) {
      if (_fields.elementAt(i).getColumn == columnName) {
        return _fields.elementAt(i);
      }
    }
    return null;
  }

  Field getFieldAt(int pos) {
    return _fields.elementAt(pos);
  }

  /// Get the count fields
  ///
  /// @return Count

  int getFieldsCount() {
    return _fields.length;
  }

  /// Clear this instance

  void clear() {
    _fields.clear();
  }

  /// Get the node root name
  ///
  /// @return Fields Container Type

  FieldsContainerType getWebServiceFieldsContainerType();
}

/// DataRow Contains the web service fields

class DataRow extends FieldsContainer {
  ///
  ///
  /// @see org.idempiere.webservice.client.base.WebServiceFieldsContainer#getWebServiceFieldsContainerType()

  @override
  FieldsContainerType getWebServiceFieldsContainerType() {
    return FieldsContainerType.DataRow;
  }
}

/// ParamValues Contains the web service fields for run process

class ParamValues extends FieldsContainer {
  ///
  ///
  /// @see org.idempiere.webservice.client.base.WebServiceFieldsContainer#getWebServiceFieldsContainerType()

  @override
  FieldsContainerType getWebServiceFieldsContainerType() {
    return FieldsContainerType.ParamValues;
  }
}

/// DataSet, DataRow Container
class DataSet {
  List<DataRow> _rows;

  // Default constructor
  DataSet() {
    _rows = new List<DataRow>();
  }
  // Get all rows
  List<DataRow> getRows() {
    List<DataRow> temp = new List<DataRow>();
    temp.addAll(_rows);
    return temp;
  }

  // Add a new row
  void addRow(DataRow row) {
    _rows.add(row);
  }

  // Remove a row
  void removeRow(DataRow row) {
    _rows.remove(row);
  }

  // Removes the row
  DataRow removeRowAt(int pos) {
    DataRow row = _rows.elementAt(pos);
    removeRow(row);
    return row;
  }

  // Gets the row
  DataRow getRow(int pos) {
    return _rows.elementAt(pos);
  }

  // Get the count Rows
  int getRowsCount() {
    return _rows.length;
  }

  // Clear this instance
  void clear() {
    _rows.clear();
  }
}

/// Operation For composite operation
class Operation {
  WebServiceRequest _webService;
  bool _preCommit;
  bool _postCommit;

  // Default constructor
  Operation([this._preCommit = false, this._postCommit = false]);
  // Web service operation
  Operation.innerWS(this._webService,
      [this._preCommit = false, this._postCommit = false]);

  Operation.init(
      WebServiceRequest webService, this._preCommit, this._postCommit) {
    setWebService(webService);
  }
  // Gets the webService
  WebServiceRequest getWebService() => _webService;

  void setWebService(WebServiceRequest webService) {
    if (webService != null) if (webService.getWebServiceMethod() ==
            WebServiceMethod.getList ||
        webService.getWebServiceMethod() == WebServiceMethod.queryData ||
        webService.getWebServiceMethod() == WebServiceMethod.compositeOperation)
      throw Exception(
          'WebService ${webService.getWebServiceMethod()} not allowed for Composite Operation');

    this._webService = webService;
  }

// If preCommit is true, whatever done before current operation will be committed to the database
  set setPreCommit(bool value) => _preCommit = value;
  bool get isPreCommit => _preCommit;

  // When postCommit is true, commit is performed after current operation is executed successfully
  bool get isPostCommit => _postCommit;
  set setPostCommit(bool value) => _postCommit = value;

  // set setPostCommit(bool postCommit) {
  // this._postCommit = postCommit;
  // }
}

abstract class CompositeRequest extends WebServiceRequest {
  List<Operation> _operations;
  CompositeRequest() {
    _operations = List<Operation>();
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceRequestModel()
  @override
  WebServiceRequestModel getWebServiceRequestModel() {
    return WebServiceRequestModel.CompositeRequest;
  }

  // Add a new Web Service
  void addOperation(Operation operation) {
    _operations.add(operation);
  }

  // Adds the operation
  void addOperationInnerWS(WebServiceRequest webService) {
    addOperation(new Operation.innerWS(webService));
  }

  // Adds the operation with preCommit postCommit
  void addOperationInit(
      WebServiceRequest webService, bool preCommit, bool postCommit) {
    addOperation(new Operation.init(webService, preCommit, postCommit));
  }

  // Remove a Web Service
  void removeOperation(Operation operation) {
    _operations.remove(operation);
  }

  // Removes a Web Service
  Operation removeOperationAt(int pos) {
    Operation operation = _operations.elementAt(pos);
    removeOperation(operation);
    return operation;
  }

  // Get all field
  List<Operation> getOperations() {
    List<Operation> temp = List<Operation>();
    temp.addAll(_operations);
    return temp;
  }

  // Gets the operation
  Operation getOperation(int pos) {
    return _operations.elementAt(pos);
  }

  // Get the count Operations
  int getOperationsCount() {
    return _operations.length;
  }

  // Clear this instance
  void clear() {
    _operations.clear();
  }
}

abstract class ModelRunProcessRequest extends WebServiceRequest {
  ParamValues _paramValues;
  DocAction _docAction;
  int _recordID;
  int _menuID;
  int _processID;

  // Default constructor
  ModelRunProcessRequest() {
    _paramValues = new ParamValues();
  }

  ParamValues get getParamValues => _paramValues;

  set setParamValues(ParamValues paramValues) => _paramValues = paramValues;

  DocAction get getDocAction => _docAction;

  set setDocAction(DocAction docAction) => _docAction = docAction;

  int get getRecordID => _recordID;

  set setRecordID(int recordID) => _recordID = recordID;

  int get getMenuID => _menuID;

  set setMenuID(int menuID) => _menuID = menuID;

  int get getProcessID => _processID;

  set setProcessID(int processID) => _processID = processID;

  // see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceRequestModel()
  @override
  WebServiceRequestModel getWebServiceRequestModel() {
    return WebServiceRequestModel.ModelRunProcessRequest;
  }
}

abstract class ModelCRUDRequest extends WebServiceRequest {
  DataRow _dataRow;
  int _offset;
  int _limit;
  String _filter;
  ModelCRUDAction _action;
  int _recordID;
  String _recordIDVariable;
  String _tableName;

  // Default constructor
  ModelCRUDRequest() {
    _dataRow = new DataRow();
  }

  DataRow get getDataRow => _dataRow;

  set setDataRow(DataRow dataRow) => _dataRow = dataRow;

  int get getOffset => _offset;

  set setOffset(int offset) => _offset = offset;

  int get getLimit => _limit;

  /// limit allow you to limit the response on the value that you set
  set setLimit(int limit) => _limit = limit;

  String get getFilter => _filter;

  set setFilter(String filter) => _filter = filter;

  ModelCRUDAction get getAction => _action;

  set setAction(ModelCRUDAction value) => _action = value;

  int get getRecordID => _recordID;

  set setRecordID(int recordID) => _recordID = recordID;

  String get getRecordIDVariable => _recordIDVariable;

  set setRecordIDVariable(String recordIDVariable) =>
      _recordIDVariable = recordIDVariable;

  String get getTableName => _tableName;

  set setTableName(String tableName) => _tableName = tableName;

  @override
  WebServiceRequestModel getWebServiceRequestModel() {
    return WebServiceRequestModel.ModelCRUDRequest;
  }
}
