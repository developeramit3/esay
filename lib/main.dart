import 'dart:io';
import 'package:esay/providers/account_provider.dart';
import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/providers/code_provider.dart';
import 'package:esay/providers/loading_provider.dart';
import 'package:esay/providers/rating_provider.dart';
import 'package:esay/providers/share_provider.dart';
import 'package:esay/providers/splash_provider.dart';
import 'package:esay/providers/store_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/auth_provider.dart';
import 'providers/favorite_provider.dart';
import 'providers/language_provider.dart';
import 'services/firestore_database.dart';

void main() async {
  if (!kIsWeb && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider(),
          ),
          ChangeNotifierProvider<CIndexProvider>(
            create: (context) => CIndexProvider(),
          ),
          ChangeNotifierProvider<FavoriteProvider>(
            create: (context) => FavoriteProvider(),
          ),
          ChangeNotifierProvider<LoadingProvider>(
            create: (context) => LoadingProvider(),
          ),
          ChangeNotifierProvider<SplashPovider>(
            create: (context) => SplashPovider(),
          ),
          ChangeNotifierProvider<CodeProvider>(
            create: (context) => CodeProvider(),
          ),
          ChangeNotifierProvider<SharePovider>(
            create: (context) => SharePovider(),
          ),
          ChangeNotifierProvider<RatingProvider>(
            create: (context) => RatingProvider(),
          ),
          ChangeNotifierProvider<StorePovider>(
            create: (context) => StorePovider(),
          ),
          ChangeNotifierProvider<AccountProvider>(
            create: (context) => AccountProvider(),
          ),
        ],
        child: MyApp(
          databaseBuilder: (_, uid) => FirestoreDatabase(uid: uid),
        ),
      ),
    );
  });
}
