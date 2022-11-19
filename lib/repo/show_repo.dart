import 'dart:convert';
import 'dart:developer';

import '../model/show_model.dart';
import 'package:http/http.dart' as http;

class ShowRepo {
  Future<List<ShowModel>?> getShowsList(String showQuery) async {
    log("Inside inside showrepo $showQuery");
    try {
      String apiUrl = "https://api.tvmaze.com/search/shows?q=$showQuery";
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // log(response.body);
        Iterable result = jsonDecode(response.body);
        List<ShowModel>? shows = List<ShowModel>.from(result.map((model) {
          // inspect(model);
          return ShowModel.fromJson(model);
        }));
        log("resultssssssssss: $result");
        return shows;
      } else {
        // throw Exception(response.statusCode);
        return null;
      }
    } on Exception catch (err) {
      //TODO: Implement Error Handling
    }
    // return null;
  }
}
