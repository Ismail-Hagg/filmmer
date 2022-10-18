import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/trailer_model.dart';

class TrailerService {
  Future<TrailerModel> getHomeInfo(String link) async {
    TrailerModel model = TrailerModel();
    dynamic result = '';
    var url = Uri.parse(link);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
        model = TrailerModel.fromJson(result);
      } else {
        model =
            TrailerModel(isError: true, errorMessage: 'status code not 200');
      }
      return model;
    } catch (e) {
      return TrailerModel(isError: true, errorMessage: e.toString());
    }
  }
}
