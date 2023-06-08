import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social/ui/shared/exports.dart';

class ShimmerLoadingEffect extends StatelessWidget {
  const ShimmerLoadingEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: lightGrey,
      baseColor: grey,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.lightWhite,
              ),
              title: Container(
                height: 20,
                width: 100,
                color: AppColors.lightWhite,
              ),
              subtitle: Container(
                height: 20,
                width: 40,
                color: AppColors.lightWhite,
              ),
            ),
            verticalSpaceMicroSmall,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    color: lightGrey,
                  ),
                ),
              ),
            ),
            verticalSpaceMicroSmall,
            Expanded(
              child: Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: lightGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
