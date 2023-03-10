import 'dart:async';
import 'dart:convert';
import '../model/movie_data.dart';
import '../utils/backend_api.dart';
import 'package:http/http.dart';

class HttpService {
  /// Discover API
  static Future<MovieData?> discoverAPI(int page, [String sort = 'desc']) async {
    String url = '${BackendAPI.apiHost}&sort_by=popularity.$sort&page=${page.toString()}';

    Response? response;
    response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load discover api');
    }
  }
}
