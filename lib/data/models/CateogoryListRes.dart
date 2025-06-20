class CateogoryListRes {
  bool? status;
  String? message;
  List<Categorys>? categorys;

  CateogoryListRes({this.status, this.message, this.categorys});

  CateogoryListRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Categorys'] != null) {
      categorys = <Categorys>[];
      json['Categorys'].forEach((v) {
        categorys!.add(new Categorys.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.categorys != null) {
      data['Categorys'] = this.categorys!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categorys {
  int? id;
  String? name;
  String? image;

  Categorys({this.id, this.name, this.image});

  Categorys.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['Image'] = this.image;
    return data;
  }
}
