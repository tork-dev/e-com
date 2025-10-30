import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utils/constants/colors.dart';


class PostComment extends StatelessWidget {
  const PostComment({super.key, required this.onTextFieldTap, required this.onSendButtonPress, required this.textFileFocusNode, required this.commentController});

  final VoidCallback onTextFieldTap, onSendButtonPress;
  final FocusNode textFileFocusNode;
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.light
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTap: onTextFieldTap,
              focusNode: textFileFocusNode,
              controller: commentController,
              decoration: InputDecoration(
                hintText: "Write Comment",
                hintStyle: Theme.of(context).textTheme.labelMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.lightGrey)
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onChanged: (value){
                debugPrint('print ${commentController.text}');
              },
            ),
          ),
          const Gap(10),
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.primary),
            onPressed: onSendButtonPress
          ),
        ],
      ),
    );
  }
}