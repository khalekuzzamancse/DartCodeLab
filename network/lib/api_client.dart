import 'package:http/http.dart' as http;
import 'dart:convert';
import 'json_parser.dart';

abstract class ApiClient {
/**
 * - `Return` the retrieved raw `json `or throws `Custom exception`
 * 
 * More Info:
 * - Equivalent to `suspend fun readJsonOrThrow(...)` ,since it return `Future`
 */
  Future<String> readOrThrow(String url);

  /**
   * - `Reads and Parses` the `json` response into a model of type `T`
   * - Throws `Custom exception` if the process fails
   * 
   * More Info:
   * - `T Function(Map<String, dynamic>) fromJson` is used to convert raw `json` into `T`
   */
  Future<T> readParseOrThrow<T>(
      String url, T Function(Map<String, dynamic>) fromJson);

  static ApiClient create() => ApiClientImpl._internal();
}

class ApiClientImpl implements ApiClient {
  ApiClientImpl._internal();

  @override
  Future<String> readOrThrow(String url) async {
    final _url = Uri.parse(url);
    var response = await http.get(_url);

    if (response.statusCode == 200) {
      return response.body; //Raw Json
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw UnsupportedError("Server returned failure");
    }
  }

  @override
  Future<T> readParseOrThrow<T>(
      String url, T Function(Map<String, dynamic>) fromJson) async {
    final rawJson = await readOrThrow(url);
    final parser = JsonParser.create();
    return parser.parseOrThrow(rawJson, fromJson);
  }
}
