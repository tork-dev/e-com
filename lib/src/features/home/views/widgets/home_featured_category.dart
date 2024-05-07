import 'package:flutter/material.dart';
import 'package:torganic/src/common/widgets/containers/featured_categories.dart';


class HomeFeaturedCategories extends StatelessWidget {
  const HomeFeaturedCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return AppFeatureCategories(
        itemCount: 20,
        imgUrl: 'https://app.kireibd.com/storage/all/Skin-Care-.png',
        categoryName: 'Skin Care');
  }
}

