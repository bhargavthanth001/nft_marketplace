import 'nft_model.dart';

class CollectionModel {
  String? id;
  String? name;
  String? thumbnail;
  String? createdBy;
  List<NftModel>? items;

  CollectionModel({
    this.id,
    this.name,
    this.thumbnail,
    this.createdBy,
    this.items,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      CollectionModel(
        id: json["id"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        createdBy: json["createdBy"],
        items: json["items"] == null
            ? []
            : List<NftModel>.from(
                json["items"]!.map((x) => NftModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
        "createdBy": createdBy,
        "items": items == null
            ? []
            : List<NftModel>.from(items!.map((e) => e.toJson())),
      };
}
