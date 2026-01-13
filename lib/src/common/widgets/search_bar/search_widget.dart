import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:kirei/src/common/styles/skeleton_style.dart';
import 'package:kirei/src/features/home/repositories/search_repositories.dart';
import 'package:kirei/src/utils/constants/sizes.dart';
import 'package:kirei/src/utils/firebase/gtm_events.dart';
import '../../../features/home/model/search_model.dart';
import '../../../utils/constants/image_strings.dart';
import '../containers/card_container.dart';
import '../../../utils/constants/colors.dart';

class AppSearchWidget extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    TextEditingController controller,
    FocusNode focusNode,
  )
  builder;
  final String prevRoute;

  const AppSearchWidget({
    super.key,
    required this.builder,
    required this.prevRoute,
  });

  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    return TypeAheadField(
      direction: VerticalDirection.down,
      itemBuilder: (context, dataItem) {
        return dataItem.name == null
            ? const AppCardContainer(
                height: 50,
                child: Center(child: Text('No item found')),
              )
            : ListTile(
                onTap: () {
                  Get.toNamed(
                    '/product/${dataItem.slug ?? ''}',
                    parameters: {'prevRoute': prevRoute},
                  );
                  EventLogger().logProductDetailsViewEvent(
                    '${dataItem.slug}',
                    dataItem.salePrice! as double,
                  );
                },
                contentPadding: const EdgeInsets.all(AppSizes.sm),
                dense: true,
                leading: SizedBox(
                  height: 40,
                  width: 40,
                  child: CachedNetworkImage(
                    imageUrl: dataItem.pictures?[0].url ?? '',
                    fit: BoxFit.cover,
                    placeholder: (_, _) => ShimmerHelper().buildBasicShimmer(),
                    errorWidget: (_, _, _) =>
                        Image.asset(AppImages.placeholder),
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
        if (debounce?.isActive ?? false) debounce?.cancel();

        final completer = Completer<List<Product>?>();

        if (value != '') {
          debounce = Timer(Duration(milliseconds: 400), () async {
            var suggestions = await SearchRepositories().getSearchResponse(
              value,
            );
            completer.complete(suggestions.products);
          });
        } else {
          completer.complete(null);
        }

        return completer.future;
      },
      loadingBuilder: (context) {
        return const AppCardContainer(
          height: 50,
          applyRadius: false,
          child: Center(child: Text('Loading...')),
        );
      },
      builder: builder,
      errorBuilder: (context, data) {
        return const AppCardContainer(
          height: 50,
          applyRadius: false,
          child: Center(child: Text('Something went wrong')),
        );
      },
    );
  }
}
