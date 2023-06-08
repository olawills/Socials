import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social/app/logger.dart';
import 'package:social/ui/shared/constants/constants.dart';
import 'package:social/ui/shared/exports.dart';

import '../home/widgets/exports.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController searchController = TextEditingController();
  final bool isFirst = false;
  var searchesType = PopularSearches.all;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Search view');
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  hasRoundedRadius: true,
                  changeFilledColor: true,
                  fllColor: grey,
                  radius: largeBorderRadius,
                  controller: searchController,
                  textInputType: TextInputType.text,
                  hintText: 'Search for people, posts, tags...',
                  suffixIcon: Icon(Icons.search, color: lightGrey),
                ),
                verticalMicroMiniSmall,
                CustomText(
                  message: 'Popular',
                  style: titleTextBold,
                ),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularSearches.length,
                    itemBuilder: (context, index) {
                      final name = popularSearches[index];
                      final isFirstContainer = index == 0;
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: MediaQuery.of(context).size.width * 0.08,
                        margin: const EdgeInsets.all(12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isFirstContainer
                              ? AppColors.socialBlue
                              : AppColors.darkBlack,
                          border: Border.all(
                            color: lightGrey,
                          ),
                          borderRadius: miniMediumBorderRadius,
                        ),
                        child: CustomText(
                          message: name,
                          style: secondaryTextBold,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  // height: MediaQuery.of(context).size.height,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.separated(
                              shrinkWrap: true,
                              itemCount: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, index) {
                                return Divider(
                                    color: lightGrey, thickness: 1.1);
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
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
