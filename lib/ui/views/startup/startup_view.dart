import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social/core/local_storage/persist_storage.dart';
import 'package:social/ui/shared/constants/constants.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({super.key});

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  void initState() {
    Future.delayed(veryLongDuration).whenComplete(() {
      PersistStorageProvider().getToken().then(
        (value) {
          if (value == '') {
            context.go('/signin');
          } else {
            context.go('/features');
          }
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FlutterLogo(
        size: MediaQuery.of(context).size.height * 0.3,
      ),
    ));
  }
}
