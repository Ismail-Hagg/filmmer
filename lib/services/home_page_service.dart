import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/home_page_model.dart';

class HomePageService {
  Future<HomePageModel> getHomeInfo(String link, String language) async {
    HomePageModel model = HomePageModel();
    dynamic result = '';
    var url = Uri.parse(link + language);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        result = jsonDecode(response.body);
        print(result['results'][0]['vote_average']);
        print((result['results'][0]['vote_average']).runtimeType);
        model = HomePageModel.fromJson(result);
      } else {
        model =
            HomePageModel(isError: true, errorMessage: 'status code not 200');
      }
      return model;
    } catch (e) {
      return HomePageModel(isError: true, errorMessage: e.toString());
    }
  }
}
