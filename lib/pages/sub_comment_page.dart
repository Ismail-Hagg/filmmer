import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/movie_detale_controller.dart';
import '../controllers/sub_comment_controller.dart';
import '../helper/constants.dart';
import '../models/comment_model.dart';
import '../widgets/comments_widget.dart';

class SubComment extends StatelessWidget {
  final MovieDetaleController pastController;
  final String movieId;
  final String mainPostId;
  final String firePostId;
  SubComment(
      {Key? key,
      required this.movieId,
      required this.mainPostId,
      required this.firePostId, required this.pastController})
      : super(key: key);

  final SubCommentControllrt controller = Get.put(
    SubCommentControllrt(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: secondaryColor,
        body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            var width = constraints.maxWidth;
            var height = constraints.maxHeight;
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Comments')
                  .doc(movieId)
                  .collection('Comments')
                  .orderBy('timeStamp', descending: false)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: orangeColor,
                    ),
                  );
                }
                controller.modelComments(snapshot.data!.docs, mainPostId);
                return Column(
                  children: [
                    SizedBox(
                      height: height * 0.9,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Comments(
                              controller: pastController,
                              showView: false,
                              width: width,
                              comment: controller.mainComment,
                              like: () => Get.find<MovieDetaleController>()
                                  .likeSystem(
                                      true,
                                      controller.mainComment.postId,
                                      movieId,
                                      firePostId,
                                      controller.mainComment.likeCount),
                              delete: () => controller.deleteReply(
                                  controller.mainComment,
                                  movieId,
                                  firePostId,
                                  controller.mainComment.postId,
                                  controller.mainComment.isSub),
                              nav: () {},
                              disLike: () => Get.find<MovieDetaleController>()
                                  .likeSystem(
                                      false,
                                      controller.mainComment.postId,
                                      movieId,
                                      firePostId,
                                      controller.mainComment.dislikeCount),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 16),
                              child: Divider(color: orangeColor, thickness: 2),
                            ),
                            Column(
                                children: List.generate(
                                    controller.commentsList.length, (index) {
                              return Comments(
                                controller: pastController,
                                showView: false,
                                width: width,
                                comment: controller.commentsList[index],
                                like: () =>controller.subLikeSystem(
                                  true,
                                  mainPostId,
                                  movieId,
                                  firePostId,
                                  controller.commentsList,
                                  index
                                ),
                                delete: () => controller.deleteReply(
                                    controller.mainComment,
                                    movieId,
                                    firePostId,
                                    controller.commentsList[index].postId,
                                    controller.commentsList[index].isSub),
                                nav: () {},
                                disLike: () =>controller.subLikeSystem(
                                  false,
                                  mainPostId,
                                  movieId,
                                  firePostId,
                                  controller.commentsList,
                                  index
                                ),
                              );
                            }))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: orangeColor, width: 1)),
                      height: height * 0.1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: TextField(
                              controller: controller.txtControlller,
                              focusNode: controller.myFocusNode,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              cursorColor: orangeColor,
                              style: TextStyle(
                                  color: orangeColor, fontSize: width * 0.04),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'comments'.tr,
                                hintStyle: const TextStyle(
                                  color: orangeColor,
                                ),
                              ),
                            )),
                            GetBuilder(
                              init: controller,
                              builder: (thing) => controller.loader == 0
                                  ? IconButton(
                                      splashRadius: 15,
                                      icon: Icon(Icons.send,
                                          color: orangeColor,
                                          size: width * 0.06),
                                      onPressed: () {
                                        controller.uploadReply(
                                            controller.txtControlller.text
                                                .trim(),
                                            movieId,
                                            firePostId,
                                            controller.mainComment.subComments);
                                      })
                                  : const Center(
                                      child: CircularProgressIndicator(
                                          color: orangeColor),
                                    ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          }),
        ));
  }
}
