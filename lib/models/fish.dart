class FishsModel {
  int? id;
  String? name;
  String? description;
  String? thumbnail;
  double? size;
  int? health;
  List<String>? images;

  FishsModel(
      {this.id,
      this.name,
      this.description,
      this.thumbnail,
      this.size,
      this.health,
      this.images});

  FishsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    size = json['size'] is double ? json['size'] : double.tryParse(json['size'].toString());
    health= json['health'] is int ? json['health'] : int.tryParse(json['health'].toString());

    images = json['images'] != null ? List<String>.from(json['images']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['size'] = this.size;
    data['health'] = this.health;
    data['images'] = this.images;
    return data;
  }
}
