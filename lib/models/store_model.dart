class StoreModel {
  final String id;
  final String icon;
  final String logo;
  final bool mun;
  final String name;
  final String password;
  final String phone;
  final String category;
  final String menu;
  final String total;
  final String totalNow;
  final String customer;
  final String customerNow;
  final String discount;
  final String easyCost;

  final OfferStoreModel offerStoreModel;
  StoreModel(
      {this.id,
      this.logo,
      this.mun,
      this.name,
      this.password,
        this.icon,
      this.phone,
      this.category,
      this.menu,
      this.total,
      this.totalNow,
      this.customer,
      this.customerNow,
      this.discount,
      this.offerStoreModel,
      this.easyCost});

  factory StoreModel.fromMap(Map<String, dynamic> data, String documentId,
      {OfferStoreModel offerStoreModelData}) {
    if (data == null) {
      return null;
    }
    String id = documentId;
    String icon = data['icon'];
    String logo = data['logo'];
    bool mun = data['name_menu'];
    String name = data['name'];
    String password = data['password'];
    String phone = data['phone'];
    String category = data['category'];
    String menu = data['menu'];
    String total = data['total'];
    String totalNow = data['totalNow'];
    String customer = data['customer'];
    String customerNow = data['customerNow'];
    String discount = data['discount'];
    String easyCost = data['easyCost'];

    OfferStoreModel offerStoreModel = offerStoreModelData;

    return StoreModel(
        id: id,
        icon: icon,
        logo: logo,
        mun: mun,
        name: name,
        password: password,
        phone: phone,
        category: category,
        menu: menu,
        total: total,
        totalNow: totalNow,
        customer: customer,
        customerNow: customerNow,
        offerStoreModel: offerStoreModel,
        discount: discount,
        easyCost: easyCost);
  }
}

class OfferStoreModel {
  final String id;
  final String summary1;
  final String summary2;
  final List<dynamic> branches;
  final List<dynamic> conditions;

  OfferStoreModel({
    this.id,
    this.summary1,
    this.summary2,
    this.branches,
    this.conditions,
  });

  factory OfferStoreModel.fromMap(
      Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    String id = documentId;
    String summary1 = data['summary1'];
    String summary2 = data['summary2'];
    List<dynamic> branches = data['branches'];
    List<dynamic> conditions = data['conditions'];

    return OfferStoreModel(
        id: id,
        summary1: summary1,
        summary2: summary2,
        branches: branches,
        conditions: conditions);
  }
}
