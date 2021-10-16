import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esay/services/firestore_database.dart';
import 'package:esay/widgets/offer_secret_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_dialog/flutter_progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../models/offer_model.dart';
import '../../widgets/appbar.dart';
import 'package:esay/providers/account_provider.dart';
import '../../widgets/get_image.dart';
import 'package:esay/widgetEdit/onRefresh.dart';
import 'package:confetti/confetti.dart';

class OffersCategoryScreen extends StatefulWidget {
  OffersCategoryScreen(this.category);
  final String category;
  @override
  _OffersCategoryScreenState createState() => _OffersCategoryScreenState();
}

class _OffersCategoryScreenState extends State<OffersCategoryScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final TextEditingController _controller = TextEditingController();
  ConfettiController controllerTopCenter;
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

  void _onLoading() async {
    _refreshController.loadFailed();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 100));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) _refreshController.loadComplete();
    setState(() {});
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
              enablePullDown:
                  Provider.of<AccountProvider>(context, listen: false).ref
                      ? true
                      : false,
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
                Provider.of<AccountProvider>(context, listen: false).offerScr
                    ? OnRefresh.onRef(context, _controller, () {
                        _onRefresh(context);
                      }, controllerTopCenter)
                    : _onRefresh(context);
              },
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
                  AllCategory(category: widget.category),
                ],
              ),
            ),
          ),
        ));
  }
}

class AllCategory extends StatelessWidget {
  final String category;
  const AllCategory({Key key, this.category}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('offers')
          .where('category', isEqualTo: category)
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
