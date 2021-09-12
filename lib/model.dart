class Model {
  int totalCount;
  List<Item> items;

  Model({required this.totalCount, required this.items});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
        totalCount: json['total_count'],
        items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))));
  }
}

class Item {
  String name;
  String owner;
  int rating;
  String avatar;
  String? language;

  Item({
    required this.name,
    required this.owner,
    required this.rating,
    required this.avatar,
    required this.language,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      owner: json['owner']['login'],
      rating: json['stargazers_count'],
      avatar: json['owner']['avatar_url'],
      language: json['language'],
    );
  }
}

class User {
  String? name;

  User({
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
    );
  }
}
