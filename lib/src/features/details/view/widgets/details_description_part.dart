import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:torganic/src/features/details/controller/details_page_controller.dart';

class AppDetailsDescriptionPart extends StatelessWidget {
  const AppDetailsDescriptionPart({super.key});

  @override
  Widget build(BuildContext context) {
    final detailsController = DetailsPageController.instance;
    return Text(
      detailsController.productDetails.value.detailedProducts!.shortDescription.toString(),
      // trimLines: 2,
      // trimCollapsedText: 'Show more',
      // trimExpandedText: 'Show less',
    );
  }
}
