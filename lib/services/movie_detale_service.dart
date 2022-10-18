import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_deltale_model.dart';

class MovieDetaleService {
  Future<MovieDetaleModel> getHomeInfo(String link) async {
    MovieDetaleModel model = MovieDetaleModel();
    dynamic result = '';
    var url = Uri.parse(link);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
        model = MovieDetaleModel.fromJson(result);
      } else {
        model =
            MovieDetaleModel(isError: true, errorMessage: 'status code not 200');
      }
      return model;
    } catch (e) {
      return MovieDetaleModel(isError: true, errorMessage: e.toString());
    }
  }
}
