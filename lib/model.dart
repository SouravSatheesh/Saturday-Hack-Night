class Model {
  int totalCount;
  List<Item> items;

  Model({required this.totalCount, required this.items});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      totalCount: json['total_count'],
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x)))
    );
  }
}

class Item {
  String name;

  Item({required this.name});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
    );
  }
}
