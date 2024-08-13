// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bkash/flutter_bkash.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/payment_gateway/controllers/payment_controllers.dart';
import 'package:kirei/src/features/payment_gateway/stripe/repository/stripe_repository.dart';
import 'package:kirei/src/utils/constants/image_strings.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import 'package:kirei/src/utils/popups/full_screen_loader.dart';
import 'widget/packageCard.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = Get.put(PaymentController());
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy package"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                //   package cards
                packageCard(
                  Icon(Icons.star),
                  'Silver',
                  200,
                  'এই পেকেজটি ক্রয় করলে আপনি ৩ মাসের জন্য আমাদের প্রিমিয়াম সার্ভিসগুলোর ভিডিও সেকশন এর অ্যাক্সেস পাবেন',
                  3,
                      () {
                    controller.paymentCheckoutWithSSL();
                  },
                ),
                packageCard(
                  Icon(Icons.pages_outlined),
                  'Gold',
                  700,
                  'এই পেকেজটি ক্রয় করলে আপনি ৯ মাসের জন্য আমাদের প্রিমিয়াম সার্ভিসগুলোর ভিডিও ও PDF সেকশন এর অ্যাক্সেস পাবেন',
                  9,
                      () {
                    controller.paymentCheckoutWithBkash(200);
                  },
                ),
                packageCard(
                  Icon(Icons.diamond),
                  'Diamond',
                  1500,
                  'এই পেকেজটি ক্রয় করলে আপনি ২ বছরের জন্য আমাদের প্রিমিয়াম সকল সার্ভিস এর অ্যাক্সেস পাবেন',
                  24,
                      () {
                    controller.paymentCheckoutWithStripe();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}