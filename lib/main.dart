import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/core/firebase/firebase_storage.dart';
import 'package:social/core/firebase/firestore_methods.dart';
import 'package:social/core/local_storage/persist_storage.dart';
import 'package:social/core/providers/create_post_provider.dart';
import 'package:social/core/providers/features_provider.dart';
import 'package:social/core/providers/firebase_message_provider.dart';
import 'package:social/core/providers/post_provider.dart';
import 'package:social/core/providers/user_provider.dart';
import 'package:social/ui/shared/constants/constants.dart';

import 'app/app_router.dart';
import 'core/firebase/authentication.dart';
import 'firebase_options.dart';
import 'ui/shared/constants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => FirebaseStorageManager()),
          ChangeNotifierProvider(create: (_) => FirebaseAuthentication()),
          ChangeNotifierProvider(create: (_) => FeaturesProvider()),
          ChangeNotifierProvider(create: (_) => PersistStorageProvider()),
          ChangeNotifierProvider(create: (_) => FirebaseMessage()),
          ChangeNotifierProvider(create: (_) => FirestoreMethods()),
          ChangeNotifierProvider(create: (_) => CreatePostProvider()),
          ChangeNotifierProvider(create: (_) => PostProvider())
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: kAppName,
          restorationScopeId: 'root',
          theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: AppColors.darkBlack,
              appBarTheme: AppBarTheme(
                toolbarHeight: 70,
                backgroundColor: AppColors.darkBlack,
                elevation: 0,
              )),
          routerConfig: routes,
        ));
  }
}
