import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:torganic/src/common/widgets/containers/card_container.dart';
import 'package:torganic/src/utils/constants/colors.dart';
import 'package:torganic/src/utils/constants/sizes.dart';

class AppSortAlertDialog extends StatelessWidget {
  const AppSortAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(
        top: 16.0,
        left: 2.0,
        right: 16,
        bottom: 2.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm), // Customize border radius here
      ),
      backgroundColor: AppColors.white,
      content: AppCardContainer(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Sort Products By'),
            ),
            RadioListTile(
              dense: true,
              value: "default",
              groupValue: 1,
              //activeColor: Theme.of(context).accentColor,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Default'),
              onChanged: (value) {
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              dense: true,
              value: "bestseller",
              groupValue: 1,
              //activeColor: Theme.of(context).accentColor,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Best Selling'),
              onChanged: (value) {
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              dense: true,
              value: "rating",
              groupValue: 1,
              //activeColor: Theme.of(context).accentColor,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Rating'),
              onChanged: (value) {
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              dense: true,
              value: "new",
              groupValue: 1,
              //activeColor: Theme.of(context).accentColor,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Newest'),
              onChanged: (value) {
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              dense: true,
              value: "hot",
              groupValue: 1,
              //activeColor: Theme.of(context).accentColor,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Hot Deal'),
              onChanged: (value) {
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              dense: true,
              value: "price-desc",
              groupValue: 1,
              //activeColor: Theme.of(context).accentColor,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Price high to low'),
              onChanged: (value) {
                Navigator.pop(context);
              },
            ),
            RadioListTile(
              dense: true,
              value: "price-asc",
              groupValue: 1,
              //activeColor: Theme.of(context).accentColor,
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('Price low to high'),
              onChanged: (value) {
                Navigator.pop(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: ()=> Get.back(),
                    child: Text('Close'.toUpperCase())),
              ],
            )
          ],
        ),
      ),
    );
  }
}
