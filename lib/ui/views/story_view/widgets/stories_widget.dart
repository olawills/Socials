import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/exports.dart';
import '../../features/home/widgets/exports.dart';

class StoryCard extends StatelessWidget {
  final snap;
  final bool isLoading;

  const StoryCard({super.key, required this.snap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            highlightColor: lightGrey,
            baseColor: grey,
            child: Container(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: miniMediumBorderRadius,
                    child: Container(
                      height: double.infinity,
                      width: 120,
                      color: lightGrey,
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: 120,
                    decoration: BoxDecoration(
                      color: grey.withOpacity(0.1),
                      borderRadius: miniMediumBorderRadius,
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.all(8),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: miniMediumBorderRadius,
                  child: CachedNetworkImage(
                    imageUrl: snap["storyUrl"],
                    height: double.infinity,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: 120,
                  decoration: BoxDecoration(
                    color: grey.withOpacity(0.1),
                    borderRadius: miniMediumBorderRadius,
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 35,
                  child: ProfileAvatar(
                    onTap: () {},
                    displayPhoto: snap['user']['displayPhoto'],
                  ),
                ),
              ],
            ),
          );
  }
}
