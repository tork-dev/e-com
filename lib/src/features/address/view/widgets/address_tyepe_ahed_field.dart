import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:torganic/src/features/address/controller/address_controller.dart';
import '../../../../common/widgets/containers/card_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class AppTypeAhedField extends StatelessWidget {
  final String fieldTitle;
  int selectedAddressId;
  String selectedAddressName;
  TextEditingController controller;
  List addressList;

  AppTypeAhedField(
      {super.key,
      required this.fieldTitle,
      required this.selectedAddressId,
      required this.selectedAddressName,
      required this.controller,
      required this.addressList});

  @override
  Widget build(BuildContext context) {
    final addressController = AddressController.instance;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

      ],
    );
  }
}
