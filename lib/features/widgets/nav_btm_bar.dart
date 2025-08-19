import 'package:ensake/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../model/btm_nav_bar_item.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
  });

  final List<BtmNavBarItem> items;
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
                    SvgPicture.asset(items[index].svgIcon),
                    const SizedBox(height: 4),
                    Text(
                      items[index].name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 10,
                        color: AppColors.primary,
                      ),
                    ),
                  ] else ...[
                    SvgPicture.asset(items[index].svgIcon),
                    const SizedBox(height: 4),
                    Text(
                      items[index].name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.textgray2,
                        fontSize: 10,
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
