import 'package:flutter/material.dart';
import 'package:fluttercrud/application/repositories/auth_repository.dart';
import 'package:fluttercrud/application/repositories/forum_repository.dart';
import 'package:fluttercrud/application/repositories/opportunity_repository.dart';
import 'package:fluttercrud/application/state/auth_state.dart';
import 'package:fluttercrud/application/state/forum_state.dart';
import 'package:fluttercrud/application/state/opportunity_state.dart';
import 'package:fluttercrud/application/storage/localstorage.dart';
import 'package:fluttercrud/application/storage/storage_keys.dart';
import 'package:fluttercrud/router/route_constants.dart';
import 'package:fluttercrud/router/router.dart' as CustomRouter;
import 'package:fluttercrud/values/branding_color.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.initializeSharedPreferences();

  runApp(FlutterCRUD());
}

class FlutterCRUD extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Injector(
        inject: [
          Inject<AuthState>(() => AuthState(AuthRepositoryImpl())),
          Inject<OpportunityState>(
              () => OpportunityState(OpportunityRepositoryImpl())),
          Inject<ForumState>(() => ForumState(ForumRepositoryImpl())),
        ],
        builder: (context) {
          return MaterialApp(
            title: 'Flutter CRUD',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Dosis',
              primarySwatch: brandingColor,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            onGenerateRoute: CustomRouter.Router.onGenerateRoute,
            initialRoute:
                LocalStorage.getItem(TOKEN) != null ? homeRoute : loginRoute,
          );
        });
  }
}

//Architecture

// Presentation Layer -> UI, Screens
// network layer -> logic
// routes
