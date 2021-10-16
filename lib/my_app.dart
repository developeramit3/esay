import 'package:esay/providers/account_provider.dart';
import 'package:esay/providers/splash_provider.dart';
import 'package:esay/ui/account/account_screen.dart';
import 'package:esay/ui/home/home_screen.dart';
import 'package:esay/ui/welcome_screen.dart';
import 'package:esay/widgetEdit/conext.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'widgetEdit/test.dart';

const bool debugEnableDeviceSimulator = true;

class MyApp extends StatefulWidget {
  const MyApp({Key key, this.databaseBuilder}) : super(key: key);

  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final String title = "Easy";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool checkintr = true;
  bool deco = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    Connect.connect(context);
    SetNot.setNot(context);
    SetNot.shearUrlMeth(context);
    SetNot.delaetFamly(context);
    SetNot.ctogryNumber(context);
    _firebaseMessaging.subscribeToTopic("Admin");
  }

  void checkuser() async {
    await SetNot.setNot24(context);
    await SetNot.getAllSizeUser(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.userModel.phoneNumber != '') {
      print('authProvider${authProvider.userModel.phoneNumber}');
      SetNot.getCodeDetail(context);
      SetNot.getCodeFreeCode(context);
      await SetNot.userNumberGetAuth(context);
      await SetNot.getDataUsers(context);
      await SetNot.timeUpd(context);
      await SetNot.delatSub(context);
      Future.delayed(Duration(seconds: 1), () async {
        final firestoreDatabase =
            Provider.of<FirestoreDatabase>(context, listen: false);
        await firestoreDatabase.getStores(context);
        await firestoreDatabase.checkRate(context);
        await firestoreDatabase.checkUserSharing(context);
        setState(() {
          deco = true;
        });
      });
    } else {
      setState(() {
        deco = true;
      });
    }
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
                child: ScreenUtilInit(
                    designSize: Size(360, 690),
                    builder: () => MaterialApp(
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
                        RefreshLocalizations.delegate,
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
                      home: Provider.of<AccountProvider>(context)
                          .connect
                          ? SplashScreen(
                              seconds: 4,
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
                          : AccountScreen()),
                ));
          },
        );
      },
    );
  }
}
