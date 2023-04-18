// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/colors_manager.dart';
import '../controllers/recipes_controller.dart';

final userSearchInputProvider = StateProvider<String>((ref) {
  return "";
});

final searchFieldController = TextEditingController(text: "");

class RecipesSearchTextField extends ConsumerWidget {
  const RecipesSearchTextField({
    super.key,
  });

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

        if (userInput.isNotEmpty) {
          await Future.delayed(const Duration(milliseconds: 250));
        }
        ref.read(userSearchInputProvider.notifier).update((state) => userInput);
      },
      decoration: InputDecoration(
        hintText: AppStrings.hintSearch,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: ref.watch(userSearchInputProvider).isEmpty
            ? null
            : IconButton(
                onPressed: () {
                   searchFieldController.clear();
                   ref.read(asyncNotifierProvider.notifier).clearStateForSearching();
                },
                icon: const Icon(Icons.close),
                color: Colors.grey),
      ),
    );
  }
}
