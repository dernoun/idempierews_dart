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

import 'package:xml/xml.dart';
import 'dart:io';
import 'base.dart';
import 'request.dart';
import 'response.dart';

class WebServiceConnection {
  static const String CHARSET_UTF8 = 'UTF-8';
  static const String DEFAULT_CONTENT_TYPE = 'text/xml; charset=UTF-8';
  static const String DEFAULT_REQUEST_METHOD = 'POST';
  static const int DEFAULT_TIMEOUT = 5000;
  static const int DEFAULT_ATTEMPTS = 1;
  static const int DEFAULT_ATTEMPTS_TIMEOUT = 500;

  String _appName;
  String _url;
  String _contentType;
  String _requestMethod;
  int _attempts;
  int _timeout;
  int _attemptsTimeout;
  int _timeRequest;
  int _attemptsRequest;

  // Proxy proxy;
  XmlDocument _xmlRequest;
  XmlDocument _xmlResponse;
  WebServiceRequest _request;

  XmlDocument get getXmlRequest => _xmlRequest;

  XmlDocument get getXmlResponse => _xmlResponse;

  String getUserAgent() {
    return ('${ComponentInfo.name} (${ComponentInfo.componentName}/${ComponentInfo.version}/Dart/${Platform.operatingSystem} ${Platform.operatingSystemVersion} ${Platform.version}) $getAppName');
  }

  String get getAppName {
    if (_appName == null) return '';
    return _appName;
  }

  set setAppName(String appName) => _appName = appName;

  int get getAttempts {
    if (_attempts <= 0) return DEFAULT_ATTEMPTS;
    return _attempts;
  }

  set setAttempts(int attempts) => _attempts = attempts;

  int get getAttemptsTimeout {
    if (_attemptsTimeout <= 0) return DEFAULT_ATTEMPTS_TIMEOUT;
    return _attemptsTimeout;
  }

  set setAttemptsTimeout(int attemptsTimeout) =>
      _attemptsTimeout = attemptsTimeout;

  int get getTimeout {
    if (_timeout <= 0) return DEFAULT_TIMEOUT;
    return _timeout;
  }

  set setTimeout(int timeout) => _timeout = timeout;

  String get getUrl {
    if (_url == null) return '';
    return _url;
  }

  set setUrl(String url) => _url = url;

  String _getPath() {
    if (_request == null) return null;
    return ('/ADInterface/services/${_request.getWebServiceDefinition().toString().split('.').last}');
  }

  String _getWebServiceUrl() {
    if (_getPath() == null) return getUrl;

    String url = getUrl;
    if (url.endsWith('/')) url = url.substring(0, url.length - 1);

    String path = _getPath();
    if (path.startsWith('/')) path = path.substring(1);
    return ('$_url/$path');
  }

  String get getContentType {
    if (_contentType == null) return DEFAULT_CONTENT_TYPE;
    return _contentType;
  }

  set setContentType(String contentType) => _contentType = contentType;

  String get getRequestMethod {
    if (_requestMethod == null) return DEFAULT_REQUEST_METHOD;
    return _requestMethod;
  }

  set setRequestMethod(String requestMethod) => _requestMethod = requestMethod;

  int get getTimeRequest => _timeRequest;

  int get getAttemptsRequest => _attemptsRequest;

  WebServiceConnection() {
    _requestMethod = DEFAULT_REQUEST_METHOD;
    _attempts = DEFAULT_ATTEMPTS;
    _attemptsTimeout = DEFAULT_ATTEMPTS_TIMEOUT;
    _timeout = DEFAULT_TIMEOUT;
    _contentType = DEFAULT_CONTENT_TYPE;
    _url = '';
  }

  Future<XmlDocument> sendStringRequest(String dataRequest) async {
    if (getUrl == null || getUrl.isEmpty)
      throw Exception('URL must be different than empty or null');

    final startTime = Stopwatch()..start();
    _attemptsRequest = 0;
    bool successful = false;
    String dataResponse;

    while (!successful) {
      _attemptsRequest++;
      try {
        Uri uri = Uri.parse(_getWebServiceUrl());
        var httpClient = HttpClient();
        httpClient.connectionTimeout = Duration(milliseconds: getTimeout);
        httpClient.idleTimeout = Duration(milliseconds: getTimeout);
        httpClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) =>
                true); // Allow self signed certificates

        await httpClient
            .openUrl(getRequestMethod, uri)
            .then((HttpClientRequest request) async {
          // request.headers.add(HttpHeaders.acceptEncodingHeader, 'gzip');
          request.headers.contentType =
              new ContentType('application', 'text/xml', charset: 'UTF-8');
          request.write(dataRequest);

          await request.close().then((HttpClientResponse response) async {
            var data = await utf8.decoder.bind(response).toList();
            dataResponse = data.join();
            // print(response.statusCode);
            // response.headers.contentType = new ContentType('application', 'text/xml', charset: 'UTF-8');
            // response.transform(utf8.decoder).listen((contents) {
            //   dataResponse = contents;
            // print(dataResponse);
            //   successful = true;
            // });
            successful = true;
            httpClient.close();
          });
          _timeRequest = startTime.elapsed.inMilliseconds;
        });
      } catch (e) {
        if (_attemptsRequest >= getAttempts) {
          _timeRequest = startTime.elapsed.inMilliseconds;
          if (e is SocketException)
            throw Exception('Timeout exception, operation has expired: $e');
          throw Exception('Error sending request: $e');
        } else {
          sleep(Duration(milliseconds: getAttemptsTimeout));
          continue;
        }
      }
    }

    try {
      if (successful) {
        XmlDocument doc;
        doc = parse(dataResponse);
        return doc;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error converting response to Document: $e');
    }
  }

  Future<XmlDocument> sendDocRequest(XmlDocument dataRequest) async {
    XmlDocument document;
    try {
      String request = dataRequest.toString();
      document = await sendStringRequest(request);
    } catch (e) {
      throw Exception('Error sending request: $e');
    }
    return document;
  }

  Future<WebServiceResponse> sendRequest(WebServiceRequest request) async {
    this._request = request;

    XmlDocument xmlRequest;
    try {
      xmlRequest = RequestFactory.createRequest(request);
      this._xmlRequest = xmlRequest;
    } catch (e) {
      throw Exception('Request Factory error: $e');
    }

    XmlDocument xmlResponse = await sendDocRequest(xmlRequest);
    this._xmlResponse = xmlResponse;

    try {
      WebServiceResponse response = ResponseFactory.createResponse(
          request.getWebServiceResponseModel(), xmlResponse);

      if ((response is CompositeResponse) && (request is CompositeRequest)) {
        CompositeResponse compositeResponse = response;
        CompositeRequest compositeRequest = request;

        if (compositeResponse.getResponsesCount() > 0) {
          List<WebServiceResponse> responses = compositeResponse.getResponses();
          List<Operation> operations = compositeRequest.getOperations();

          for (int i = 0; i < responses.length; i++) {
            WebServiceResponse tempResponse = responses.elementAt(i);
            WebServiceRequest temRequest =
                operations.elementAt(i).getWebService();
            tempResponse.setWebServiceType = temRequest.getWebServiceType;
          }
        }
      }

      response.setWebServiceType = request.getWebServiceType;
      return response;
    } catch (e) {
      throw Exception('Response Factory error: $e');
    }
  }

  void writeRequest(String fileName) {
    var requestFile = new File(fileName);
    requestFile.writeAsString(_xmlRequest.toXmlString(pretty: true));
  }

  void writeResponse(String fileName) {
    if (_xmlResponse != null) {
      var responseFile = new File(fileName);
      responseFile.writeAsString(_xmlResponse.toXmlString(pretty: true));
    }
  }
}
