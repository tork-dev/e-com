import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:torganic/src/features/purchase_history/controller/purchase_history_controller.dart';
import 'package:torganic/src/features/purchase_history/controller/purchase_history_details_controller.dart';

import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';

class PaymentStatusIndicator extends StatelessWidget {
  const PaymentStatusIndicator({required this.paymentStatus, super.key});

  final String paymentStatus;

  @override
  Widget build(BuildContext context) {
    final purchaseHistoryController = PurchaseHistoryController.instance;
    return AppCardContainer(
        height: 20,
        width: 20,
        //padding: EdgeInsets.all(5),
        borderRadius: 100,
        backgroundColor: paymentStatus ==
                "paid"
            ? Colors.green
            : paymentStatus ==
                    "COD"
                ? Colors.orange
                : Colors.red,
        child: Icon(
          paymentStatus ==
                      "paid" ||
              paymentStatus ==
                      "COD"
              ? FontAwesomeIcons.check
              : FontAwesomeIcons.xmark,
          size: 15,
          color: AppColors.white,
        ));
  }
}
