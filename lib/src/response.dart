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

import 'enums.dart';

import 'base.dart';
import 'package:xml/xml.dart';

/// CompositeResponse. Response from CompositeInterface Web Service
class CompositeResponse extends WebServiceResponse {
  List<WebServiceResponse> _responses;

  // @see org.idempiere.webservice.client.base.WebServiceResponse#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() =>
      WebServiceResponseModel.CompositeResponse;

  // Default constructor
  CompositeResponse() {
    _responses = List<WebServiceResponse>.empty(growable: true);
  }

  // Gets the responses
  List<WebServiceResponse> getResponses() {
    List<WebServiceResponse> temp =
        List<WebServiceResponse>.empty(growable: true);
    temp.addAll(_responses);
    return temp;
  }

  // Removes the response
  void removeResponse(WebServiceResponse response) {
    _responses.remove(response);
  }

  WebServiceResponse removeResponseAt(int pos) {
    WebServiceResponse returnResponse = getResponse(pos);
    _responses.remove(returnResponse);
    return returnResponse;
  }

  // Adds the response
  void addResponse(WebServiceResponse response) {
    _responses.add(response);
  }

  // Gets the responses count
  int getResponsesCount() {
    return _responses.length;
  }

  WebServiceResponse getResponse(int pos) {
    return _responses.elementAt(pos);
  }

  // Clear this instance
  void clear() {
    _responses.clear();
  }
}

/// RunProcessResponse. Response from RunProcess Web Service
class RunProcessResponse extends WebServiceResponse {
  String _logInfo;
  String _summary;
  String _reportFormat;

  String get getLogInfo => _logInfo;

  set setLogInfo(String logInfo) => _logInfo = logInfo;

  String get getSummary => _summary;

  set setSummary(String summary) => _summary = summary;

  String get getReportFormat => _reportFormat;

  set setReportFormat(String reportFormat) => _reportFormat = reportFormat;

  @override
  WebServiceResponseModel getWebServiceResponseModel() =>
      WebServiceResponseModel.RunProcessResponse;
}

/// StandardResponse. Response from SetDocAction, CreateData, DeleteData, UpdateData Web Services
class StandardResponse extends WebServiceResponse {
  int _recordID;
  DataRow _outputFields;

  // Response from SetDocAction, CreateData, DeleteData, UpdateData Web Services
  StandardResponse() {
    _outputFields = new DataRow();
  }

  DataRow get getOutputFields => _outputFields;

  set setOutputFields(DataRow outputFields) =>
      this._outputFields = outputFields;

  int get getRecordID => _recordID;

  set setRecordID(int recordID) => this._recordID = recordID;

  @override
  WebServiceResponseModel getWebServiceResponseModel() =>
      WebServiceResponseModel.StandardResponse;
}

/// WindowTabDataResponse. Response from QueryData, GetList, ReadData Web Services
class WindowTabDataResponse extends WebServiceResponse {
  int _numRows;
  int _totalRows;
  int _startRow;
  DataSet _dataSet;

  // Response from QueryData, GetList, ReadData Web Services
  WindowTabDataResponse() {
    _dataSet = new DataSet();
  }

  int get getNumRows => _numRows;

  set setNumRows(int numRows) => this._numRows = numRows;

  int get getTotalRows => _totalRows;

  set setTotalRows(int totalRows) => this._totalRows = totalRows;

  int get getStartRow => _startRow;

  set setStartRow(int startRow) => this._startRow = startRow;

  DataSet get getDataSet => _dataSet;

  set setDataSet(DataSet dataSet) => this._dataSet = dataSet;

  @override
  WebServiceResponseModel getWebServiceResponseModel() =>
      WebServiceResponseModel.WindowTabDataResponse;
}

class ResponseFactory {
  /// Build a response model from xml response
  static WebServiceResponse createResponse(
      WebServiceResponseModel responseModel, XmlDocument response) {
    if (responseModel == WebServiceResponseModel.CompositeResponse)
      return createCompositeResponse(response);
    else if (responseModel == WebServiceResponseModel.RunProcessResponse)
      return createRunProcessResponse(response);
    else if (responseModel == WebServiceResponseModel.StandardResponse)
      return createStandardResponse(response);
    else if (responseModel == WebServiceResponseModel.WindowTabDataResponse)
      return createWindowTabDataResponse(response);
    return null;
  }

  static bool hasFaultError(
      WebServiceResponse responseModel, XmlDocument response) {
    var xmlFault = response.findAllElements('faultstring');
    if (xmlFault.length > 0) {
      responseModel.setStatus = WebServiceResponseStatus.Error;
      responseModel.setErrorMessage = xmlFault.elementAt(0).text;
      return true;
    }
    xmlFault = response.findAllElements('Error');
    if (xmlFault.length > 0) {
      responseModel.setStatus = WebServiceResponseStatus.Error;
      responseModel.setErrorMessage = xmlFault.elementAt(0).text;
      return true;
    }
    return false;
  }

  // Create a composite response model
  static WebServiceResponse createCompositeResponse(XmlDocument response) {
    try {
      CompositeResponse responseModel = new CompositeResponse();
      if (hasFaultError(responseModel, response)) {
        return responseModel;
      }
      responseModel.setStatus = WebServiceResponseStatus.Successful;

      var xmlResponses = response.findAllElements('StandardResponse');
      for (int i = 0; i < xmlResponses.length; i++) {
        XmlElement xmlTemp = xmlResponses.elementAt(i);
        xmlTemp.detachParent(null);
        WebServiceResponse partialResponse;
        if (xmlTemp.findElements('WindowTabData').length > 0) {
          XmlDocument xmlDocTemp = XmlDocument();
          XmlElement xmlEleTemp =
              xmlTemp.findAllElements('WindowTabData').elementAt(0);
          xmlEleTemp.detachParent(null);
          xmlDocTemp.children.add(xmlEleTemp);
          partialResponse = createWindowTabDataResponse(xmlDocTemp);
          responseModel.addResponse(partialResponse);
        } else if (xmlTemp.findElements('RunProcessResponse').length > 0) {
          XmlDocument xmlDocTemp = XmlDocument();
          XmlElement xmlEleTemp =
              xmlTemp.findAllElements('RunProcessResponse').elementAt(0);
          xmlEleTemp.detachParent(null);
          xmlDocTemp.children.add(xmlEleTemp);
          partialResponse = createRunProcessResponse(xmlDocTemp);
          responseModel.addResponse(partialResponse);
        } else {
          XmlDocument xmlDocTemp = XmlDocument();
          xmlDocTemp.children.add(xmlTemp);
          partialResponse = createStandardResponse(xmlDocTemp);
          responseModel.addResponse(partialResponse);
        }
        if (partialResponse != null &&
            partialResponse.getStatus == WebServiceResponseStatus.Error) {
          responseModel.setStatus = WebServiceResponseStatus.Error;
          responseModel.setErrorMessage = partialResponse.getErrorMessage;
        }
      }
      return responseModel;
    } catch (e) {
      throw Exception('Error building CompositeResponse : $e');
    }
  }

  // Create a run process response model
  static WebServiceResponse createRunProcessResponse(XmlDocument response) {
    try {
      RunProcessResponse responseModel = RunProcessResponse();
      if (hasFaultError(responseModel, response)) {
        return responseModel;
      }

      var xmlProcess = response.findAllElements('RunProcessResponse');
      bool isReport = false;

      if (xmlProcess.length > 0) {
        if (xmlProcess.elementAt(0) != null &&
            xmlProcess.elementAt(0).attributes != null &&
            xmlProcess.elementAt(0).getAttribute('IsReport') != null &&
            xmlProcess.elementAt(0).getAttribute('IsReport') == 'true')
          isReport = true;
        else if (xmlProcess.elementAt(0).getAttribute('IsError') == 'true') {
          responseModel.setStatus = WebServiceResponseStatus.Error;
          var xmlError = response.findAllElements('Error');
          responseModel.setErrorMessage = xmlError.elementAt(0).text;
          return responseModel;
        }

        responseModel.setStatus = WebServiceResponseStatus.Successful;

        if (isReport) {
          var xmlData = response.findAllElements('Data');
          responseModel.setSummary = xmlData.elementAt(0).text;
          String reportFormat =
              xmlProcess.elementAt(0).getAttribute('ReportFormat');
          if (reportFormat.isNotEmpty)
            responseModel.setReportFormat = reportFormat;
        } else {
          var xmlSummary = response.findAllElements('Summary');
          responseModel.setSummary = xmlSummary.elementAt(0).text;

          var xmlLogInfo = response.findAllElements('LogInfo');
          responseModel.setLogInfo = xmlLogInfo.elementAt(0).text;
        }
      }

      return responseModel;
    } catch (e) {
      throw Exception('Error building RunProcessResponse : $e');
    }
  }

  // Create a standard response model
  static WebServiceResponse createStandardResponse(XmlDocument response) {
    try {
      StandardResponse responseModel = StandardResponse();

      if (hasFaultError(responseModel, response)) {
        return responseModel;
      }

      var xmlError = response.findAllElements('Error');

      if (xmlError.length > 0) {
        responseModel.setStatus = WebServiceResponseStatus.Error;
        responseModel.setErrorMessage = xmlError.elementAt(0).text;
        return responseModel;
      }

      responseModel.setStatus = WebServiceResponseStatus.Successful;

      var xmlStandard = response.findAllElements('StandardResponse');
      if (xmlStandard.length > 0) {
        String recordIDString =
            xmlStandard.elementAt(0).getAttribute('RecordID');

        if (recordIDString.isNotEmpty)
          responseModel.setRecordID = int.parse(recordIDString);
      }

      DataRow dataRow = new DataRow();
      responseModel.setOutputFields = dataRow;

      var xmlDataFields = response.findAllElements('outputField');

      for (var j = 0; j < xmlDataFields.length; j++) {
        Field field = new Field();
        dataRow.addFieldfromField(field);

        XmlElement xmlDataField = xmlDataFields.elementAt(j);
        if (xmlDataField.getAttribute('column') != null)
          field.setColumn = xmlDataField.getAttribute('column');
        if (xmlDataField.getAttribute('value') != null)
          field.setValue = xmlDataField.getAttribute('value');
      }

      return responseModel;
    } catch (e) {
      throw Exception('Error building StandardResponse : $e');
    }
  }

  static WebServiceResponse createWindowTabDataResponse(XmlDocument response) {
    try {
      WindowTabDataResponse responseModel = new WindowTabDataResponse();

      if (hasFaultError(responseModel, response)) {
        return responseModel;
      }

      var xmlError = response.findElements('Error');

      if (xmlError.length > 0) {
        responseModel.setStatus = WebServiceResponseStatus.Error;
        responseModel.setErrorMessage = xmlError.elementAt(0).text;
        return responseModel;
      }

      var xmlSuccess = response.findAllElements('Success');
      if (xmlSuccess.length > 0) {
        if (xmlSuccess.elementAt(0).text == 'false') {
          responseModel.setStatus = WebServiceResponseStatus.Unsuccessful;
          return responseModel;
        }
      }

      responseModel.setStatus = WebServiceResponseStatus.Successful;

      var xmlWindowTabData = response.findAllElements('WindowTabData');

      if (xmlWindowTabData.length > 0) {
        String numRows = xmlWindowTabData.elementAt(0).getAttribute('NumRows');
        if (numRows.isNotEmpty) responseModel.setNumRows = int.parse(numRows);

        String totalRows =
            xmlWindowTabData.elementAt(0).getAttribute('TotalRows');
        if (totalRows.isNotEmpty)
          responseModel.setTotalRows = int.parse(totalRows);

        String startRow =
            xmlWindowTabData.elementAt(0).getAttribute('StartRow');
        if (startRow.isNotEmpty)
          responseModel.setStartRow = int.parse(startRow);
      }

      DataSet dataSet = DataSet();

      responseModel.setDataSet = dataSet;

      var xmlDataSet = response.findAllElements('DataRow');

      for (var i = 0; i < xmlDataSet.length; i++) {
        DataRow dataRow = DataRow();
        dataSet.addRow(dataRow);

        XmlElement xmlDataRow = xmlDataSet.elementAt(i);

        var xmlDataFields = xmlDataRow.findAllElements('field');
        for (var j = 0; j < xmlDataFields.length; j++) {
          Field field = Field();
          dataRow.addFieldfromField(field);

          XmlElement xmlDataField = xmlDataFields.elementAt(j);
          field.setColumn = xmlDataField.getAttribute('column');
          if (xmlDataField.findAllElements('val').elementAt(0).text == null)
            field.setValue = '';
          else
            field.setValue =
                xmlDataField.findAllElements('val').elementAt(0).text;
        }
      }

      return responseModel;
    } catch (e) {
      throw Exception('Error building WindowTabData : $e');
    }
  }
}
