import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/community/controller/community_controller.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/local_storage/local_storage_keys.dart';
import 'package:kirei/src/utils/local_storage/storage_utility.dart';
import 'package:like_button/like_button.dart';

class CommunityLikeButton extends StatelessWidget {
  final int cardIndex;
  const CommunityLikeButton({super.key, required this.cardIndex});

  @override
  Widget build(BuildContext context) {
    final controller = CommunityController.instance;
    return Obx(() {
        return LikeButton(
          onTap: (bool isLiked) async {
            if (AppLocalStorage().readData(LocalStorageKeys.isLoggedIn) == true) {
              controller.getAddCommunityLike(controller.communityResponse.value.data![cardIndex].id.toString());
            } else {
              AppHelperFunctions.showToast('Login first!');
              Get.toNamed('/login/community');
            }
            return !isLiked;
          },

          size: 32,
          isLiked: controller.communityResponse.value.data![cardIndex].isLike == true ? true : false,
          circleColor: const CircleColor(
              start: Color(0xff00ddff), end: Color(0xff0099cc)),
          bubblesColor: const BubblesColor(
            dotPrimaryColor: Color(0xff33b5e5),
            dotSecondaryColor: Color(0xff0099cc),
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.favorite,
              color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
              size: 31,
            );
          },
          likeCount: controller.communityResponse.value.data![cardIndex].likeCount,
          countPostion: CountPostion.right,
          likeCountPadding: const EdgeInsets.all(0),
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          countBuilder: (int? count, bool isLiked, String text) {
            var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
            Widget result;
            if (count == 0) {
              result = Text(
                "love",
                style: TextStyle(color: color),
              );
            } else {
              result = Text(
                text,
                style: TextStyle(color: color, fontSize: 18),
              );
            }
            return result;
          },
        );
      }
    );
  }
}

