import 'package:flutter/material.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';

class PaymentStatusIndicator extends StatelessWidget {
  const PaymentStatusIndicator({required this.paymentStatus, super.key});

  final String paymentStatus;

  @override
  Widget build(BuildContext context) {
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
              ? Icons.check
              : Icons.close,
          size: 15,
          color: AppColors.white,
        ));
  }
}
