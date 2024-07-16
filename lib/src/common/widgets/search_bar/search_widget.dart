import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:kirei/src/features/details/view/details.dart';
import 'package:kirei/src/features/home/repositories/search_repositories.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/helpers/helper_functions.dart';
import '../containers/card_container.dart';
import '../../../utils/constants/colors.dart';

class AppSearchWidget extends StatelessWidget {
  final Widget Function(BuildContext context, TextEditingController controller,
      FocusNode focusNode) builder;

  const AppSearchWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.put(SearchController());
    return TypeAheadField(
        direction: VerticalDirection.down,
        itemBuilder: (context, dataItem) {
          return dataItem.name == null
              ? const AppCardContainer(
                  height: 50,
                  child: Center(
                    child: Text('No item found'),
                  ))
              : ListTile(
                  onTap: () {
                    Get.to(() => DetailsPage(
                        productSlug: dataItem.slug ?? '',));
                  },
                  contentPadding: const EdgeInsets.all(AppSizes.sm),
                  dense: true,
                  leading: SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.network(
                      dataItem.pictures?[0].url ?? '',
                      // Replace with the actual URL of your image
                      // width: 40, // Adjust the width as needed
                      // height: 40, // Adjust the height as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: dataItem.name,
                          style: const TextStyle(color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: dataItem.salePrice != dataItem.price
                              ? "৳${dataItem.price.toString()}"
                              : '',
                          style: TextStyle(
                            color: AppColors.darkGrey,
                            decoration: dataItem.salePrice != dataItem.price
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        TextSpan(
                          text: dataItem.salePrice != dataItem.price
                              ? ' ৳${dataItem.salePrice.toString()}'
                              : "৳${dataItem.price}",
                          style: const TextStyle(color: AppColors.secondary),
                        ),
                      ],
                    ),
                  ),
                );
        },
        onSelected: (value) async {},
        suggestionsCallback: (value) async {
          if (value != '') {
            var suggestions =
                await SearchRepositories().getSearchResponse(value);
            return suggestions.products;
          }
          return null;
        },
        loadingBuilder: (context) {
          return const AppCardContainer(
              height: 50,
              child: Center(
                child: Text('Loading...'),
              ));
        },
        builder: builder,

        );
  }
}
