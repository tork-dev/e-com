import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:torganic/src/features/home/controller/home_controller.dart';

import '../../../../utils/constants/colors.dart';

class AppHomeSearchBox extends StatelessWidget {
  const AppHomeSearchBox({super.key});


  @override
  Widget build(BuildContext context) {
    final searchController = HomeController.instance;
    // return TypeAheadField(
    //   // ignore: missing_return
    //   suggestionsCallback: (pattern) async {
    //     // if (pattern != "") {
    //     //   //var suggestions = await SearchRepository().getSearchSuggestionListResponse(
    //     //    // query_key: pattern,
    //     //  // );
    //     //
    //     //   //return suggestions.products;
    //     //   print('suggestion');
    //     // }
    //     print(pattern);
    //   },
    //   loadingBuilder: (context) {
    //     return const SizedBox(
    //       height: 50,
    //       child: Center(
    //         child: Text(
    //           'Loading suggestions...',
    //           style: TextStyle(
    //             color: AppColors.darkGrey,
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    //   itemBuilder: (context, suggestion) {
    //     return Visibility(
    //       visible: searchController.searchController.text != "",
    //       child: ListTile(
    //         onTap: () {
    //           // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //           //   return ProductDetails(
    //           //     id: suggestion.id,
    //           //     stock: suggestion.stock,
    //           //   );
    //           // })).then((value) {
    //           //   onPopped(value);
    //           // });
    //         },
    //         contentPadding: EdgeInsets.only(top: 5),
    //         dense: true,
    //         leading: Image.network(
    //           'https://app.kireibd.com/storage/all/Skin-Care-.png',
    //           width: 40,
    //           height: 40,
    //           fit: BoxFit.cover,
    //         ),
    //         title: RichText(
    //           text: TextSpan(
    //             children: [
    //               TextSpan(
    //                 //text: suggestion.name,
    //                 style: const TextStyle(color: AppColors.secondary),
    //               ),
    //             ],
    //           ),
    //         ),
    //         subtitle: RichText(
    //           text: TextSpan(
    //             children: [
    //               TextSpan(
    //                 text: suggestion.sale_price != suggestion.price ? "৳" + suggestion.price.toString() : '',
    //                 style: TextStyle(
    //                   color: MyTheme.dark_grey,
    //                   decoration: suggestion.sale_price != suggestion.price ? TextDecoration.lineThrough : TextDecoration.none,
    //                 ),
    //               ),
    //               TextSpan(
    //                 text: suggestion.sale_price != suggestion.price ? ' ৳${suggestion.sale_price.toString()}' : "৳" + suggestion.price.toString(),
    //                 style: TextStyle(color: MyTheme.dark_grey),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    //   // noItemsFoundBuilder: (context) {
    //   //   return SizedBox(
    //   //     height: 50,
    //   //     child: Center(
    //   //       child: Text(
    //   //         AppLocalizations.of(context).filter_screen_no_suggestion_available,
    //   //         style: TextStyle(color: MyTheme.dark_grey),
    //   //       ),
    //   //     ),
    //   //   );
    //   // },
    //   onSelected: (suggestion) {
    //     //searchController.searchController.text = suggestion.name;
    //     //searchController.setSearchKey(suggestion.name);
    //   },
    //   textFieldConfiguration: TextFieldConfiguration(
    //     onTap: () {},
    //     controller: searchController.searchController,
    //     onSubmitted: (txt) {
    //       searchController.setSearchKey(txt);
    //       print('navigating to filter');
    //      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Main(pageIndex: 1,)));
    //     },
    //     style: TextStyle(color: AppColors.secondary),
    //     autofocus: false,
    //     cursorColor: AppColors.secondary,
    //     decoration: InputDecoration(
    //       prefixIcon: Icon(
    //         Icons.search,
    //         color: AppColors.secondary,
    //       ),
    //       hintText: 'AppLocalizations.of(context).filter_screen_search_her'e,
    //       border: InputBorder.none,
    //       hintStyle: TextStyle(fontSize: 14.0, color: AppColors.secondary),
    //       alignLabelWithHint: true,
    //       contentPadding: EdgeInsets.only(left: 30, top: 10),
    //     ),
    //   ),
    //   // onSelected: (Object? value) {
    //   //   print(value);
    //   // },
    // );

    return TypeAheadField(
      suggestionsCallback: (search) {print('value');},
      // suggestionsCallback: (search) => CityService.of(context).find(search),
      builder: (context, controller, focusNode) {
        return SizedBox(
          height: 50,
          child: TextFormField(
              controller: controller,
              focusNode: focusNode,
              //autofocus: true,
              decoration:  InputDecoration(
                //icon: Icons.search,
                fillColor: AppColors.grey,
                filled: true,
                focusColor: AppColors.grey,
                prefixIcon: const Icon(Icons.search, color: AppColors.secondary,),
                hintText: 'Search with AI (EX: Facewash for acne)',
                hintStyle: Theme.of(context).textTheme.bodySmall,
                focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.grey), borderRadius: BorderRadius.circular(10)),
                border: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.grey, width: 0,), borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppColors.grey, width: 0,), borderRadius: BorderRadius.circular(10))
              )
          ),
        );
      },
    itemBuilder: (context, suggestion) {
        return Visibility(
         // visible: searchController.searchController.text != "",
          child: ListTile(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return ProductDetails(
              //     id: suggestion.id,
              //     stock: suggestion.stock,
              //   );
              // })).then((value) {
              //   onPopped(value);
              // });
            },
            contentPadding: const EdgeInsets.only(top: 5),
            dense: true,
            leading: Image.network(
              'https://app.kireibd.com/storage/all/Skin-Care-.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
            title: RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    //text: suggestion.name,
                    style: TextStyle(color: AppColors.secondary),
                  ),
                ],
              ),
            ),
            subtitle: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "suggestion.sale_price != suggestion.price ? ৳$suggestion.price.toString() : ''",
                    style: const TextStyle(
                      color: AppColors.darkGrey,
                      //decoration: suggestion.sale_price != suggestion.price ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                  const TextSpan(
                    //text: suggestion.sale_price != suggestion.price ? ' ৳${suggestion.sale_price.toString()}' : "৳" + suggestion.price.toString(),
                    text: 'Price',
                    style: TextStyle(color: AppColors.darkGrey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      onSelected: (city) {
        // Navigator.of(context).push<void>(
        //   MaterialPageRoute(
        //     builder: (context) => CityPage(city: city),
        //   ),
        // );
      },
    );
  }
}

