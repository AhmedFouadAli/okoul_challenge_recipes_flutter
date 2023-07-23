import 'package:RecipeX/constants/app_sizes.dart';
import 'package:RecipeX/constants/app_string.dart';
import 'package:RecipeX/constants/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_router.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(AppStrings.error404NotFound,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                )),
            gapH24,
            ElevatedButton(
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all(const EdgeInsets.all(16.0)),
                  backgroundColor:
                      MaterialStateProperty.all(ColorsManager.grey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              onPressed: () {
                context.goNamed(AppRoute.recipesList.name);
              },
              child: const Text(AppStrings.buttonReturnHome,
                  style: TextStyle(
                    fontSize: 30,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
