import 'package:flutter/material.dart';
import 'package:social/ui/shared/exports.dart';
import 'package:social/ui/shared/widgets/shimmer_loading_effect.dart';
import 'package:social/ui/views/features/home/widgets/exports.dart';

class PostCardWidget extends StatelessWidget {
  final snap;
  final Function() onTap;
  final bool isLoading;
  const PostCardWidget({
    super.key,
    required this.snap,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const ShimmerLoadingEffect()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: ProfileAvatar(
                  onTap: onTap,
                  isMessageAvatar: true,
                  displayPhoto: snap['displayPhoto'],
                ),
                title: CustomText(
                  message: snap['username'],
                  style: bodySemiBold,
                ),
                subtitle: CustomText(
                  message: "12",
                  style: bodySemiBold,
                ),
                trailing: SvgPicture.asset(
                  'assets/icons/Dots Vertical.svg',
                  height: 25,
                  // ignore: deprecated_member_use
                  color: lightGrey,
                ),
              ),
              // verticalSpaceMicroSmall,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: double.maxFinite,
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: snap['postUrl'],
                      ),
                    ),
                    verticalSpaceMicroSmall,
                    snap['postDescription'] != null
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomText(
                              overflow: TextOverflow.fade,
                              message: "${snap['postDescription']}",
                              style: titleTextSemiBold.copyWith(
                                color: kWhiteColor,
                              ),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
              verticalSpaceMicroSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListTile(
                      title: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/icons/Like.svg',
                              height: 18,
                              // ignore: deprecated_member_use
                              color: lightGrey,
                            ),
                          ),
                          horizontalSpaceTiy,
                          CustomText(
                            message: "${snap['likes']}",
                            style: secondaryTextBold,
                          ),
                          horizontalSpaceSmall,
                          InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/icons/Comment.svg',
                              height: 18,
                              // ignore: deprecated_member_use
                              color: lightGrey,
                            ),
                          ),
                          horizontalSpaceTiy,
                          CustomText(
                            message: "${snap['comments']}",
                            style: secondaryTextBold,
                          ),
                          horizontalSpaceSmall,
                          InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/icons/Share.svg',
                              height: 18,
                              // ignore: deprecated_member_use
                              color: lightGrey,
                            ),
                          ),
                          horizontalSpaceSmall,
                          CustomText(
                            message: "${snap['shares']}",
                            style: secondaryTextBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/Bookmark.svg',
                    height: 20,
                    // ignore: deprecated_member_use
                    color: lightGrey,
                  ),
                ],
              ),
            ],
          );
  }
}
