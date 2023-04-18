// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/app_string.dart';
import '../../../../constants/colors_manager.dart';

class ErrorRecipeList extends ConsumerWidget {
  const ErrorRecipeList({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.onPressed,
  });
  final bool isLoading;
  final String errorMessage;
  final Function onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppStrings.wrongMessage,
            style: TextStyle(fontSize: 20, color: ColorsManager.white),
          ),
          Text(
            "$errorMessage\n",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, color: ColorsManager.white),
          ),
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(ColorsManager.black),
                foregroundColor: MaterialStateProperty.all(ColorsManager.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
              ),
              onPressed: isLoading
                  ? null
                  :()=>onPressed() ,
              child: isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    )
                  : const Text(
                      AppStrings.tryAgain,
                      style: TextStyle(color: ColorsManager.white),
                    ))
        ],
      ),
    );
  }
}
