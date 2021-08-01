import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/my_app.dart';
import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/providers/splash_provider.dart';
import 'package:esay/widgetEdit/test.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:provider/provider.dart';

import '../app_localizations.dart';
import '../models/user_model.dart';
import '../widgets/show_toast.dart';
import 'loading_provider.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  Registering
}

class AuthProvider extends ChangeNotifier {
  FirebaseAuth _auth;
  UserModel _userModel;
  Status _status = Status.Uninitialized;
  Status get status => _status;
  UserModel get userModel => _userModel;
  Stream<UserModel> get user => _auth.authStateChanges().map(_userFromFirebase);
  String verificationId, smsCode;
  int forceResendingToken;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  void changeUserModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  UserModel _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      phoneNumber: user.phoneNumber,
    );
  }

  Future<void> onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
      if (firebaseUser.phoneNumber != null) {
        if (firebaseUser.phoneNumber.isNotEmpty) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(firebaseUser.phoneNumber)
              .get()
              .then((snapshot) async {
            if (snapshot.exists) {
              _userModel = UserModel(
                  uid: snapshot.data()['uid'],
                  phoneNumber: snapshot.data()['phoneNumber'],
                  tokenId: await firebaseMessaging.getToken(),
                  countryCode: snapshot.data()['countryCode'],
                  deviceId: snapshot.data()['deviceId']);
              notifyListeners();
            } else {
              _userModel = UserModel(
                  uid: firebaseUser.uid,
                  phoneNumber: firebaseUser.phoneNumber,
                  tokenId: await firebaseMessaging.getToken(),
                  countryCode: _userModel.countryCode,
                  deviceId: _userModel.deviceId,

              );
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(_userModel.phoneNumber)
                  .set(_userModel.toMap());
              notifyListeners();
            }
          });
        } else {
          _userModel = UserModel(
              uid: firebaseUser.uid,
              phoneNumber: "",
              tokenId: await firebaseMessaging.getToken());
          notifyListeners();
        }
      } else {
        _userModel = UserModel(
            uid: firebaseUser.uid,
            phoneNumber: "",
            tokenId: await firebaseMessaging.getToken());
        notifyListeners();
      }
    }
  }

  Future<void> registerWithPhoneNumber(
      BuildContext context, UserModel userModel, String type) async {
    try {
      _status = Status.Registering;

      notifyListeners();
      final PhoneVerificationCompleted verificationCompleted =
          (AuthCredential authCredential) async {
        await signInWithCredential(authCredential, context);
        final newRouteName = "/homeScreen";
        bool isNewRouteSameAsCurrent = false;
        Navigator.popUntil(context, (route) {
          if (route.settings.name == newRouteName) {
            isNewRouteSameAsCurrent = true;
          }
          return true;
        });

        if (!isNewRouteSameAsCurrent) {
          await SetNot.getDataUsers(context);
          Navigator.pushNamed(context, newRouteName);
        }
      };

      final PhoneVerificationFailed verificationFailed =
          (FirebaseAuthException authException) {
        _status = Status.Unauthenticated;
        notifyListeners();
        if (authException.message.contains('not authorized'))
          showToast('Something has gone wrong, please try later', Colors.red,
              context);
        else if (authException.message.contains('Network'))
          showToast('Please check your internet connection and try again',
              Theme.of(context).iconTheme.color, context);
        else
          showToast('Something has gone wrong, please try later', Colors.red,
              context);
      };

      final PhoneCodeSent codeSent =
          (String verId, [int forceResendingToken]) async {
        this.verificationId = verId;
        this.forceResendingToken = forceResendingToken;
      };

      final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
          (String verId) {
        this.verificationId = verId;
      };
      _userModel = userModel;
      notifyListeners();
      await _auth.verifyPhoneNumber(
          phoneNumber: userModel.phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          forceResendingToken: forceResendingToken,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      print(AppLocalizations.of(context)
              .translate("Error on the new user registration = ") +
          e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
  }

  Future<void> signInWithPhoneNumber(
      BuildContext context, String smsCode, String type) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final splashPovider = Provider.of<SplashPovider>(context, listen: false);
    final cIndexProvider = Provider.of<CIndexProvider>(context, listen: false);

    loadingProvider.changeLoading(true);
    splashPovider.changeSplash(true);
    try {
      AuthCredential authCredential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      if (authCredential.token == null) {
        UserCredential authResult =
            await _auth.signInWithCredential(authCredential);

        User user = authResult.user;
        loadingProvider.changeLoading(false);
        cIndexProvider.changeCIndex(0);
        cIndexProvider.changeNameNav("home");
        final newRouteName = "/homeScreen";
        bool isNewRouteSameAsCurrent = false;
        Navigator.popUntil(context, (route) {
          if (route.settings.name == newRouteName) {
            isNewRouteSameAsCurrent = true;
          }
          return true;
        });

        if (!isNewRouteSameAsCurrent) {
          SetNot.getDataUsers(context);
          await Navigator.pushNamed(context, newRouteName);
        }
        return _userFromFirebase(user);
      }
    } on Exception catch (_) {
      loadingProvider.changeLoading(false);
      showToast("smsFirbaseError", Colors.red, context);
    }
  }

  Future<UserModel> signInWithCredential(
      AuthCredential authCredential, BuildContext context) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final splashPovider = Provider.of<SplashPovider>(context, listen: false);
    final cIndexProvider = Provider.of<CIndexProvider>(context, listen: false);

    loadingProvider.changeLoading(true);
    splashPovider.changeSplash(true);
    cIndexProvider.changeCIndex(0);
    cIndexProvider.changeNameNav("home");

    UserCredential authResult =
        await _auth.signInWithCredential(authCredential);
    loadingProvider.changeLoading(false);

    User user = authResult.user;
    return _userFromFirebase(user);
  }

  Future<void> signInAnonymously(BuildContext context) async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    final splashPovider = Provider.of<SplashPovider>(context, listen: false);
    loadingProvider.changeLoading(true);
    splashPovider.changeSplash(true);
    try {
      UserCredential authResult =
          await FirebaseAuth.instance.signInAnonymously();
      User user = authResult.user;
      loadingProvider.changeLoading(false);
      return _userFromFirebase(user);
    } catch (e) {
      loadingProvider.changeLoading(false);
      print(e);
    }
  }
}
