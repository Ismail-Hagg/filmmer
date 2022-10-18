import 'package:filmpro/models/results_model.dart';

class HomePageModel {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;
  List<String>? initial;
  bool? isError;
  String? errorMessage;

  HomePageModel({this.page, this.results, this.totalPages, this.totalResults,this.initial,this.isError,this.errorMessage});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    isError=false;
    errorMessage='';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] =totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}