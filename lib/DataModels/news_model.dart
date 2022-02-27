import 'dart:convert';

import 'package:bhoomi/DataModels/news_source.dart';

class NewsModel {
  String? title;
  String? content;
  Uri? urlToImage;
  Uri? url;
  String? dateTime;
  String? author;
  NewsSource? source;
  NewsModel({
    this.title,
    this.content,
    this.urlToImage,
    this.url,
    this.dateTime,
    this.author,
    this.source,
  });

  NewsModel copyWith({
    String? title,
    String? content,
    Uri? urlToImage,
    Uri? url,
    String? dateTime,
    String? author,
    NewsSource? source,
  }) {
    return NewsModel(
      title: title ?? this.title,
      content: content ?? this.content,
      urlToImage: urlToImage ?? this.urlToImage,
      url: url ?? this.url,
      dateTime: dateTime ?? this.dateTime,
      author: author ?? this.author,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'urlToImage': urlToImage?.toString(),
      'url': url?.toString(),
      'dateTime': dateTime,
      'author': author,
      'source': source?.toMap(),
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      title: map['title'],
      content: map['content'],
      urlToImage:
          map['urlToImage'] != null ? Uri.parse(map['urlToImage']) : null,
      url: map['url'] != null ? Uri.parse(map['url']) : null,
      dateTime: map['dateTime'],
      author: map['author'],
      source: map['source'] != null ? NewsSource.fromMap(map['source']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsModel(title: $title, content: $content, urlToImage: $urlToImage, url: $url, dateTime: $dateTime, author: $author, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewsModel &&
        other.title == title &&
        other.content == content &&
        other.urlToImage == urlToImage &&
        other.url == url &&
        other.dateTime == dateTime &&
        other.author == author &&
        other.source == source;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        content.hashCode ^
        urlToImage.hashCode ^
        url.hashCode ^
        dateTime.hashCode ^
        author.hashCode ^
        source.hashCode;
  }
}
