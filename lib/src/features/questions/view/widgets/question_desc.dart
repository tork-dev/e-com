import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class AppQuestionDescriptionPart extends StatelessWidget {
  const AppQuestionDescriptionPart({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child:  Visibility(
                child: ExpandableNotifier(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expandable(
                        collapsed: SizedBox(
                          height: 20,
                          child: Text(description),
                        ),
                        expanded:  SizedBox(
                          child: Text(description),
                        ),

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Builder(
                            builder: (context) {
                              var controller = ExpandableController.of(context);
                              return Padding(
                                padding:  const EdgeInsets.only(
                                    right: 10.0, top: 8.0),
                                child: Visibility(
                                  visible: description.length > 100,
                                  child: InkWell(
                                    child: Text(
                                        !controller!.expanded
                                            ? 'view More'
                                            : 'Show Less',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge!
                                            .apply(
                                                color: AppColors.primary,
                                                decoration:
                                                    TextDecoration.underline)),
                                    onTap: () {
                                      controller.toggle();
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Gap(AppSizes.spaceBtwDefaultItems),
                    ],
                  ),
                ),
              )
    );
  }
}
