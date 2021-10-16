import 'package:cached_network_image/cached_network_image.dart';
import 'package:esay/functions/favorite.dart';
import 'package:esay/functions/open_file.dart';
import 'package:esay/models/offer_category_model.dart';
import 'package:esay/providers/share_provider.dart';
import 'package:esay/widgets/pdf.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../providers/favorite_provider.dart';

/*==================================ImageOffer===============================*/

// Widget getImageOffer(
//     String imageName, double height, double width, String offerId) {
// }
class GetImageOffer extends StatelessWidget {
  final String imageName;
  final double height;
  final double width;
  final String offerId;
  const GetImageOffer(
      {Key key, this.imageName, this.height, this.width, this.offerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.white),
          alignment: Alignment.center,
          height: height,
          child: Container(
            width: width,
            height: height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CachedNetworkImage(
                imageUrl:
                    "$imageName",
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    Image.asset('assets/images/offer1.png'),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
        Consumer<FavoriteProvider>(builder: (context, favoriteProvider, _) {
          return !favoriteProvider.getFavoriteId.contains(offerId)
              ? InkWell(
                  onTap: () {
                    favoriteLike(context, offerId);
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(left: 12, top: 12),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Icon(Icons.favorite_border,
                              size: 30, color: Colors.red))))
              : InkWell(
                  onTap: () async {
                    favoriteUnLike(context, offerId);
                  },
                  child: Padding(
                      padding: const EdgeInsets.only(left: 12, top: 12),
                      child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Icon(Icons.favorite,
                              size: 30, color: Colors.red))));
        }),
        SizedBox(width: 50),
      ],
    );
  }
}

Widget getImageOfferDetail(
    String storeId, String imageName, double height, double width) {
  return FutureBuilder<String>(
      future: _getImageOffersDetail(storeId, imageName),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              child: Image.asset(
                'assets/images/offer1.png',
                height: height,
                width: width,
                fit: BoxFit.cover,
              ),
            );
          default:
            return FadeInImage.assetNetwork(
              placeholder: 'assets/images/offer1.png',
              image: "${snapshot.data}",
              height: height,
              width: width,
              fit: BoxFit.cover,
            );
        }
      });
}

getImageOffersForShare(BuildContext context, String filePath , image) async {
  final sharePovider = Provider.of<SharePovider>(context, listen: false);
  var _urlImage = await FirebaseStorage.instance
      .ref()
      .child('offers')
      .child(filePath)
      .getDownloadURL();
  sharePovider.changeFile(_urlImage);
}

Future<String> _getImageOffers(String filePath) async {
  var _urlImage = await FirebaseStorage.instance
      .ref()
      .child('offers')
      .child(filePath)
      .getDownloadURL();
  return _urlImage;
}

Future<String> _getImageOffersDetail(String storeId, String filePath) async {
  print(storeId);
  print(filePath);
  var _urlImage = await FirebaseStorage.instance
      .ref()
      .child('stores')
      .child(storeId)
      .child(filePath)
      .getDownloadURL();
  return _urlImage;
}

Future<void> openPdfStore(
    BuildContext context, String storeId, String filePath) async {
  var urlImage = await FirebaseStorage.instance
      .ref()
      .child('stores')
      .child(storeId)
      .child(filePath)
      .getDownloadURL();
  Route route = MaterialPageRoute(
      builder: (context) => PdfReadFile(
            document: urlImage,
          ));
  Navigator.push(context, route);
  // await openFile(context, urlImage, filePath);
}

Widget getImageOfferCategory(
  OffersCategoryModel offersCategoryModel,
  double height,
  double width,
) {
  return FutureBuilder<String>(
      future: _getImageOfferCategoryPhoto(
          offersCategoryModel.id, offersCategoryModel.photo),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
                decoration: BoxDecoration(color: Colors.white),
                alignment: Alignment.center,
                height: 120,
                child: Container(
                    width: 180,
                    height: 170,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'assets/images/offer1.png',
                        ))));
          default:
            return Stack(children: <Widget>[
              Container(
                  decoration: BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  height: 120,
                  child: Container(
                      width: 180,
                      height: height,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          imageUrl: "${snapshot.data}",
                          fit: BoxFit.fill,
                          placeholder: (context, url) =>
                              Image.asset('assets/images/offer1.png'),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ))),
              FutureBuilder<String>(
                  future: _getImageOfferCategoryLogo(
                      offersCategoryModel.id, offersCategoryModel.logo),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Container();
                      default:
                        return Center(
                            child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 90),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: CachedNetworkImage(
                                            imageUrl: "${snapshot.data}",
                                            color: Colors.white,
                                          ),
                                        ),
                                        // Text(
                                        //   offersCategoryModel.name,
                                        //   style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontSize: 25,
                                        //       fontWeight: FontWeight.bold),
                                        // )
                                      ]),
                                )));
                    }
                  })
            ]);
        }
      });
}

Future<String> _getImageOfferCategoryPhoto(String id, String filePath) async {
  print("id $filePath");
  var _urlImage = await FirebaseStorage.instance
      .ref()
      .child('offersCategory')
      .child(id)
      .child(filePath)
      .getDownloadURL();
  return _urlImage;
}

Future<String> _getImageOfferCategoryLogo(String id, String filePath) async {
  var _urlImage = await FirebaseStorage.instance
      .ref()
      .child('offersCategory')
      .child(id)
      .child(filePath)
      .getDownloadURL();
  return _urlImage;
}
