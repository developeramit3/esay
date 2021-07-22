class CodeModel {
  String code;
  String storeName;
  String endDateTime;

  CodeModel({this.code, this.storeName, this.endDateTime});

  toJSONEncodable() {
    Map<String, dynamic> m = Map();
    m['code'] = code;
    m['storeName'] = storeName;
    m['endDateTime'] = endDateTime;
    return m;
  }
}

class CodeModelList {
  List<CodeModel> items;

  CodeModelList() {
    items = List();
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
