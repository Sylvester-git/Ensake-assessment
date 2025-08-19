import 'package:ensake/common/buttons.dart';
import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';

import '../../../utils/assets.dart';

class AvailableRewardCard extends StatelessWidget {
  const AvailableRewardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.bgweak,
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(ImageAssets.coldstoneSmall),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .55,
                      child: Text(
                        "Earn Points With Every Scoop At Coldstone",
                        maxLines: 2,
                        style: context.textTheme.bodyMedium!.copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: EnsakeButton(
                        title: "Claim",
                        hpadding: 5,
                        vpadding: 5,
                        onTap: () {},
                        borderColor: AppColors.primary,
                        btnColor: Colors.white,
                        titleColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.directional(
            end: context.screenSize.width * .47,
            bottom: context.screenSize.width * -.02,
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Image.asset(ImageAssets.coldstoneSmall),
            ),
          ),
        ],
      ),
    );
  }
}
