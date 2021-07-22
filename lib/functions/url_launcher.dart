import 'package:flutter/cupertino.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_localizations.dart';

launchCaller(BuildContext context, String phone) async {
  if (await canLaunch("tel:" + phone)) {
    await launch("tel:" + phone);
  } else {
    throw AppLocalizations.of(context).translate('could not launch') + '$phone';
  }
}

launchWebsite(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw AppLocalizations.of(context).translate('could not launch') + '$url';
  }
}

void funcOpenMailComposer(BuildContext context, String email) async {
  final mailtoLink = Mailto(
    to: ['$email'],
    subject: '',
    body: '',
  );
  if (await canLaunch('$mailtoLink')) {
    await launch('$mailtoLink');
  } else {
    throw AppLocalizations.of(context).translate('could not launch') + '$email';
  }
}
