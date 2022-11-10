class ImagesModel {
  bool? isError;
  String? errorMessage;
  List<dynamic>? images;
  List<String>? links;

  ImagesModel(
     { this.isError,
       this.errorMessage,
       this.images,this.links});
}
