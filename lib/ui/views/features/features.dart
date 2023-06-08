import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social/core/providers/features_provider.dart';
import 'package:social/ui/shared/constants/colors.dart';
import 'package:social/ui/views/features/create_post/widget/create_post_start.dart';

import 'exports.dart';

class Features extends StatefulWidget {
  const Features({super.key});

  @override
  State<Features> createState() => _FeaturesState();
}

class _FeaturesState extends State<Features> {
  late ScrollController scrollController;
  double height = 80;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
          // User is scrolling down
          height = 0;
        } else if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          // User is scrolling up
          height = 70;
        }
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    // final model = Provider.of<FeaturesProvider>(context, listen: false);
    return Consumer<FeaturesProvider>(builder: (context, model, child) {
      return Scaffold(
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 300),
          reverse: model.reverse,
          transitionBuilder: (child, animation, secondaryAnimation) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              child: child,
            );
          },
          child: getViewForIndex(model.currentIndex),
        ),
        bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: 70,
            child: BottomNavigationBar(
              backgroundColor: kDarkColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: model.currentIndex,
              onTap: (value) {
                model.setIndex(value);
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/Feed.svg',
                    // ignore: deprecated_member_use
                    color: model.currentIndex == 0 ? kWhiteColor : lightGrey,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/Search.svg',
                    // ignore: deprecated_member_use
                    color: model.currentIndex == 1 ? kWhiteColor : lightGrey,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                    icon: CircleAvatar(
                      backgroundColor: AppColors.socialPink,
                      child: SvgPicture.asset(
                        'assets/icons/Plus.svg',
                        // ignore: deprecated_member_use
                        color:
                            model.currentIndex == 2 ? kWhiteColor : lightGrey,
                      ),
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/icons/Alert.svg',
                      // ignore: deprecated_member_use
                      color: model.currentIndex == 3 ? kWhiteColor : lightGrey,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/Profile.svg',
                    // ignore: deprecated_member_use
                    color: model.currentIndex == 4 ? kWhiteColor : lightGrey,
                  ),
                  label: '',
                ),
              ],
            )),
      );
    });
  }
}

List<Widget> getView = [
  const HomeView(),
  const SearchView(),
  const CreatePost(),
  const NotificationView(),
  const ProfileView()
];

Widget getViewForIndex(int index) {
  switch (index) {
    case 0:
      return const HomeView();
    case 1:
      return const SearchView();
    case 2:
      return const CreatePostStart();
    case 3:
      return const NotificationView();
    case 4:
      return const ProfileView();
    default:
      return const HomeView();
  }
}
