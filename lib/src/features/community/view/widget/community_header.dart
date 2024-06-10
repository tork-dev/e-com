import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

class CommunityHeader extends StatelessWidget {
  const CommunityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCardContainer(
        padding: EdgeInsets.all(AppSizes.md),
        child: Column(
          children: [
            Text(
              'Community Post',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: Colors.blue),
            )
          ],
        ));
  }
}
