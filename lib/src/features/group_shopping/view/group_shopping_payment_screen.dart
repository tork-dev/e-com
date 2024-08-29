import 'package:flutter/material.dart';
import 'package:kirei/src/common/layouts/layout_with_back_button/layout_with_back_button.dart';
import 'package:kirei/src/features/group_shopping/view/widgets/group_checkout_alert.dart';

class GroupShoppingPaymentScreen extends StatelessWidget {
  const GroupShoppingPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppLayoutWithBackButton(
        body: GroupCheckoutAlert());
  }
}

