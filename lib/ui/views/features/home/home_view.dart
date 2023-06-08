import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/app/logger.dart';
import 'package:social/core/models/user_model.dart';
import 'package:social/ui/shared/widgets/email_avatar.dart';

import '../../../../core/providers/user_provider.dart';
import '../../../shared/exports.dart';
import 'widgets/exports.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timer) {
      Provider.of<UserProvider>(context, listen: false).refreshUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Home view');
    UserModel user = Provider.of<UserProvider>(context, listen: false).getUser;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      message: 'Good Morning, ${user.firstName}',
                      style: titleTextBold.copyWith(fontSize: 22),
                    ),
                    const EmailMessageAvatar(),
                  ],
                ),
                verticalMicroMiniSmall,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('stories')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (_, index) {
                              // final StoryDataModel story = stories[index];
                              return StoryCard(
                                snap: snapshot.data?.docs[index].data(),
                                isLoading: true,
                              );
                            },
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (_, index) {
                            // final StoryDataModel story = stories[index];
                            return InkWell(
                              onTap: () =>
                                  NavigationData.pushToStoryView(context),
                              child: StoryCard(
                                snap: snapshot.data?.docs[index].data(),
                              ),
                            );
                          },
                        );
                      }),
                ),
                // verticalMicroMiniSmall,
                Divider(color: lightGrey, thickness: 1.1),
                StreamBuilder(
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
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, index) {
                            return Divider(color: lightGrey, thickness: 1.1);
                          },
                          itemBuilder: (_, index) {
                            return PostCardWidget(
                                snap: snapshot.data!.docs[index].data(),
                                onTap: () {});
                          });
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
