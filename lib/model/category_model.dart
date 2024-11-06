// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) => List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
    int id;
    String catName;

    Category({
        required this.id,
        required this.catName,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        catName: json["Cat_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Cat_name": catName,
    };
}
