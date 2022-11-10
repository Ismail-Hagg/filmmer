import 'dart:convert';

import 'package:filmpro/helper/constants.dart';
import 'package:http/http.dart' as http;

import '../models/images_model.dart';

class ImagesService {
  Future<ImagesModel> getImages(String media, String id, String lang) async {
    String type = media == 'person' ? 'profiles' : 'posters';
    ImagesModel model = ImagesModel();
    var url = Uri.parse(
        'https://api.themoviedb.org/3/$media/$id/images?api_key=$apiKey&language=$lang');

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        model = ImagesModel(
            errorMessage: '',
            images: json.decode((response.body))[type],
            isError: false,
            links: []);
        for (var i = 0; i < json.decode((response.body))[type].length; i++) {
          model.links!.add(json.decode((response.body))[type][i]['file_path']);
        }
      } else {
        model = ImagesModel(
            errorMessage: 'Status Code is not 200', images: [], isError: true);
      }
      return model;
    } catch (e) {
      return ImagesModel(errorMessage: e.toString(), images: [], isError: true);
    }
  }
}
