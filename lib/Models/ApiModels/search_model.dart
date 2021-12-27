class SearchModel {
  int? id;
  int? category;
  Cover? cover;
  List<Genres>? genres;
  String? name;
  double? rating;

  SearchModel(
      {this.id,
        this.category,
        this.cover,
        this.genres,
        this.name,
        this.rating});

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    cover = json['cover'] != null ? new Cover.fromJson(json['cover']) : null;
    if (json['genres'] != null) {
      genres =  <Genres>[];
      json['genres'].forEach((v) {
        genres?.add(new Genres.fromJson(v));
      });
    }
    name = json['name'];
    if(json['rating'] != null){
      rating = json['rating'] * 1.0;
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    if (this.cover != null) {
      data['cover'] = this.cover?.toJson();
    }
    if (this.genres != null) {
      data['genres'] = this.genres?.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['rating'] = this.rating;
    return data;
  }
}

class Cover {
  int? id;
  String? imageId;

  Cover({this.id, this.imageId});

  Cover.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageId = json['image_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_id'] = this.imageId;
    return data;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}