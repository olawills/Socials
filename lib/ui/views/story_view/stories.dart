import 'package:flutter/material.dart';
import 'package:social/app/logger.dart';
import 'package:social/core/firebase/firebase_story_method.dart';
import 'package:social/core/models/exports.dart';
import 'package:social/ui/shared/exports.dart';

import '../features/home/widgets/exports.dart';
import 'widgets/story_image_widget.dart';
import 'widgets/story_lines.dart';

class Stories extends StatefulWidget {
  final StoryModel story;
  final Function() onCompleted;
  const Stories({super.key, required this.story, required this.onCompleted});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories>
    with TickerProviderStateMixin<Stories> {
  final TextEditingController messageController = TextEditingController();
  late AnimationController controller;
  List<StorylineWidget> storyLines = [];
  int current = 0;
  bool isLoaded = true;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    controller.forward(from: 0.0);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (current == widget.story.storyUrl.length - 1) {
          widget.onCompleted();
          return;
        }
        if (current < widget.story.storyUrl.length - 1) {
          current++;
          if (isLoaded) controller.forward(from: 0.0);
        }
        buildStoryLines();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      buildStoryLines();
    });
  }

  void buildStoryLines() {
    storyLines.clear();
    for (int i = 0; i < widget.story.storyUrl.length; i++) {
      storyLines.add(StorylineWidget(
        controller: controller,
        completed: i < current,
      ));
    }
    setState(() {});
    if (current == widget.story.storyUrl.length - 1) {
      FirebaseStoryMethod.updateStory(widget.story, true);
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  double lastValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: () {
          lastValue = controller.value;
          controller.stop(canceled: false);
        },
        onLongPressEnd: (val) {
          controller.forward(from: lastValue);
          lastValue = 0.0;
        },
        child: Stack(
          children: [
            StoryImageWidget(
              // onLoaded: () {
              //   // this.isLoaded = val;
              //   if (val) {
              //     controller.forward(from: 0.0);
              //   } else {
              //     controller.value = 0.0;
              //   }
              // },
              image: widget.story.storyUrl[current],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      height: MediaQuery.of(context).size.height,
                    ),
                    onTap: () {
                      jumpToPrevious();
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      jumpToNext();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: storyLines
                              .map((child) => Expanded(
                                    child: child,
                                  ))
                              .toList(),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ListTile(
                            leading: ProfileAvatar(
                              onTap: () {},
                              isMessageAvatar: false,
                              displayPhoto: widget.story.user.displayPhoto!,
                            ),
                            title: CustomText(
                              message:
                                  "${widget.story.user.firstName} ${widget.story.user.lastName}",
                              style: titleTextBold,
                            ),
                            subtitle: CustomText(
                              message: widget.story.timeOfPost
                                  .toString()
                                  .split(" ")[0],
                              style: bodyTextMedium,
                            ),
                          )),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7.6,
                          decoration: BoxDecoration(
                            color: AppColors.darkBlack.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: ChatFormField(
                              messageController: messageController),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void jumpToPrevious() {
    if (current > 0) {
      logger.d("Prev");
      current--;
      buildStoryLines();
    }
  }

  void jumpToNext() {
    logger.d("Next");
    controller.value = 1.0;
  }
}
