import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
  });

  final List<BottomNavigationBarItem> items;
  final int? currentIndex;
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(items.length, (index) {
            return GestureDetector(
              onTap: () {
                onTap?.call(index);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (currentIndex == index) ...[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        // color: Theme.of(
                        //   context,
                        // ).colorScheme.onPrimary.withOpacity(.5),
                      ),
                      child: Center(child: items[index].activeIcon),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index].label ?? "",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ] else ...[
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Colors.transparent,
                      ),
                      child: Center(child: items[index].icon),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      items[index].label ?? "",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimary.withOpacity(.6),
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
