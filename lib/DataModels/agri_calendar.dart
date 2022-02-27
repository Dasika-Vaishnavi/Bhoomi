class AgriCalendar {
  String? cropName;
  String? summary;
  String? coverImage;
  String? url;
  SowingTWR? sowingTWR;

  AgriCalendar(
      {this.cropName, this.summary, this.coverImage, this.url, this.sowingTWR});

  AgriCalendar.fromJson(Map<String, dynamic> json) {
    cropName = json['CropName'];
    summary = json['Summary'];
    coverImage = json['CoverImage'];
    url = json['Url'];
    sowingTWR = json['SowingTWR'] != null
        ? new SowingTWR.fromJson(json['SowingTWR'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CropName'] = this.cropName;
    data['Summary'] = this.summary;
    data['CoverImage'] = this.coverImage;
    data['Url'] = this.url;
    if (this.sowingTWR != null) {
      data['SowingTWR'] = this.sowingTWR!.toJson();
    }
    return data;
  }
}

class SowingTWR {
  String? regionName;
  List<String>? locations;
  String? from;
  String? to;

  SowingTWR({this.regionName, this.locations, this.from, this.to});

  SowingTWR.fromJson(Map<String, dynamic> json) {
    regionName = json['RegionName'];
    locations = json['Locations'].cast<String>();
    from = json['From'];
    to = json['To'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegionName'] = regionName;
    data['Locations'] = this.locations;
    data['From'] = this.from;
    data['To'] = this.to;
    return data;
  }
}
