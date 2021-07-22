import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgets/offer_secret_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../models/offer_model.dart';
import '../../widgets/appbar.dart';
import '../../widgets/get_image.dart';

class OffersCategoryScreen extends StatefulWidget {
  OffersCategoryScreen(this.category);
  final String category;
  @override
  _OffersCategoryScreenState createState() => _OffersCategoryScreenState();
}

class _OffersCategoryScreenState extends State<OffersCategoryScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    await firestoreDatabase.getDetailsOfferSecret(context);
    Future.delayed(Duration(seconds: 5), () {
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProgressDialog(
        textDirection: TextDirection.rtl,
        loading: Container(
          decoration: BoxDecoration(
              color: Color(0xa0000000),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: SpinKitRipple(size: 120, color: Colors.white),
        ),
        orientation: ProgressOrientation.horizontal,
        child: SafeArea(
          child: Scaffold(
            appBar: appBar(context, "Home", showBack: true),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(
                  waterDropColor: Colors.white, idleIcon: offerSecretIcons()),
              controller: _refreshController,
              onRefresh: _onRefresh,
              child: ListView(
                children: [
                  // SizedBox(height: 10),
                  // Center(
                  //   child: Container(
                  //     height: 60,
                  //     width: MediaQuery.of(context).size.width - 70,
                  //     color: HexColor('#f8f8ff').withOpacity(0.90),
                  //     child: Center(
                  //       child: Text(
                  //         AppLocalizations.of(context).translate('offer2'),
                  //         style: TextStyle(
                  //             color: HexColor('#2c6bec'),
                  //             fontWeight: FontWeight.w900,
                  //             fontSize: 14),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // rating(context),
                  SizedBox(height: 10),
                  PaginateFirestore(
                    itemBuilderType: PaginateBuilderType.listView,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    initialLoader: Container(
                        height: 500,
                        child: Center(child: CircularProgressIndicator())),
                    itemBuilder: (index, context, documentSnapshot) {
                      OfferModel offerModel = OfferModel.fromMap(
                          documentSnapshot.data(), documentSnapshot.id);
                      return InkWell(
                        onTap: () async {
                          showProgressDialog();
                          final firestoreDatabase =
                              Provider.of<FirestoreDatabase>(context,
                                  listen: false);
                          await firestoreDatabase.getDetailsStoreAndOffer(
                              context, offerModel);
                          dismissProgressDialog();
                        },
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 17, right: 17, bottom: 17, top: 8),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  getImageOffer(
                                      offerModel.photoName,
                                      270,
                                      MediaQuery.of(context).size.width,
                                      offerModel.id),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          offerModel.name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              letterSpacing: 0.5,
                                              color: HexColor('#000000'),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Spacer(),
                                        offerModel.likes == 0
                                            ? Container()
                                            : Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        offerModel.likes == 0
                                            ? Container()
                                            : Text(
                                                offerModel.likes.toString(),
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    offerModel.description,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: HexColor('#000000')),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      offerModel.category == "أكل وشرب"
                                          ? Image.asset(
                                              'assets/images/food and drinks.png',
                                              width: 28,
                                              color: HexColor('#737373'),
                                            )
                                          : Image.asset(
                                              'assets/images/fashion.png',
                                              width: 28,
                                              color: HexColor('#737373'),
                                            ),
                                      SizedBox(width: 8),
                                      Text(
                                        offerModel.category,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: HexColor('#737373')),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                    query: FirebaseFirestore.instance
                        .collection('offers')
                        .where('category', isEqualTo: widget.category)
                        .orderBy('startDate'),

                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
