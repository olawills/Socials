import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class StoryImageWidget extends StatelessWidget {
  final String image;
  // final Function() onLoaded;
  const StoryImageWidget({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    DefaultCacheManager cacheManager = DefaultCacheManager();
    cacheManager.emptyCache();
    return Container(
      color: Colors.redAccent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Image.network(
            image,
            fit: BoxFit.fill,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 75.0,
              sigmaY: 75.0,
            ),
            child: Container(
                decoration:
                    BoxDecoration(color: Colors.white.withOpacity(0.5))),
          ),
          CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 250),
            fadeInCurve: Curves.easeIn,
            cacheManager: cacheManager,
            // placeholder: (context, path) => LoadingWidget(onDisposed: () {
            //   print("Loaded $image");
            //   onLoaded(true);
            // }, onInit: () {
            //   onLoaded(false);
            // }
            // ),
          )
        ],
      ),
    );
  }
}
