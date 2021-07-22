import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/models/offer_category_model.dart';
import 'package:esay/providers/store_provider.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/ui/offers/offers_category_screen.dart';
import 'package:esay/widgets/category_offers.dart';
import 'package:esay/widgets/offer_secret_icons.dart';
import 'package:esay/widgets/rating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../app_localizations.dart';
import '../../models/offer_model.dart';
import '../../widgets/appbar.dart';
import '../../widgets/get_image.dart';
import 'package:esay/widgetEdit/textHome_screen.dart';
class OffersScreen extends StatefulWidget {
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
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
    final storePovider = Provider.of<StorePovider>(context, listen: false);

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
            appBar: appBar(context, "Home", showBack: false),
            body: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(
                  waterDropColor: Colors.white, idleIcon: Icon(Icons.refresh)),
              controller: _refreshController,
              child: ListView(
                children: [
                  SizedBox(height: 10),
                  rating(context),
                  getText(),
                  SizedBox(height: 10),
                  storePovider.getLenght < 4
                      ? SizedBox(
                          height: 180,
                          width: 280,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('offers_category')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) return Container();
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Container();
                                  default:
                                    return ListView.separated(
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(width: 5);
                                        },
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(right: 20),
                                        physics: ClampingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.size,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          OffersCategoryModel
                                              _offersCategoryModel =
                                              OffersCategoryModel.fromMap(
                                                  snapshot.data.docs[index]
                                                      .data(),
                                                  snapshot.data.docs[index].id);
                                          return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            OffersCategoryScreen(
                                                                _offersCategoryModel
                                                                    .name)));
                                              },
                                              child: categoryOffer(
                                                  context,
                                                  _offersCategoryModel,
                                                  250,
                                                  250));
                                        });
                                }
                              }))
                      : Center(
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width - 70,
                            color: HexColor('#f8f8ff').withOpacity(0.90),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate('offer2'),
                                style: TextStyle(
                                    color: HexColor('#2c6bec'),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                        ),
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
                                         "${offerModel.name}",
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
                        .orderBy('startDate'),

                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
