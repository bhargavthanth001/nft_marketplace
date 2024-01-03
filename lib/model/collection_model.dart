class CollectionModel {
  String? id;
  String name;
  String description;
  String thumbnail;
  String category;
  String createdBy;
  List<String> items;

  CollectionModel({
    this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
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
        category: json["category"],
        createdBy: json["createdBy"],
        items: List<String>.from(json["items"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "createdBy": createdBy,
        "items": List<dynamic>.from(items.map((x) => x)),
      };
}
