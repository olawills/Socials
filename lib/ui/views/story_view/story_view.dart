import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social/app/logger.dart';
import 'package:social/core/models/exports.dart';
import 'package:social/ui/shared/exports.dart';

import 'stories.dart';

class StoryView extends StatefulWidget {
  final List<StoryModel> stories;
  final int initialPage;
  const StoryView({super.key, required this.stories, this.initialPage = 0});

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(
      initialPage: widget.initialPage,
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.i('StoryView');
    return WillPopScope(
      onWillPop: () async {
        NavigationData.pushBack(context);
        return widget.stories.isEmpty;
      },
      child: Scaffold(
          body: PageView.builder(
        controller: controller,
        itemCount: widget.stories.length,
        onPageChanged: (index) {},
        itemBuilder: (context, index) {
          return Stories(
            onCompleted: () {
              if (index == widget.stories.length - 1) {
                Navigator.of(context).popUntil(ModalRoute.withName('/home'));
              }
              logger.d("Next Page");
              controller.animateToPage(index + 1,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInCubic);
            },
            story: widget.stories[index],
          );
        },
      )),
    );
  }
}
