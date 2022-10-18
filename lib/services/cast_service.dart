import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cast_model.dart';

class CastService {
  Future<CastModel> getHomeInfo(String link) async {
    CastModel model = CastModel();
    dynamic result = '';
    var url = Uri.parse(link);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
        model = CastModel.fromJson(result);
      } else {
        model =
            CastModel(isError: true, errorMessage: 'status code not 200');
      }
      return model;
    } catch (e) {
      return CastModel(isError: true, errorMessage: e.toString());
    }
  }
}
