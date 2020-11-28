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

import 'dart:convert';
import 'dart:typed_data';

import 'base.dart';
import 'enums.dart';
import 'package:xml/xml.dart';
import 'package:intl/intl.dart';

/// CompositeOperation. iDempiere Web Service Composite
class CompositeOperationRequest extends CompositeRequest {
  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.compositeOperation;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.compositeInterface;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.CompositeResponse;
  }
}

/// CreateData. iDempiere Web Service CreateData
class CreateDataRequest extends ModelCRUDRequest {
  //  @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.createData;
  }

  // org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.ModelADService;
  }

  // see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.StandardResponse;
  }
}

/// CreateUpdateData. iDempiere Web Service CreateUpdateData
class CreateUpdateDataRequest extends ModelCRUDRequest {
  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.createUpdateData;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.ModelADService;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.StandardResponse;
  }
}

/// DeleteData. iDempiere Web Service DeleteData
class DeleteDataRequest extends ModelCRUDRequest {
  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.deleteData;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.ModelADService;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.StandardResponse;
  }
}

/// GetList. iDempiere Web Service GetList
class GetListRequest extends ModelGetListRequest {
  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.getList;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.ModelADService;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.WindowTabDataResponse;
  }
}

/// QueryData. iDempiere Web Service QueryData
class QueryDataRequest extends ModelCRUDRequest {
  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.queryData;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.ModelADService;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.WindowTabDataResponse;
  }
}

/// ReadData. iDempiere Web Service ReadData
class ReadDataRequest extends ModelCRUDRequest {
  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.readData;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.ModelADService;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.WindowTabDataResponse;
  }
}

/// RunProcess. iDempiere Web Service RunProcess
class RunProcessRequest extends ModelRunProcessRequest {
  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.runProcess;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.ModelADService;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.RunProcessResponse;
  }
}

/// SetDocAction. iDempiere Web Service SetDocAction
class SetDocActionRequest extends ModelSetDocActionRequest {
  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.setDocAction;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.ModelADService;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.StandardResponse;
  }
}

/// UpdateData. iDempiere Web Service UpdateData
class UpdateDataRequest extends ModelCRUDRequest {
  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceMethod()
  @override
  WebServiceMethod getWebServiceMethod() {
    return WebServiceMethod.updateData;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceDefinition()
  @override
  WebServiceDefinition getWebServiceDefinition() {
    return WebServiceDefinition.ModelADService;
  }

  // @see org.idempiere.webservice.client.base.WebServiceRequest#getWebServiceResponseModel()
  @override
  WebServiceResponseModel getWebServiceResponseModel() {
    return WebServiceResponseModel.StandardResponse;
  }
}

class RequestFactory {
  static final String prefix_0 = '_0';
  static final String namespace_0 = 'http://idempiere.org/ADInterface/1_0';
  static final String prefixSoapenv = 'soapenv';
  static final String namespaceSoapenv =
      'http://schemas.xmlsoap.org/soap/envelope/';
  static final String attributeXmlns = 'xmlns';
  static final String namespaceXmlns = 'http://www.w3.org/2000/xmlns/';
  static Map<String, String> nameSpaces = Map();

  static XmlElement createXmlElement_0(String elementName,
      [String prefix = '_0']) {
    return XmlElement(XmlName(elementName, prefix));
  }

  static XmlElement createXmlElementChild_0(String elementName, var children,
      [String prefix = '_0']) {
    return XmlElement(XmlName(elementName, prefix), [], children);
  }

  static XmlDocument createRequest(WebServiceRequest webService) {
    return _buildXmlDocument(webService);
  }

  static XmlDocument _buildXmlDocument(WebServiceRequest webService) {
    try {
      // final document = XmlDocument();
      // document.children.add(buildXmlEnvelope(webService));
      return _buildXmlEnvelope(webService);
    } catch (e) {
      throw Exception('Error building XML request : $e');
    }
  }

  static XmlDocument _buildXmlEnvelope(WebServiceRequest webService) {
    try {
      nameSpaces.putIfAbsent(namespace_0, () => prefix_0);
      nameSpaces.putIfAbsent(namespaceSoapenv, () => prefixSoapenv);
      final builder = XmlBuilder();
      builder.element('Envelope', namespace: RequestFactory.namespaceSoapenv,
          nest: () {
        builder.element('Header', namespace: RequestFactory.namespaceSoapenv);
        builder.element('Body', namespace: RequestFactory.namespaceSoapenv,
            nest: () {
          builder.element(
              webService.getWebServiceMethod().toString().split('.').last,
              namespace: RequestFactory.namespace_0,
              nest: _buildXmlRequest(webService));
        });
      }, namespaces: RequestFactory.nameSpaces);
      var envelope = builder.buildDocument();
      return envelope;
    } catch (e) {
      throw new Exception('Error building XML Envelope request : $e');
    }
  }

  static XmlElement _buildXmlRequest(WebServiceRequest webService) {
    try {
      XmlElement xmlRequest = createXmlElement_0(
          webService.getWebServiceRequestModel().toString().split('.').last);
      if (webService.getWebServiceRequestModel() ==
          WebServiceRequestModel.CompositeRequest) {
        xmlRequest.children.add(createXmlElementChild_0(
            'serviceType', [XmlText(webService.getWebServiceType)]));
      }
      xmlRequest.children.add(_buildXmlModel(webService));

      if (webService.getLogin != null)
        xmlRequest.children.add(_buildXmlLogin(webService.getLogin));

      return xmlRequest;
    } catch (e) {
      throw new Exception('Error building XML body request : $e');
    }
  }

  static XmlElement _buildXmlModel(WebServiceRequest webService) {
    try {
      if (webService.getWebServiceRequestModel() ==
          WebServiceRequestModel.CompositeRequest) {
        CompositeRequest request = webService;

        XmlElement xmlModel = createXmlElement_0('operations');

        for (int i = 0; i < request.getOperations().length; i++) {
          xmlModel.children
              .add(_buildXmlOperation(request.getOperations().elementAt(i)));
        }
        return xmlModel;
      }

      /// ModelCRUDRequest
      else if (webService.getWebServiceRequestModel() ==
          WebServiceRequestModel.ModelCRUDRequest) {
        ModelCRUDRequest request = webService;
        XmlElement xmlModel = createXmlElementChild_0(
          'ModelCRUD',
          [
            XmlElement(
              XmlName('serviceType', RequestFactory.prefix_0),
              [],
              [XmlText(webService.getWebServiceType)],
            )
          ],
        );

        if (request.getTableName != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'TableName',
            [XmlText(request.getTableName)],
          ));
        }

        if (request.getRecordID != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'RecordID',
            [XmlText(request.getRecordID.toString())],
          ));
        }

        if (request.getRecordIDVariable != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'recordIDVariable',
            [XmlText(request.getRecordIDVariable)],
          ));
        }

        if (request.getAction != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'Action',
            [XmlText(request.getAction.toString().split('.').last)],
          ));
        }

        if (request.getFilter != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'Filter',
            [XmlText(request.getFilter)],
          ));
        }

        if (request.getLimit != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'Limit',
            [XmlText(request.getLimit.toString())],
          ));
        }

        if (request.getOffset != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'Offset',
            [XmlText(request.getOffset.toString())],
          ));
        }

        if (request.getDataRow != null &&
            request.getDataRow.getFieldsCount() > 0) {
          xmlModel.children.add(_buildXmlFieldsContainer(request.getDataRow));
        }

        return xmlModel;
      }

      /// ModelGetListRequest
      else if (webService.getWebServiceRequestModel() ==
          WebServiceRequestModel.ModelGetListRequest) {
        ModelGetListRequest request = webService;
        XmlElement xmlModel = createXmlElementChild_0(
          'ModelGetList',
          [
            createXmlElementChild_0(
              'serviceType',
              [XmlText(webService.getWebServiceType)],
            )
          ],
        );
        if (request.getAdReferenceID != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'AD_Reference_ID',
            [XmlText(request.getAdReferenceID.toString())],
          ));
        }

        if (request.getFilter != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'Filter',
            [XmlText(request.getFilter)],
          ));
        }
        return xmlModel;
      }

      /// ModelRunProcessRequest
      else if (webService.getWebServiceRequestModel() ==
          WebServiceRequestModel.ModelRunProcessRequest) {
        ModelRunProcessRequest request = webService;

        XmlElement xmlModel = createXmlElementChild_0(
          'ModelRunProcess',
          [
            createXmlElementChild_0(
              'serviceType',
              [XmlText(webService.getWebServiceType)],
            )
          ],
        );

        if (request.getProcessID != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'AD_Process_ID',
            [XmlText(request.getProcessID.toString())],
          ));
        }

        if (request.getMenuID != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'AD_Menu_ID',
            [XmlText(request.getMenuID.toString())],
          ));
        }

        if (request.getRecordID != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'AD_Record_ID',
            [XmlText(request.getRecordID.toString())],
          ));
        }

        if (request.getDocAction != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'DocAction',
            [XmlText(request.getDocAction.toString())],
          ));
        }
        if (request.getParamValues != null &&
            request.getParamValues.getFieldsCount() > 0) {
          xmlModel.children
              .add(_buildXmlFieldsContainer(request.getParamValues));
        }
        return xmlModel;
      }

      /// ModelSetDocActionRequest
      else if (webService.getWebServiceRequestModel() ==
          WebServiceRequestModel.ModelSetDocActionRequest) {
        ModelSetDocActionRequest request = webService;

        XmlElement xmlModel = createXmlElementChild_0(
          'ModelSetDocAction',
          [
            createXmlElementChild_0(
              'serviceType',
              [XmlText(webService.getWebServiceType)],
            )
          ],
        );

        if (request.getTableName != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'tableName',
            [XmlText(request.getTableName)],
          ));
        }

        if (request.getRecordID != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'recordID',
            [XmlText(request.getRecordID.toString())],
          ));
        }

        if (request.getRecordIDVariable != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'recordIDVariable',
            [XmlText(request.getRecordIDVariable)],
          ));
        }

        if (request.getDocAction != null) {
          xmlModel.children.add(createXmlElementChild_0(
            'docAction',
            [XmlText(request.getDocAction.value)],
          ));
        }
        return xmlModel;
      }

      return XmlElement(
        XmlName('NoModel'),
      );
    } catch (e) {
      throw Exception('Error building XML Fields Model container $e');
    }
  }

  static XmlElement _buildXmlOperation(Operation operation) {
    try {
      // print(operation.getWebService());
      XmlElement xmlOperation = XmlElement(
        XmlName('operation', RequestFactory.prefix_0),
        [
          XmlAttribute(XmlName('postCommit'),
              operation.isPostCommit.toString().toLowerCase()),
          XmlAttribute(XmlName('preCommit'),
              operation.isPreCommit.toString().toLowerCase())
        ],
        [
          createXmlElementChild_0(
            'TargetPort',
            [
              XmlText(operation
                  .getWebService()
                  .getWebServiceMethod()
                  .toString()
                  .split('.')
                  .last)
            ],
          )
        ],
      );
      xmlOperation.children.add(_buildXmlModel(operation.getWebService()));
      return xmlOperation;
    } catch (e) {
      throw Exception('Error building XML Fields Operation $e');
    }
  }

  static XmlElement _buildXmlFieldsContainer(FieldsContainer container) {
    try {
      XmlElement xmlFields = createXmlElement_0(
        container.getWebServiceFieldsContainerType().toString().split('.').last,
      );
      for (int i = 0; i < container.getFieldsCount(); i++) {
        xmlFields.children.add(_buildXmlField(container.getFieldAt(i)));
      }
      return xmlFields;
    } catch (e) {
      throw Exception('Error building XML Fields container $e');
    }
  }

  static XmlElement _buildXmlField(Field field) {
    try {
      XmlElement xmlField = createXmlElement_0('field');
      if (field.getColumn != null)
        xmlField.attributes
            .add(XmlAttribute(XmlName('column'), field.getColumn));

      if (field.getType != null)
        xmlField.attributes.add(XmlAttribute(XmlName('type'), field.getType));

      if (field.getLval != null)
        xmlField.attributes.add(XmlAttribute(XmlName('lval'), field.getLval));

      if (field.getDisp != null)
        xmlField.attributes.add(XmlAttribute(
            XmlName('disp'), field.getDisp.toString().toLowerCase()));

      if (field.getEdit != null)
        xmlField.attributes.add(XmlAttribute(
            XmlName('edit'), field.getEdit.toString().toLowerCase()));

      if (field.getError != null)
        xmlField.attributes.add(XmlAttribute(
            XmlName('error'), field.getError.toString().toLowerCase()));

      if (field.getErrorVal != null)
        xmlField.attributes
            .add(XmlAttribute(XmlName('errorVal'), field.getErrorVal));

      if (field.getValue != null) {
        var value;
        dynamic objValue = field.getValue;

        if (objValue is DateTime) {
          // SimpleDateFormat sdf = new SimpleDateFormat('yyyy-MM-dd HH:mm:ss');
          var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
          value = formatter.format(objValue);
        } else if (objValue is bool)
          value = objValue ? 'Y' : 'N';
        else if (objValue is DocAction)
          value = objValue.value;
        else if (objValue is DocStatus)
          value = objValue.value;
        else if (objValue is Uint8List)
          value = base64.encode(objValue);
        else
          value = objValue.toString();

        XmlElement xmlVal = createXmlElementChild_0('val', [XmlText(value)]);
        // Element xmlVal = createXmlElement_0(doc, 'val', value);
        xmlField.children.add(xmlVal);
      }

      return xmlField;
    } catch (e) {
      throw Exception('Error building XML Fields container : $e');
    }
  }

  static XmlNode _buildXmlLogin(LoginRequest login) {
    try {
      XmlElement xmlLogin = createXmlElement_0('ADLoginRequest');

      if (login.getUser != null) {
        xmlLogin.children.add(createXmlElementChild_0(
          'user',
          [XmlText(login.getUser)],
        ));
      }

      if (login.getPass != null) {
        xmlLogin.children.add(createXmlElementChild_0(
          'pass',
          [XmlText(login.getPass)],
        ));
      }

      if (login.getLang != null) {
        xmlLogin.children.add(createXmlElementChild_0(
          'lang',
          [XmlText(login.getLang.toString())],
        ));
      }

      if (login.getClientID != null) {
        xmlLogin.children.add(createXmlElementChild_0(
          'ClientID',
          [XmlText(login.getClientID.toString())],
        ));
      }

      if (login.getRoleID != null) {
        xmlLogin.children.add(createXmlElementChild_0(
          'RoleID',
          [XmlText(login.getRoleID.toString())],
        ));
      }

      if (login.getOrgID != null) {
        xmlLogin.children.add(createXmlElementChild_0(
          'OrgID',
          [XmlText(login.getOrgID.toString())],
        ));
      }

      if (login.getWarehouseID != null) {
        xmlLogin.children.add(createXmlElementChild_0(
          'WarehouseID',
          [XmlText(login.getWarehouseID.toString())],
        ));
      }

      if (login.getStage != null) {
        xmlLogin.children.add(createXmlElementChild_0(
          'stage',
          [XmlText(login.getStage.toString())],
        ));
      }
      return xmlLogin;
    } catch (e) {
      throw Exception('Error building XML body request : $e');
    }
  }
}
