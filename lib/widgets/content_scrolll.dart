// import 'package:flutter/material.dart';

// import '../models/home_page_model.dart';
// import '../models/movie_deltale_model.dart';
// import 'custom_text.dart';

// class ContentScrolling extends StatelessWidget {
//   final Color color;
//   final Color textColor;
//   final Color? borderColor;
//   final double inHeight;
//   final double inWidth;
//   final double paddingY;
//   final double pageWidth;
//   final double? borderWidth;
//   final bool isError;
//   final bool isArrow;
//   final bool isTitle;
//   final bool isMovie;
//   final bool isShadow;
//   //final bool isCast;
//   final String? title;
//   final BoxFit fit;
//   final HomePageModel? model;
//   final MovieDetaleModel? detales;
//   final Function reload;

//   const ContentScrolling(
//       {super.key,
//       required this.color,
//       this.borderColor,
//       required this.inHeight,
//       required this.inWidth,
//       required this.paddingY,
//       required this.pageWidth,
//       this.borderWidth,
//       required this.isError,
//       required this.isArrow,
//       required this.isTitle,
//       required this.isMovie,
//       required this.isShadow,
//       //required this.isCast,
//       this.title,
//       required this.fit,
//       this.model,
//       this.detales,
//       required this.reload, required this.textColor});

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child:
//             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           isTitle
//               ? CustomText(
//                   text: title.toString(),
//                   size: pageWidth*0.05,
//                   color: textColor,
//                   weight: FontWeight.bold,
//                 )
//               : Container(),
//               isArrow
//                         ? IconButton(
//                             splashRadius: 15,
//                             onPressed: reload(),
//                             icon: Icon(Icons.arrow_forward,
//                                 color: textColor, size: pageWidth*0.05))
//                         : Container()
//         ]),
//       ),
//       const SizedBox(
//                 height: 8,
//               ),
//               isMovie?
//                model.isError == true
//         ? SizedBox(
//             height: height,
//             child:  Center(
//               child: GestureDetector(
//                 onTap: ()=>Get.find<HomeController>().apiCall(Get.find<HomeController>().model.language),
//                 child:Icon(Icons.refresh,size:height*0.2,color: orangeColor,),
//               )
//             ),
//           )
//         :
//     ]);
//   }
// }
