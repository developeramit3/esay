import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/providers/loading_provider.dart';
import 'package:esay/ui/account/sms_sceen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../widgets/show_toast.dart';

Future<void> checkUserLogin(
    BuildContext context, UserModel userModel, String type) async {
  final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
  loadingProvider.changeLoading(true);
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userModel.phoneNumber)
      .get();
  if (querySnapshot.exists) {
    loadingProvider.changeLoading(false);
    if (userModel.deviceId == querySnapshot.data()['deviceId']) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => SMSScreen(userModel, type)));
    } else {
      showToast("deviceIdError", Colors.red, context);
    }
  } else {
    loadingProvider.changeLoading(false);

    showToast("This user is not exist, register", Colors.red, context,
        center: true);
  }
}

Future<void> checkUserRegister(
    BuildContext context, UserModel userModel, String type) async {
  final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
  loadingProvider.changeLoading(true);
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userModel.phoneNumber)
      .get();
  if (querySnapshot.exists) {
    loadingProvider.changeLoading(false);
    showToast("This user is already exist, login", Colors.red, context,
        center: true);
  } else {
    loadingProvider.changeLoading(false);
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => SMSScreen(userModel, type)));
  }
}
