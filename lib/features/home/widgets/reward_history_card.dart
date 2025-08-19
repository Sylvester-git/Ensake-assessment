import 'package:ensake/features/home/model/reward.dart';
import 'package:ensake/utils/assets.dart';
import 'package:ensake/utils/color.dart';
import 'package:ensake/utils/mapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RewardHistoryCard extends StatelessWidget {
  const RewardHistoryCard({
    super.key,
    this.isloading = false,
    this.rewardModel,
  });

  final bool isloading;
  final RewardModel? rewardModel;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isloading,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.screenSize.width * .75,
              child: Row(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  isloading
                      ? Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(ImageAssets.coldstoneSmall),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      : Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.textgray2,
                            width: .5,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(SvgAssets.pointsEarned),
                        ),
                      ),
                  Column(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Points Earned",
                        style: context.textTheme.bodyMedium,
                      ),
                      SizedBox(
                        width: context.screenSize.width * .60,
                        child: Text(
                          rewardModel == null
                              ? "Received bonus points at sensible delicacy"
                              : "Received bonus points ${rewardModel!.description}",
                          maxLines: 2,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: AppColors.textgray1,
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                spacing: 5,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    rewardModel == null ? "10pts" : "${rewardModel!.point}pts",
                    style: context.textTheme.bodyMedium!.copyWith(),
                  ),
                  Text(
                    "Feb12",
                    maxLines: 1,
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.textgray1,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
