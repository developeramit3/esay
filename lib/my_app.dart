import 'package:esay/providers/splash_provider.dart';
import 'package:esay/ui/home/home_screen.dart';
import 'package:esay/ui/welcome_screen.dart';
import 'package:esay/widgetEdit/accont_fy.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:splashscreen/splashscreen.dart';
import 'app_localizations.dart';
import 'auth_widget_builder.dart';
import 'constants/app_themes.dart';
import 'models/user_model.dart';
import 'providers/auth_provider.dart';
import 'providers/language_provider.dart';
import 'routes.dart';
import 'services/firestore_database.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key, this.databaseBuilder}) : super(key: key);

  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String title = "Easy";
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  _firebaseMessaging.subscribeToTopic("Admin");
  }
  @override
  Widget build(BuildContext context) {
    final splashPovider = Provider.of<SplashPovider>(context, listen: false);
    return Consumer<LanguageProvider>(
      builder: (_, languageProviderRef, __) {
        return AuthWidgetBuilder(
          databaseBuilder: widget.databaseBuilder,
          builder:
              (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
            return RefreshConfiguration(
                headerBuilder: () => WaterDropHeader(),
                maxOverScrollExtent: 0,
                maxUnderScrollExtent: 0,
                enableScrollWhenRefreshCompleted: true,
                enableLoadingWhenFailed: true,
                hideFooterWhenNotFull: false,
                enableBallisticLoad: true,
                child: MaterialApp(
                    debugShowCheckedModeBanner: false,
                    locale: languageProviderRef.appLocale,
                    supportedLocales: [
                      Locale('en', 'US'),
                      Locale('ar', 'EG'),
                    ],
                    builder: (context, widget) =>
                        ResponsiveWrapper.builder(widget,
                            maxWidth: 600,
                            minWidth: 420,
                            defaultScale: true,
                            breakpoints: [
                              ResponsiveBreakpoint.autoScale(600, name: MOBILE),
                            ],
                            background: Container(color: Color(0xFFF5F5F5))),
                    localizationsDelegates: [
                      AppLocalizations.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    localeResolutionCallback: (locale, supportedLocales) {
                      for (var supportedLocale in supportedLocales) {
                        if (supportedLocale.languageCode ==
                                locale?.languageCode ||
                            supportedLocale.countryCode ==
                                locale?.countryCode) {
                          return supportedLocale;
                        }
                      }
                      return supportedLocales.first;
                    },
                    title: title,
                    routes: Routes.routes,
                    theme: AppThemes.lightTheme,
                    themeMode: ThemeMode.light,
                    home: !splashPovider.getSplash
                        ? SplashScreen(
                            seconds: 2,
                            image: Image.asset(
                              'assets/images/easy.png',
                            ),
                            backgroundColor: Colors.white,
                            styleTextUnderTheLoader: TextStyle(),
                            photoSize: 100.0,
                            loaderColor: Colors.blue[900],
                            useLoader: true,
                            navigateAfterSeconds: Consumer<AuthProvider>(
                              builder: (_, authProviderRef, __) {
                                if (userSnapshot.connectionState ==
                                    ConnectionState.active) {
                                  return userSnapshot.hasData
                                      ? HomeScreen(
                            title: title,
                          )
                                      : WelcomeScreen();
                                }
                                return Material(
                                    child: Center(
                                  child: CircularProgressIndicator(),
                                ));
                              },
                            ),
                          )
                        : HomeScreen(
                            title: title,
                          )));
          },
        );
      },
    );
  }
}
