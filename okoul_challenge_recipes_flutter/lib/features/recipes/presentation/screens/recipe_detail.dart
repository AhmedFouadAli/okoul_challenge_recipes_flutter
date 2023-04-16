// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:RecipeX/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../constants/colors_manager.dart';

class RecipeDetail extends ConsumerWidget {
  const RecipeDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverAppBar(
              expandedHeight: 300,
            ),
            floating: true,
            pinned: true,
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Text(
                'Ingredients',
                style: TextStyle(
                  fontSize: 20,
                  color: ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return BuildCheckList(title: "asdasd", quantity: "1 cup");
              },
              childCount: 5,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Instructions',
                style: TextStyle(
                  fontSize: 20,
                  color: ColorsManager.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(bottom: 30),
                          decoration: BoxDecoration(
                            color: ColorsManager.black,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: ColorsManager.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        gapW12,
                        const Expanded(
                          child: Text(
                            'Preheat the oven to 375°sssssssssssssssssssssssssssssssssssssssssssssssssssssssF.',
                            style: TextStyle(
                              fontSize: 15,
                              color: ColorsManager.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildCheckList extends ConsumerWidget {
  BuildCheckList({
    Key? key,
    required this.title,
    required this.quantity,
  }) : super(key: key);
  final String title;
  final String quantity;
  final isCheckedProvider = StateProvider<bool>((ref) {
    return false;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(isCheckedProvider);
    return SizedBox(
      height: 35,
      child: CheckboxListTile(
        dense: true,
        checkColor: ColorsManager.white,
        activeColor: ColorsManager.backGroundApp,

        checkboxShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        value: isChecked,
        onChanged: (bool? value) {
          ref.read(isCheckedProvider.notifier).update((state) => value!);
        }, // the callback when the checkbox is changed
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                decorationColor: ColorsManager.black,
                decorationThickness: 2,
                decoration: isChecked
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 15,
                color: ColorsManager.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Text(
              '1 cup',
              style: TextStyle(
                fontSize: 13,
                color: ColorsManager.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            gapW16
          ],
        ),

        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}

class BuildReusableIcon extends StatelessWidget {
  const BuildReusableIcon({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: ColorsManager.backGroundApp.withAlpha(100),
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: ColorsManager.white,
          )),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Hero(
          tag: 400,
          child: Image.network(
            'https://source.unsplash.com/random',
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 33,
          left: 16,
          child: BuildReusableIcon(
            icon: Icons.arrow_back_ios_new,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Positioned(
          top: 33,
          right: 16,
          child: BuildReusableIcon(
            icon: Icons.favorite_border_outlined,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const Positioned(
            bottom: 50,
            left: 23,
            child: Text(
              "Chocolate Chip Cookies",
              style: TextStyle(
                color: ColorsManager.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )),
        Positioned(
          bottom: 15,
          left: 23,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorsManager.white,
              ),
              child: const Text('⭐ ${4.8}', style: TextStyle(fontSize: 15))),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 175;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
