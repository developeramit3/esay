import 'package:app_review/app_review.dart';
import 'package:esay/caches/sharedpref/shared_preference_helper.dart';
import 'package:esay/providers/rating_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../app_localizations.dart';

Widget rating(BuildContext context) {
  return Consumer<RatingProvider>(builder: (context, ratingProvider, _) {
    return ratingProvider.getShow
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              ratingProvider.getRate == 0.0
                  ? Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppLocalizations.of(context).translate("rate1"),
                              style: TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              'assets/images/rate1.png',
                              width: 30,
                            ),
                          ]),
                    )
                  : ratingProvider.getRate == 1.0
                      ? Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                              SizedBox(
                                height: 5,
                              ),
                              Image.asset(
                                'assets/images/rate6.png',
                                width: 30,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                AppLocalizations.of(context).translate("rate2"),
                                style: TextStyle(fontSize: 17),
                              ),
                            ]))
                      : ratingProvider.getRate == 2.0
                          ? Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Image.asset(
                                    'assets/images/rate5.png',
                                    width: 30,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("rate3"),
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ]))
                          : ratingProvider.getRate == 3.0
                              ? Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Image.asset(
                                        'assets/images/rate4.png',
                                        width: 30,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("rate4"),
                                        style: TextStyle(fontSize: 17),
                                      ),
                                    ]))
                              : ratingProvider.getRate == 4.0
                                  ? Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Image.asset(
                                            'assets/images/rate3.png',
                                            width: 30,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("rate5"),
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ]))
                                  : Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Image.asset(
                                            'assets/images/rate2.png',
                                            width: 30,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)
                                                .translate("rate6"),
                                            style: TextStyle(fontSize: 17),
                                          ),
                                        ])),
              SizedBox(
                height: 10,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: SmoothStarRating(
                    allowHalfRating: false,
                    onRated: (v) {
                      print(v);
                      ratingProvider.changeRate(v);
                    },
                    starCount: 5,
                    rating: ratingProvider.getRate,
                    size: 40.0,
                    isReadOnly: false,
                    color: Colors.yellow[800],
                    borderColor: Colors.grey,
                    spacing: 0.0),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  SharedPreferenceHelper().setRate();
                  AppReview.storeListing.then((onValue) {
                    print(onValue);
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: HexColor('#2c6bec'),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 200,
                    height: 50,
                    child: Center(
                      child: Text(
                          AppLocalizations.of(context).translate("rate"),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 25)),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  ratingProvider.changeShow(false);
                },
                child: Text(
                  AppLocalizations.of(context).translate("later"),
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              )
            ],
          )
        : Container();
  });
}
