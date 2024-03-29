class CollectionModel {
  String? id;
  String name;
  String description;
  String thumbnail;
  String chain;
  String? bgImage;
  String category;
  String createdBy;
  List<String> items;

  CollectionModel({
    this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.chain,
    this.bgImage,
    required this.category,
    required this.createdBy,
    required this.items,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      CollectionModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        chain: json["chain"],
        bgImage: json["bgImage"],
        category: json["category"],
        createdBy: json["createdBy"],
        items: List<String>.from(json["items"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "chain": chain,
        "bgImage": bgImage,
        "category": category,
        "createdBy": createdBy,
        "items": List<dynamic>.from(items.map((x) => x)),
      };
}
