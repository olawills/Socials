import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/app/logger.dart';
import 'package:social/core/providers/create_post_provider.dart';
import 'package:social/ui/shared/exports.dart';
import 'package:social/ui/views/features/create_post/create_story_post.dart';
import 'package:social/ui/views/features/create_post/widget/animated_text_container.dart';

import 'widget/create_post_view.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final PageController _pageController = PageController();

  bool isClicked = false;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Create post view');
    return Scaffold(
      body: Consumer<CreatePostProvider>(builder: (context, create, _) {
        return Stack(
          children: [
            PageView(
              controller: _pageController,
              physics: const AlwaysScrollableScrollPhysics(),
              onPageChanged: (page) {
                create.isLastPage = page == 1;
              },
              children: const [
                CreatePostView(),
                CreateStoryPost(),
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 35,
                  width: 150,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: lightGrey),
                    borderRadius: miniMediumBorderRadius,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedTextContainer(
                        text: 'POST',
                        backgroundColor: create.isLastPage
                            ? Colors.transparent
                            : AppColors.socialPink,
                        onTap: () {
                          create.isLastPage ? _pageController.jumpTo(0) : null;
                        },
                      ),
                      AnimatedTextContainer(
                        text: 'STORY',
                        backgroundColor: create.isLastPage
                            ? AppColors.socialPink
                            : Colors.transparent,
                        onTap: () {
                          create.isLastPage
                              ? null
                              : _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
