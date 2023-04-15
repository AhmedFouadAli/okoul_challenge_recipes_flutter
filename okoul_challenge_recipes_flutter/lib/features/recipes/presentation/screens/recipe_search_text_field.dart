import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/colors_manager.dart';

final userSearchInputProvider = StateProvider<String>((ref) {
  return "";
});

final searchFieldController = TextEditingController(text: "");

class RecipesSearchTextField extends ConsumerWidget {
  const RecipesSearchTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: searchFieldController,
      cursorColor: ColorsManager.white,
      style: const TextStyle(color: ColorsManager.white),
      onChanged: (String userInput) => ref
          .read(userSearchInputProvider.notifier)
          .update((state) => userInput),
      decoration: InputDecoration(
        hintText: 'Search for recipes',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        suffixIcon: ref.watch(userSearchInputProvider).isEmpty
            ? null
            : IconButton(
                onPressed: () {
                  ref.invalidate(userSearchInputProvider);
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
