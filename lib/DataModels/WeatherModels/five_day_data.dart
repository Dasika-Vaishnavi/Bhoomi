import 'dart:convert';

class FiveDayData {
  final String? dateTime;
  final int? temp;
  FiveDayData({
    this.dateTime,
    this.temp,
  });

  FiveDayData copyWith({
    String? dateTime,
    int? temp,
  }) {
    return FiveDayData(
      dateTime: dateTime ?? this.dateTime,
      temp: temp ?? this.temp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'temp': temp,
    };
  }

  factory FiveDayData.fromMap(dynamic map) {
    if (map == null) {
      return FiveDayData();
    }

    var f = map['dt_txt'].split(' ')[0].split('-')[2];
    var l = map['dt_txt'].split(' ')[1].split(':')[0];
    var fandl = '$f-$l';
    return FiveDayData(
      dateTime: '$fandl',
      temp: (double.parse(map['main']['temp'].toString()) - 273.15).round(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FiveDayData.fromJson(String source) =>
      FiveDayData.fromMap(json.decode(source));

  @override
  String toString() => 'FiveDayData(dateTime: $dateTime, temp: $temp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FiveDayData &&
        other.dateTime == dateTime &&
        other.temp == temp;
  }

  @override
  int get hashCode => dateTime.hashCode ^ temp.hashCode;
}
