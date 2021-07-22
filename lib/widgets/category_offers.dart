import 'package:esay/models/offer_category_model.dart';
import 'package:esay/widgets/get_image.dart';
import 'package:flutter/material.dart';

Widget categoryOffer(BuildContext context,
    OffersCategoryModel offersCategoryModel, double hight, double width) {
  return getImageOfferCategory(offersCategoryModel, hight, width);
}
