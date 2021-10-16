import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:esay/models/offer_category_model.dart';
import 'package:esay/providers/account_provider.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/ui/offers/offers_category_screen.dart';
import 'package:esay/widgetEdit/onRefresh.dart';
import 'package:esay/widgets/category_offers.dart';
import 'package:esay/widgets/offer_secret_icons.dart';
import 'package:esay/widgets/rating.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../models/offer_model.dart';
import '../../widgets/appbar.dart';
import '../../widgets/get_image.dart';
import 'package:esay/widgetEdit/textHome_screen.dart';

class OffersScreen extends StatefulWidget {
  OffersScreen({Key key}) : super(key: key);
  @override
  _OffersScreenState createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  ConfettiController controllerTopCenter;
  final TextEditingController _controller = TextEditingController();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    initController();
    // TODO: implement initState
    super.initState();
  }

  void initController() {
    controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  Future<void> _onRefresh(context) async {
    final firestoreDatabase =
        Provider.of<FirestoreDatabase>(context, listen: false);
    await firestoreDatabase.getDetailsOfferSecret(context);
    Future.delayed(Duration(seconds: 7), () {
      _controller.clear();
      // controllerTopCenter.stop();
      _refreshController.refreshCompleted();
    });
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void _onLoading() async {
    _refreshController.loadFailed();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 100));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) _refreshController.loadComplete();
    setState(() {});
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
            appBar: appBar(context, "Home", showBack: false),
            body: Provider.of<AccountProvider>(context, listen: false).ref
                ? SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: false,
                    header: TwoLevelHeader(
                      decoration: BoxDecoration(color: Colors.white),
                      refreshingIcon: offerSecretIcons(),
                      idleIcon: offerSecretIcons(),
                      canTwoLevelIcon: offerSecretIcons(),
                      displayAlignment: TwoLevelDisplayAlignment.fromCenter,
                      canTwoLevelText: '',
                      height: 250,
                      releaseIcon: offerSecretIcons(),
                      completeText: '',
                      idleText: '',
                      refreshingText: '',
                      releaseText: '',
                      twoLevelWidget: offerSecretIcons(),
                    ),
                    footer: CustomFooter(
                      builder: (BuildContext context, LoadStatus mode) {
                        Widget body;
                        if (mode == LoadStatus.idle) {
                          body = Text("pull up load");
                        } else if (mode == LoadStatus.loading) {
                          body = CupertinoActivityIndicator();
                        } else if (mode == LoadStatus.failed) {
                          body = Text("Load Failed!Click retry!");
                        } else if (mode == LoadStatus.canLoading) {
                          body = Text("release to load more");
                        } else {
                          body = Text("No more Data");
                        }
                        return Container(
                          height: 55.0,
                          child: Center(child: body),
                        );
                      },
                    ),
                    controller: _refreshController,
                    onLoading: _onLoading,
                    onRefresh: () {
                      Provider.of<AccountProvider>(context, listen: false)
                              .offerScr
                          ? OnRefresh.onRef(context, _controller, () {
                              _onRefresh(context);
                            }, controllerTopCenter)
                          : _onRefresh(context);
                    },
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(height: 10),
                        rating(context),
                        getText(context),
                        SizedBox(height: 20),
                        Provider.of<AccountProvider>(context, listen: false)
                                    .checkNull !=
                                0
                            ? SizedBox(
                                height: 110,
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
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(width: 5);
                                              },
                                              shrinkWrap: true,
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              physics: ClampingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data.size,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                OffersCategoryModel
                                                    _offersCategoryModel =
                                                    OffersCategoryModel.fromMap(
                                                        snapshot
                                                            .data.docs[index]
                                                            .data(),
                                                        snapshot.data
                                                            .docs[index].id);
                                                return snapshot
                                                            .data.docs.length !=
                                                        0
                                                    ? Container(
                                                        child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (_) =>
                                                                          OffersCategoryScreen(
                                                                              _offersCategoryModel.name)));
                                                            },
                                                            child: categoryOffer(
                                                                context,
                                                                _offersCategoryModel,
                                                                250,
                                                                250)),
                                                      )
                                                    : Container();
                                              });
                                      }
                                    }))
                            : Container(),
                        SizedBox(height: 20),
                        AllProduct(),
                      ],
                    ),
                  )
                : Container(
                    child: ListView(
                      children: [
                        SizedBox(height: 10),
                        rating(context),
                        getText(context),

                        SizedBox(height: 10),
                        Provider.of<AccountProvider>(context, listen: false)
                                    .checkNull !=
                                0
                            ? SizedBox(
                                height: 130,
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
                                                  (BuildContext context,
                                                      int index) {
                                                return SizedBox(width: 5);
                                              },
                                              shrinkWrap: true,
                                              padding:
                                                  EdgeInsets.only(right: 20),
                                              physics: ClampingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: snapshot.data.size,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                OffersCategoryModel
                                                    _offersCategoryModel =
                                                    OffersCategoryModel.fromMap(
                                                        snapshot
                                                            .data.docs[index]
                                                            .data(),
                                                        snapshot.data
                                                            .docs[index].id);
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
                            : Container(),
                        AllProduct(),
                      ],
                    ),
                  ),
          ),
        ));
  }
}

class AllProduct extends StatelessWidget {
  const AllProduct({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('offers')
          .orderBy('startDate')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: CircularProgressIndicator(),
            );
          default:
            return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  OfferModel offerModel = OfferModel.fromMap(
                      snapshot.data.docs[index].data(),
                      snapshot.data.docs[index].id);
                  return InkWell(
                    onTap: () async {
                      showProgressDialog();
                      final firestoreDatabase = Provider.of<FirestoreDatabase>(
                          context,
                          listen: false);
                      await firestoreDatabase.getDetailsStoreAndOffer(
                          context, offerModel);
                      dismissProgressDialog();
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 17, right: 17, bottom: 17, top: 0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GetImageOffer(
                                  imageName: offerModel.imageUrl,
                                  height: 270,
                                  width: MediaQuery.of(context).size.width,
                                  offerId: offerModel.id),
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
                                                fontWeight: FontWeight.bold),
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
                                    fontSize: 22, color: HexColor('#000000')),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Image.network(
                                    '${offerModel.imageCato}',
                                    width: 28,
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
                });
        }
      },
    );
  }
}
//OffersScreen

// void initController() {
//   controllerTopCenter =
//       ConfettiController(duration: const Duration(seconds: 1));
// }
//
