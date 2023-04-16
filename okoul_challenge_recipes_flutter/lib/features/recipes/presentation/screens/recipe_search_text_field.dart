// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/colors_manager.dart';

final userSearchInputProvider = StateProvider<String>((ref) {
  return "";
});
final userSearchFavoritesInputProvider = StateProvider<String>((ref) {
  return "";
});

final searchFieldController = TextEditingController(text: "");

class RecipesSearchTextField extends ConsumerWidget {
  const RecipesSearchTextField({
    super.key,
    required this.hintText,
    this.isFavoriteSearch = false,
  });
  final String hintText;
  final bool isFavoriteSearch;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: searchFieldController,
      cursorColor: ColorsManager.white,
      style: const TextStyle(color: ColorsManager.white),
      onChanged: (String userInput) async {
        // Not this delay because the i have only 5 request per second
        // The other option is to wait until the user finish what he want and then showing the result
        // after search the User must see some response after typing
        if (isFavoriteSearch) {
          ref
              .read(userSearchFavoritesInputProvider.notifier)
              .update((state) => userInput);
        } else {
          await Future.delayed(const Duration(milliseconds: 500));
          ref
              .read(userSearchInputProvider.notifier)
              .update((state) => userInput);
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: ref.watch(userSearchInputProvider).isEmpty
            ? null
            : IconButton(
                onPressed: () {
                  ref.invalidate(userSearchInputProvider);
                  ref.invalidate(userSearchFavoritesInputProvider);
                  searchFieldController.clear();
                },
                icon: const Icon(Icons.close),
                color: Colors.grey),
        contentPadding: const EdgeInsets.only(left: 25.0, top: 15.0),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: ColorsManager.white, width: 1),
        ),
        // Border the users does  click on the field
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(color: ColorsManager.white),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
