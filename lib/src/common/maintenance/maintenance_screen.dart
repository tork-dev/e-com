import 'package:flutter/material.dart';
import 'package:kirei/src/common/widgets/containers/banner_image.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppBannerImage(
          imgUrl: "assets/images/background/maintenance_background.png",
        ),
      ),
    );
  }
}
