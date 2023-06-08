import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social/ui/views/features/create_post/create_story_post.dart';
import 'package:social/ui/views/features/create_post/widget/create_post_start.dart';

import './export.dart';
import '../ui/views/features/exports.dart';

final GoRouter routes = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      name: 'startup',
      builder: (context, GoRouterState state) => const StartUpView(),
    ),
    GoRoute(
        path: '/signup',
        name: 'signup-view',
        pageBuilder: (context, GoRouterState state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SignUpView(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        }),
    GoRoute(
      path: '/signin',
      name: 'signin-view',
      builder: (context, GoRouterState state) => const SignInView(),
    ),
    GoRoute(
      path: '/features',
      name: 'features',
      pageBuilder: (context, GoRouterState state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const Features(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeIn).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home-view',
      builder: (context, GoRouterState state) => const HomeView(),
    ),
    GoRoute(
      path: '/search',
      name: 'search-view',
      builder: (context, GoRouterState state) => const SearchView(),
    ),
    GoRoute(
      path: '/create-post',
      name: 'create_post-view',
      builder: (context, GoRouterState state) => const CreatePost(),
    ),
    GoRoute(
      path: '/story-post',
      name: 'create_story-post-view',
      builder: (context, GoRouterState state) => const CreateStoryPost(),
    ),
    GoRoute(
      path: '/create-post-start',
      name: 'create_post-stat-view',
      builder: (context, GoRouterState state) => const CreatePostStart(),
    ),
    GoRoute(
      path: '/notification',
      name: 'notification-view',
      builder: (context, GoRouterState state) => const NotificationView(),
    ),
    GoRoute(
      path: '/profle',
      name: 'profle-view',
      builder: (context, GoRouterState state) => const ProfileView(),
    ),
    GoRoute(
      path: '/uploads',
      name: 'uploads-view',
      builder: (context, GoRouterState state) => const ImageUploadView(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password-view',
      builder: (context, GoRouterState state) => const ForgotPasswordView(),
    ),
    GoRoute(
      path: '/otp',
      name: 'otp-view',
      builder: (context, GoRouterState state) => const OptView(),
    ),
    GoRoute(
      path: '/message',
      name: 'message-view',
      builder: (context, GoRouterState state) => const MessageView(),
    ),
    GoRoute(
      path: '/story',
      name: 'story-view',
      builder: (context, GoRouterState state) => const StoryView(
        stories: [],
      ),
    ),
    GoRoute(
      path: '/chat',
      name: 'chat-view',
      builder: (context, GoRouterState state) => const ChatView(),
    ),
  ],
);
