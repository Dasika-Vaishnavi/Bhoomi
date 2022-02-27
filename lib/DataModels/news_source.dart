import 'dart:convert';

class NewsSource {
  String? id;
  String? name;
  NewsSource({
    this.id,
    this.name,
  });

  NewsSource copyWith({
    String? id,
    String? name,
  }) {
    return NewsSource(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory NewsSource.fromMap(Map<String, dynamic> map) {
    return NewsSource(
      id: map['id'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsSource.fromJson(String source) =>
      NewsSource.fromMap(json.decode(source));

  @override
  String toString() => 'NewsSource(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsSource && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
