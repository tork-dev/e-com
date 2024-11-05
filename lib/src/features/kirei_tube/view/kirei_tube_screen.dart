import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/widgets/containers/card_container.dart';
import 'package:kirei/src/features/kirei_tube/controller/kirei_tube_controller.dart';
import 'package:kirei/src/features/kirei_tube/view/widgets/kirei_tube_home.dart';
import 'package:kirei/src/utils/constants/colors.dart';
import 'package:kirei/src/utils/constants/sizes.dart';

class KireiTubeScreen extends StatelessWidget {
  const KireiTubeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KireiTubeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kirei Tube',
          style: TextStyle(color: AppColors.secondary),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: AppCardContainer(
              height: 214,
              applyRadius: false,
              width: MediaQuery.of(context).size.width,
              backgroundColor: AppColors.headerBackground,
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              margin:
                  const EdgeInsets.only(bottom: AppSizes.spaceBtwSections),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Earn More as You Shop!',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: AppColors.primary),
                  ),
                  const Gap(AppSizes.sm),
                  Text(
                    'Introducing Our Exclusive Kirei Tube',
                    style: Theme.of(context).textTheme.headlineMedium!,
                    textAlign: TextAlign.center,
                  ),
                  const Gap(AppSizes.sm),
                  Text(
                    'We believe in rewarding our customers for their loyalty and engagement. With our brand-new point system, the more you shop and interact, the more benefits',
                    style: Theme.of(context).textTheme.bodySmall!,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _TabBarDelegate(
              TabBar(
                controller: controller.tabController,
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                labelStyle: Theme.of(context).textTheme.titleLarge,
                labelPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.spaceBtwDefaultItems),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                tabs: const [
                  Tab(text: 'Home'),
                  Tab(text: 'Videos'),
                  Tab(text: 'Shorts'),
                  Tab(text: 'Playlists'),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: controller.tabController,
          children: [
            const KireiTubeHome(),
            _buildTabContent('Videos'),
            _buildTabContent('Shorts'),
            _buildTabContent('Playlists'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String title) {
    return ListView.builder(
      itemCount: 20, // Adjust item count as needed
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('$title Item ${index + 1}'),
        );
      },
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
      color: Colors.white,
      child: Column(
        children: [
          tabBar,
          const Gap(AppSizes.md),
          SizedBox(
            height: 48,
            child: SearchBar(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: const MaterialStatePropertyAll(AppColors.white),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Rounded corners
                side: BorderSide(
                    color: AppColors.grey, width: 1), // Border color and width
              )),
              hintText: 'Search',
              hintStyle: MaterialStatePropertyAll(Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .apply(color: AppColors.darkGrey)),
              trailing: const [
                Icon(
                  Icons.search_sharp,
                  color: AppColors.darkGrey,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 129;

  @override
  double get minExtent => 129;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) {
    return true; // Rebuild when the tab bar changes
  }
}
