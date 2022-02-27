import 'dart:convert';

class CropRecommendation {
  int? nitrogen;
  int? phosphorus;
  int? potassium;
  double? temp;
  double? humidity;
  double? pH;
  double? rainfall;
  String? label;
  CropRecommendation({
    this.nitrogen,
    this.phosphorus,
    this.potassium,
    this.temp,
    this.humidity,
    this.pH,
    this.rainfall,
    this.label,
  });

  CropRecommendation copyWith({
    int? nitrogen,
    int? phosphorus,
    int? potassium,
    double? temp,
    double? humidity,
    double? pH,
    double? rainfall,
    String? label,
  }) {
    return CropRecommendation(
      nitrogen: nitrogen ?? this.nitrogen,
      phosphorus: phosphorus ?? this.phosphorus,
      potassium: potassium ?? this.potassium,
      temp: temp ?? this.temp,
      humidity: humidity ?? this.humidity,
      pH: pH ?? this.pH,
      rainfall: rainfall ?? this.rainfall,
      label: label ?? this.label,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nitrogen': nitrogen,
      'phosphorus': phosphorus,
      'potassium': potassium,
      'temp': temp,
      'humidity': humidity,
      'pH': pH,
      'rainfall': rainfall,
      'label': label,
    };
  }

  factory CropRecommendation.fromMap(Map<String, dynamic> map) {
    return CropRecommendation(
      nitrogen: map['N']?.toInt(),
      phosphorus: map['P']?.toInt(),
      potassium: map['K']?.toInt(),
      temp: map['temperature']?.toDouble(),
      humidity: map['humidity']?.toDouble(),
      pH: map['ph']?.toDouble(),
      rainfall: map['rainfall']?.toDouble(),
      label: map['label'],
    );
  }

  CropRecommendation.fromList(items)
      : this(
            nitrogen: (items[0]),
            phosphorus: (items[1]),
            potassium: (items[2]),
            temp: (items[3]),
            humidity: (items[4]),
            pH: (items[5]),
            rainfall: (items[6]),
            label: items[7]);

  String toJson() => json.encode(toMap());

  factory CropRecommendation.fromJson(String source) =>
      CropRecommendation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CropRecommendation(nitrogen: $nitrogen, phosphorus: $phosphorus, potassium: $potassium, temp: $temp, humidity: $humidity, pH: $pH, rainfall: $rainfall, label: $label)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CropRecommendation &&
        other.nitrogen == nitrogen &&
        other.phosphorus == phosphorus &&
        other.potassium == potassium &&
        other.temp == temp &&
        other.humidity == humidity &&
        other.pH == pH &&
        other.rainfall == rainfall &&
        other.label == label;
  }

  @override
  int get hashCode {
    return nitrogen.hashCode ^
        phosphorus.hashCode ^
        potassium.hashCode ^
        temp.hashCode ^
        humidity.hashCode ^
        pH.hashCode ^
        rainfall.hashCode ^
        label.hashCode;
  }
}
