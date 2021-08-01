class UserModel {
  String uid;
  String phoneNumber;
  String tokenId;
  String deviceId;
  String countryCode;

  UserModel({
    this.uid,
    this.phoneNumber,
    this.tokenId,
    this.deviceId,
    this.countryCode,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'tokenId': tokenId,
      'deviceId': deviceId,
      'countryCode': countryCode,
       "subscription_1" :1,
      "subscription1":false,
      "subscription6m":false,
      "subscription12m":false,
      "subscription_6m":2,
      "subscription_12m":5,
      "subscription_1":0,
      'free_code':4,
      'profit':0.0,
      "family":false,
    };
  }
}
