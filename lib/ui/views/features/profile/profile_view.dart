import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/providers/user_provider.dart';
import 'package:social/ui/shared/constants/constants.dart';
import 'package:social/ui/shared/exports.dart';
import 'package:social/ui/shared/widgets/circle_avatar.dart';
import 'package:social/ui/shared/widgets/email_avatar.dart';

import '../../../../core/models/exports.dart';
import '../home/widgets/exports.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this);
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: user.displayPhoto ?? postUrl,
                ),
              ),
            ),
            const Positioned(
              right: 10,
              top: 50,
              child: EmailMessageAvatar(),
            ),
            Positioned(
              right: 10,
              top: 100,
              child: CircleAvatarWidget(
                onTap: () {},
                image: 'assets/icons/Bookmark.svg',
              ),
            ),
            Positioned(
              top: 150,
              left: 100,
              right: 0,
              bottom: 0,
              child: ProfileAvatar(
                onTap: () {},
                isProfileView: true,
                displayPhoto: user.displayPhoto ?? postUrl,
              ),
            ),
            Positioned(
              top: 310,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          message: "${user.firstName} ${user.lastName}",
                          style: titleTextBold,
                        ),
                        verticalSpaceMicroSmall,
                        CustomText(
                          message: 'Broklyn, NY',
                          style: bodySemiBold.copyWith(color: lightGrey),
                        ),
                        verticalSpaceMicroSmall,
                        CustomText(
                          message: 'Write by Profession, Artist by Passion!',
                          style: bodySemiBold,
                        ),
                        verticalMicroSmall,
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  CustomText(
                                    message: "${user.followers.length}",
                                    style: bodySemiBold,
                                  ),
                                  CustomText(
                                    message: 'Followers',
                                    style:
                                        bodySemiBold.copyWith(color: lightGrey),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  CustomText(
                                    message: "${user.following.length}",
                                    style: bodySemiBold,
                                  ),
                                  CustomText(
                                    message: 'Following',
                                    style:
                                        bodySemiBold.copyWith(color: lightGrey),
                                  ),
                                ],
                              ),
                              Container(
                                width: 120,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: AppColors.darkBlack,
                                  border: Border.all(
                                    color: kWhiteColor,
                                    width: 1.3,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: CustomText(
                                  message: 'Edit Profile',
                                  style: bodySemiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceMicro,
                    _PostsAndStoriesWidget(
                      tabController: tabController,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostsAndStoriesWidget extends StatelessWidget {
  final TabController tabController;
  const _PostsAndStoriesWidget({required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              labelPadding: const EdgeInsets.only(left: 25, right: 25),
              controller: tabController,
              labelColor: kWhiteColor,
              unselectedLabelColor: Colors.grey,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              // indicatorPadding: const EdgeInsets.only(top: 20),
              // dividerColor: lightGrey,
              indicator: TabIndicatorWidget(
                color: AppColors.socialBlue,
                radius: 2,
              ),
              tabs: [
                CustomText(
                  message: 'Posts',
                  style: bodySemiBold,
                ),
                CustomText(
                  message: 'Stories',
                  style: bodySemiBold,
                ),
                CustomText(
                  message: 'Liked',
                  style: bodySemiBold,
                ),
                CustomText(
                  message: 'Tagged',
                  style: bodySemiBold,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 8),
          height: 300,
          width: double.maxFinite,
          child: TabBarView(
            controller: tabController,
            children: [
              Container(
                // height: MediaQuery.of(context).size.height,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.separated(
                            shrinkWrap: true,
                            itemCount: 2,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (_, index) {
                              return Divider(color: lightGrey, thickness: 1.1);
                            },
                            itemBuilder: (_, index) {
                              return PostCardWidget(
                                  snap: const [],
                                  onTap: () {},
                                  isLoading: true);
                            });
                      }
                      // else if(snapshot.data.)
                      return ListView.separated(
                          itemCount: snapshot.data!.docs.length,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          separatorBuilder: (_, index) {
                            return Divider(color: lightGrey, thickness: 1.1);
                          },
                          itemBuilder: (_, index) {
                            return PostCardWidget(
                                snap: snapshot.data!.docs[index].data(),
                                onTap: () {});
                          });
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('stories')
                        .snapshots(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () =>
                                NavigationData.pushToStoryView(context),
                            child: StoryCard(
                              snap: snapshot.data!.docs[index].data(),
                            ),
                          );
                        },
                      );
                    }),
              ),
              const Tab(text: "Emotions"),
              const Tab(text: "Emotions"),
            ],
          ),
        ),
      ],
    );
  }
}
