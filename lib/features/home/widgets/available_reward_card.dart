import 'package:ensake/common/buttons.dart';
import 'package:ensake/features/home/model/reward.dart';
import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../common/dialog.dart';
import '../../../utils/assets.dart';

class AvailableRewardCard extends StatelessWidget {
  const AvailableRewardCard({
    super.key,
    this.rewardModel,
    this.isloading = false,
    this.skelentinized = false,
    this.onTap,
    required this.customerpoints,
  });

  final RewardModel? rewardModel;
  final bool skelentinized;
  final int customerpoints;
  final bool isloading;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: skelentinized,
      child: Container(
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
                        image:
                            rewardModel?.brandModel.logo == null
                                ? AssetImage(ImageAssets.coldstoneSmall)
                                : NetworkImage(rewardModel!.brandModel.logo),
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
                          rewardModel?.description ??
                              "Earn Points With Every Scoop At Coldstone",
                          maxLines: 2,
                          style: context.textTheme.bodyMedium!.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      skelentinized
                          ? 0.height
                          : SizedBox(
                            width: 100,
                            child: EnsakeButton(
                              title: "Claim",
                              hpadding: 5,
                              vpadding: 5,
                              loading: isloading,
                              onTap:
                                  customerpoints < (rewardModel?.point ?? 0)
                                      ? () {
                                        ShowDialog.showCustomCalimDialog(
                                          context: context,
                                          title: "Failed",
                                          message: "Insufficient points",
                                          iserror: true,
                                        );
                                      }
                                      : onTap,
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
            skelentinized
                ? 0.height
                : Positioned.directional(
                  end: context.screenSize.width * .65,
                  top: context.screenSize.width * -.2,
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * .3,

                    height: MediaQuery.sizeOf(context).width * .4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(rewardModel!.brandModel.logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

            // Padding(
            //     padding: const EdgeInsets.only(bottom: 40),
            //     child:
            //         rewardModel?.brandModel.logo == null
            //             ? Image.asset(ImageAssets.coldstoneSmall)
            //             : Image.network(rewardModel!.brandModel.logo),
            //   ),
          ],
        ),
      ),
    );
  }
}
