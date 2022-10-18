import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recomendation_model.dart';

class RecommendationService {
  Future<RecomendationModel> getHomeInfo(String link) async {
    RecomendationModel model = RecomendationModel();
    dynamic result = '';
    var url = Uri.parse(link);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
        model = RecomendationModel.fromJson(result);
      } else {
        model =
            RecomendationModel(isError: true, errorMessage: 'status code not 200');
      }
      return model;
    } catch (e) {
      return RecomendationModel(isError: true, errorMessage: e.toString());
    }
  }
}
