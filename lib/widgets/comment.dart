import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/movie_detale_controller.dart';
import '../helper/constants.dart';

class Comments extends StatelessWidget {
  final double height;
  final double width;
   Comments({Key? key, required this.height, required this.width}) : super(key: key);

  final MovieDetaleController controller = Get.find<MovieDetaleController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(child: TextField(
                focusNode: controller.myFocusNode,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                cursorColor: orangeColor,
                style:  TextStyle(color: orangeColor,fontSize:MediaQuery.of(context).size.width*0.045),
                decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'comments'.tr,
                        hintStyle: const TextStyle(
                          color: orangeColor,
                        ),
                      ),
              )),
              IconButton(
                  splashRadius: 15,
                  icon: Icon(Icons.send, color: orangeColor, size: width * 0.06),
                  onPressed: () => {FocusScope.of(context).unfocus()}),
            ],
          ),
        )
      ],
    );
  }
}
