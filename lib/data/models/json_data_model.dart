class JsonDataModel {
  final String id;
  final String title;
  final String image;
  String order;

  JsonDataModel({
    required this.id,
    required this.title,
    required this.image,
    required this.order,
  });

  factory JsonDataModel.fromJson(Map json) => JsonDataModel(
        id: json['id'],
        title: json['title'],
        image: json['image'],
        order: json['order'],
      );

  Map toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "order": order,
      };
}
