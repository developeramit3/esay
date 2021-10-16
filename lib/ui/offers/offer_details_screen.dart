import 'dart:io';
import 'package:esay/progress/progress_dialog.dart';
import 'package:esay/providers/account_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/functions/share.dart';
import 'package:esay/functions/url_launcher.dart';
import 'package:esay/models/store_model.dart';
import 'package:esay/providers/auth_provider.dart';
import 'package:esay/providers/bottom_animation_provider.dart';
import 'package:esay/providers/code_provider.dart';
import 'package:esay/providers/share_provider.dart';
import 'package:esay/widgetEdit/dielog_qr.dart';
import 'package:esay/widgetEdit/model_f_chack.dart';
import 'package:esay/widgetEdit/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../app_localizations.dart';
import '../../models/offer_model.dart';
import '../../widgets/appbar.dart';
import '../../widgets/get_image.dart';
import 'dart:async';

class OfferDetailsScreen extends StatefulWidget {
  OfferDetailsScreen({this.offerModel, this.storeModel});
  final OfferModel offerModel;
  final StoreModel storeModel;
  @override
  _OfferDetailsScreenState createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  bool dismiss = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
      SetNot.getOfferCount(context, widget.offerModel.id);
      await getImageOffersForShare(context, widget.offerModel.photoName , widget.offerModel.imageUrl);
    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, "getOffer", showBack: true),
        bottomNavigationBar:
            Consumer<CodeProvider>(builder: (context, codeProvider, _) {

          return Container(
              color: HexColor('#2c6bec'),
              width: MediaQuery.of(context).size.width,
              padding: codeProvider.getCode != ""
                  ? EdgeInsets.only(top: 8)
                  : EdgeInsets.only(top: 0),
              child: _dis(widget.offerModel.id)
              //codeProvider.getCode != ""

              );
        }),
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: getImageOfferDetail(
                          widget.offerModel.store,
                          widget.storeModel.logo,
                          100,
                          MediaQuery.of(context).size.width * 0.2),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.storeModel.name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Row(children: [
                            Image.network(
                              '${widget.storeModel.icon}',
                              width: 28,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.storeModel.category,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#737373')),
                            ),
                          ]),
                          Text(
                            widget.storeModel.offerStoreModel.summary1,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        color: HexColor('#e8e7e7'),
                        thickness: 1,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Wrap(
                        children: [
                          Row(
                            mainAxisAlignment: widget.storeModel.menu.isEmpty &&
                                    widget.storeModel.phone.isEmpty
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceEvenly,
                            children: [
                              widget.storeModel.menu.isEmpty
                                  ? Container()
                                  : InkWell(
                                      onTap: () async {
                                        showProgressDialog(
                                            context: context,
                                            loadingText: "",
                                            backgroundColor:
                                                HexColor('#2c6bec'));
                                        await openPdfStore(
                                            context,
                                            widget.offerModel.store,
                                            widget.storeModel.menu);
                                        dismissProgressDialog();
                                      },
                                      child: Container(
                                        //padding: EdgeInsets.only(right: 10),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/menu and details.png",
                                                width: 30,
                                                color: HexColor('#2c6bec')),
                                            SizedBox(width: 5),
                                            Text(
                                              widget.storeModel.mun
                                                  ? "قائمة الطعام"
                                                  : AppLocalizations.of(context)
                                                      .translate(
                                                          "offersAndDetails"),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: HexColor('#49494a')),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              widget.storeModel.phone.isEmpty
                                  ? Container()
                                  : InkWell(
                                      onTap: () async {
                                        await launchCaller(
                                            context, widget.storeModel.phone);
                                      },
                                      child: Container(
                                        width: 100,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                                "assets/images/phone 1st.png",
                                                width: 30,
                                                color: HexColor('#2c6bec')),
                                            SizedBox(width: 5),
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("call"),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: HexColor('#49494a')),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                              InkWell(
                                onTap: () async {
                                  final sharePovider =
                                  Provider.of<SharePovider>(context,
                                      listen: false);
                                  await share(
                                      sharePovider.getFile,
                                      widget.offerModel.photoName,
                                      widget.storeModel.name,
                                      widget.offerModel.description);
                                },
                                child: checkPat(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        color: HexColor('#e8e7e7'),
                        thickness: 1,
                      ),
                    ),
                    Text(
                      widget.storeModel.offerStoreModel.summary2,
                      style: TextStyle(
                          color: HexColor('#49494a'),
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        color: HexColor('#e8e7e7'),
                        thickness: 1,
                      ),
                    ),
                    Text(AppLocalizations.of(context).translate("branches"),
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.storeModel.offerStoreModel.branches
                              .map((e) {
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    alignment: WrapAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Image.asset(
                                            "assets/images/location.png",
                                            width: 25,
                                            color: HexColor('#2c6bec')),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        e['name'].toString(),
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 35),
                                    child: Text(e['address'].toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor('#737373'))),
                                  )
                                ]);
                          }).toList()),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        color: HexColor('#e8e7e7'),
                        thickness: 1,
                      ),
                    ),
                    Text(AppLocalizations.of(context).translate("conditions"),
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    Container(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          widget.storeModel.offerStoreModel.conditions.map((e) {
                        return Column(children: [
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              widget.storeModel.offerStoreModel.conditions[
                                          widget.storeModel.offerStoreModel
                                                  .conditions.length -
                                              1] ==
                                      e
                                  ? Image.asset("assets/images/clock.png",
                                      width: 25, color: HexColor('#2c6bec'))
                                  : Image.asset(
                                      "assets/images/terms and conditions.png",
                                      width: 25,
                                      color: HexColor('#2c6bec')),
                              SizedBox(width: 8),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Text(e,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor('#49494a'))),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ]);
                      }).toList(),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        Provider.of<AccountProvider>(context).offerCounter ==
                                null
                            ? ""
                            : " * متبقي لديك  ${Provider.of<AccountProvider>(context, listen: false).offerCounter.toString()}  رموز لهذا العرض ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget checkPat() {
    if (Platform.isAndroid) {
      return Container(
        child: Row(
          children: [
            Image.asset("assets/images/share.png",
                width: 30, color: HexColor('#2c6bec')),
            SizedBox(width: 5),
            Text(
              AppLocalizations.of(context).translate("share"),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#49494a')),
            ),
          ],
        ),
      );
    } else if (Platform.isIOS) {
      return Container(
        child: Row(
          children: [
            Icon(
              CupertinoIcons.share,
              color: HexColor('#49494a'),
              size: 30,
            ),
            SizedBox(width: 5),
            Text(
              AppLocalizations.of(context).translate("share"),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#49494a')),
            ),
          ],
        ),
      );
    }
  }

  Widget _dis(String offerId) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final cIndexProvider = Provider.of<CIndexProvider>(context, listen: false);
    print("offerId $offerId");
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 70,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('codes')
              .where("user_id", isEqualTo: authProvider.userModel.phoneNumber)
              .where('offerId', isEqualTo: offerId)
              .where('close', isEqualTo: false)
              .snapshots(),
          builder: (context, snap) {
            if (snap.data != null && snap.data.size != 0) {
              var _endDate =
                  snap.data.docs[0]['endDateTime'].millisecondsSinceEpoch +
                      1000 * 30;
              return snap.data.docs[0]['endDateTime']
                      .toDate()
                      .isAfter(DateTime.now())
                  ? snap.data.docs[0]['offerId'] == offerId &&
                          snap.data.docs[0]['close'] == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                              Image.asset(
                                'assets/images/timerNew.png',
                                width: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: CountdownTimer(
                                    endTime: _endDate,
                                    widgetBuilder:
                                        (_, CurrentRemainingTime time) {
                                      int hours;
                                      if (time.days != null) {
                                        hours = (time.days * 24) + time.hours;
                                      }
                                      return time.days == null
                                          ? Text(
                                              time.hours == null
                                                  ? '0    :    ${time.min}    :    ${time.sec}'
                                                  : time.min == null
                                                      ? '0    :    0    :    ${time.sec}'
                                                      : '${time.hours}    :    ${time.min}    :    ${time.sec}',
                                              style: TextStyle(
                                                  color: Colors.grey[300],
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : Text(
                                              time.days == null
                                                  ? '0    : 0    : ${time.min}    :    ${time.sec}'
                                                  : time.hours == null
                                                      ? '0    :    ${time.min}    :    ${time.sec}'
                                                      : time.min == null
                                                          ? '0    :    0    :    ${time.sec}'
                                                          : ' $hours  :    ${time.min}    :    ${time.sec}',
                                              style: TextStyle(
                                                  color: Colors.grey[300],
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            );
                                    },
                                  )),
                              SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CustomDialogQr(
                                          title:
                                              "رمز أيزي الخاص بك لهذا العرض هو",
                                          text: "شكرا !",
                                          code: "${snap.data.docs[0]['code']}",
                                        );
                                      });
                                },
                                child: QrImage(
                                  data: "${snap.data.docs[0]['code']}",
                                  version: QrVersions.auto,
                                  size: 60.0,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ])
                      : FlatButton(
                          color: HexColor('#2c6bec'),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("getCode"),
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              )),
                          onPressed: () async {
                            if (authProvider.userModel.phoneNumber == "") {
                              Navigator.of(context).pop();
                              cIndexProvider.changeCIndex(3);
                              cIndexProvider.changeNameNav("account");
                              final newRouteName = "/accountScreen";
                              bool isNewRouteSameAsCurrent = false;
                              Navigator.popUntil(context, (route) {
                                if (route.settings.name == newRouteName) {
                                  isNewRouteSameAsCurrent = true;
                                }
                                return true;
                              });

                              if (!isNewRouteSameAsCurrent) {
                                Navigator.pushNamed(context, newRouteName);
                              }
                            } else {
                              // showProgressDialog(
                              //     context: context,
                              //     loadingText: "",
                              //     backgroundColor: HexColor('#2c6bec'));
                              GetCodeEdit.check_sub(context, widget.offerModel,
                                  widget.storeModel);
                            }
                          })
                  : FlatButton(
                      color: HexColor('#2c6bec'),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context).translate("getCode"),
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w900),
                          )),
                      onPressed: () async {
                        if (authProvider.userModel.phoneNumber == "") {
                          Navigator.of(context).pop();
                          cIndexProvider.changeCIndex(3);
                          cIndexProvider.changeNameNav("account");
                          final newRouteName = "/accountScreen";
                          bool isNewRouteSameAsCurrent = false;
                          Navigator.popUntil(context, (route) {
                            if (route.settings.name == newRouteName) {
                              isNewRouteSameAsCurrent = true;
                            }
                            return true;
                          });

                          if (!isNewRouteSameAsCurrent) {
                            Navigator.pushNamed(context, newRouteName);
                          }
                        } else {
                          // showProgressDialog(
                          //     context: context,
                          //     loadingText: "",
                          //     backgroundColor: HexColor('#2c6bec'));
                          GetCodeEdit.check_sub(
                              context, widget.offerModel, widget.storeModel);
                        }
                      });
            } else {
              return FlatButton(
                  color: HexColor('#2c6bec'),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context).translate("getCode"),
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      )),
                  onPressed: () async {
                    if (authProvider.userModel.phoneNumber == "") {
                      Navigator.of(context).pop();
                      cIndexProvider.changeCIndex(3);
                      cIndexProvider.changeNameNav("account");
                      final newRouteName = "/accountScreen";
                      bool isNewRouteSameAsCurrent = false;
                      Navigator.popUntil(context, (route) {
                        if (route.settings.name == newRouteName) {
                          isNewRouteSameAsCurrent = true;
                        }
                        return true;
                      });
                      if (!isNewRouteSameAsCurrent) {
                        Navigator.pushNamed(context, newRouteName);
                      }
                    } else {
                      // showProgressDialog(
                      //     context: context,
                      //     loadingText: "",
                      //     backgroundColor: HexColor('#2c6bec'));
                      GetCodeEdit.check_sub(
                          context, widget.offerModel, widget.storeModel);
                    }
                  });
            }
          }),
    );
  }
}
