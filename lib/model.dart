class Model {
  String? resultDate;
  List<Data>? data;
  int? pageSize;
  int? pageCount;
  int? type;
  String? message;

  Model(
      {this.resultDate,
      this.data,
      this.pageSize,
      this.pageCount,
      this.type,
      this.message});

  Model.fromJson(Map<String, dynamic> json) {
    resultDate = json['resultDate'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultDate'] = this.resultDate;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['pageSize'] = this.pageSize;
    data['pageCount'] = this.pageCount;
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? appName;
  String? appDesc;
  String? appSubDesc;
  String? gitHubUrl;
  List<String>? appImages;
  String? url;
  List<String>? appCardColors;

  Data({
    this.appName,
    this.appDesc,
    this.appSubDesc,
    this.gitHubUrl,
    this.appImages,
    this.url,
    this.appCardColors,
  });

  Data.fromJson(Map<String, dynamic> json) {
    appName = json['appName'];
    appDesc = json['appDesc'];
    appSubDesc = json['appSubDesc'];
    gitHubUrl = json['gitHubUrl'];
    appImages = json['appImages'].cast<String>();
    url = json['url'];
    appCardColors = json['appCardColors'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appName'] = appName;
    data['appDesc'] = appDesc;
    data['appSubDesc'] = appSubDesc;
    data['gitHubUrl'] = gitHubUrl;
    data['appImages'] = appImages;
    data['url'] = url;
    data['appCardColors'] = appCardColors;
    return data;
  }
}
