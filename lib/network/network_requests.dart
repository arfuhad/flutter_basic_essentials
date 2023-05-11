import 'dart:convert';
import 'dart:io';
import 'package:meta/meta.dart';
import 'package:flutter_basic_essentials/network/network.dart';

abstract class NetworkRequests {
  Future<String> getRequest(
      {@required String url,
      @required Map<String, String> headers,
      bool isDirectUrl = false});
  Future<String> postRequest(
      {@required String url,
      @required String body,
      @required Map<String, String> headers,
      bool isDirectUrl = false});
  Future<String> putRequest(
      {@required String url,
      @required String body,
      @required Map<String, String> headers,
      bool isDirectUrl = false});
  Future<String> deleteRequest(
      {@required String url,
      @required String body,
      @required Map<String, String> headers,
      bool isDirectUrl = false});
}

///[NetworkRequestsImplement] required "[HttpClient]" as client, "[String]" baseUrl
///additional parameters "[int]" port, "[String]" additionalUrl,
/// "[bool]" isBadCertificate (default "[false]",
/// switch it "[true]" if server is not HTTPS / certificate is not good / not installed)
///
class NetworkRequestsImplement implements NetworkRequests {
  final String? baseUrl;
  final int? port;
  final String? additionalUrl;
  final HttpClient? client;
  final bool isBadCertificate;

  String _tag = "Flutter Network Requests: ";

  NetworkRequestsImplement(
      {@required this.client,
      @required this.baseUrl,
      this.port,
      this.additionalUrl = "",
      this.isBadCertificate = false})
      : assert(client != null && baseUrl != null,
            'A non-null values must be provided to the NetworkRequestsImplement class') {
    if (isBadCertificate) {
      client?.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    }
  }

  Uri _getUri({@required String? specificUrl, bool isDirectUrl = false}) {
    if (isDirectUrl) {
      return Uri.parse(specificUrl as String);
    } else {
      if (port == null) {
        return Uri.parse((baseUrl as String) +
            (additionalUrl as String) +
            (specificUrl as String));
      }
      return Uri.parse((baseUrl as String) +
          ":" +
          port.toString() +
          (additionalUrl as String) +
          (specificUrl as String));
    }
  }

  ///[getRequest] required "String" url, "Map<String, String>" headers,
  /// "bool" isDirectUrl (default "false",
  /// switch it "true" if url is direct url like as "https://www.google.com"
  /// if "false" url will be append as initial "baseUrl" in [NetworkRequestsImplement])
  ///
  /// return response as "String"
  @override
  Future<String> getRequest(
      {@required String? url,
      @required Map<String, String>? headers,
      bool isDirectUrl = false}) async {
    print(_tag + "init get request");
    var responseJson;
    try {
      HttpClientRequest request;
      request = await client!
          .getUrl(_getUri(specificUrl: url, isDirectUrl: isDirectUrl));
      headers!.forEach((k, v) => request.headers.set(k, v));
      final response = await request.close();
      responseJson = await _returnHttpResponse(response);
    } catch (e) {
      if (e == SocketException)
        throw FetchDataException('No Internet connection');
      else
        throw FetchDataException(e.toString());
    }
    return responseJson;
  }

  ///[postRequest] required "String" url, "Map<String, String>" headers, "String" body
  /// "bool" isDirectUrl (default "false",
  /// switch it "true" if url is direct url like as "https://www.google.com"
  /// if "false" url will be append as initial "baseUrl" in [NetworkRequestsImplement])
  ///
  /// return response as "String"
  @override
  Future<String> postRequest(
      {@required String? url,
      @required String? body,
      @required Map<String, String>? headers,
      bool isDirectUrl = false}) async {
    print(_tag + "init post request");
    var responseJson;
    try {
      HttpClientRequest request;
      request = await client!
          .postUrl(_getUri(specificUrl: url, isDirectUrl: isDirectUrl));
      headers!.forEach((k, v) => request.headers.set(k, v));
      request.write(body);
      final response = await request.close();
      responseJson = await _returnHttpResponse(response);
    } catch (e) {
      if (e == SocketException)
        throw FetchDataException('No Internet connection');
      else
        throw FetchDataException(e.toString());
    }
    return responseJson;
  }

  ///[putRequest] required "String" url, "Map<String, String>" headers, "String" body
  /// "bool" isDirectUrl (default "false",
  /// switch it "true" if url is direct url like as "https://www.google.com"
  /// if "false" url will be append as initial "baseUrl" in [NetworkRequestsImplement])
  ///
  /// return response as "String"
  @override
  Future<String> putRequest(
      {@required String? url,
      @required String? body,
      @required Map<String, String>? headers,
      bool isDirectUrl = false}) async {
    print(_tag + "init put request");
    var responseJson;
    try {
      final request = await client!
          .putUrl(_getUri(specificUrl: url, isDirectUrl: isDirectUrl));
      headers!.forEach((k, v) => request.headers.set(k, v));
      request.write(body);
      final response = await request.close();
      responseJson = await _returnHttpResponse(response);
    } catch (e) {
      if (e == SocketException)
        throw FetchDataException('No Internet connection');
      else
        throw FetchDataException(e.toString());
    }
    return responseJson;
  }

  ///[deleteRequest] required "String" url, "Map<String, String>" headers, "String" body
  /// "bool" isDirectUrl (default "false",
  /// switch it "true" if url is direct url like as "https://www.google.com"
  /// if "false" url will be append as initial "baseUrl" in [NetworkRequestsImplement])
  ///
  /// return response as "String"
  @override
  Future<String> deleteRequest(
      {@required String? url,
      @required String? body,
      @required Map<String, String>? headers,
      bool isDirectUrl = false}) async {
    print(_tag + "init put request");
    var responseJson;
    try {
      final request = await client!
          .deleteUrl(_getUri(specificUrl: url, isDirectUrl: isDirectUrl));
      headers!.forEach((k, v) => request.headers.set(k, v));
      request.write(body);
      final response = await request.close();
      responseJson = await _returnHttpResponse(response);
    } catch (e) {
      if (e == SocketException)
        throw FetchDataException('No Internet connection');
      else
        throw FetchDataException(e.toString());
    }
    return responseJson;
  }

  Future<String> _returnHttpResponse(HttpClientResponse response) async {
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      var responseJson = await response.transform(utf8.decoder).join();
      return responseJson;
    } else {
      switch (response.statusCode) {
        case 400:
          throw BadRequestException(
              await response.transform(utf8.decoder).join());
        case 401:
        case 403:
          throw UnauthorisedException(
              await response.transform(utf8.decoder).join());
        case 404:
          throw NotFoundException(
              await response.transform(utf8.decoder).join());
        case 500:
          throw ServerException(await response.transform(utf8.decoder).join());
        default:
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      }
    }
  }
}
