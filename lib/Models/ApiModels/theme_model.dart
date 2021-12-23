class ThemeModel {
  int? id;
  String? name;

  ThemeModel({this.id, this.name});

  factory ThemeModel.fromJSON(Map<String, dynamic> map) {
    return ThemeModel(
      id: map["id"],
      name: map["name"],
    );
  }

  Map<String, dynamic> toJSON(){
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
