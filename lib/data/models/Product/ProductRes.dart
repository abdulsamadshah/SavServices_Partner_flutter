class ProductRes {
  bool? status;
  String? message;
  List<ProductData>? productData;

  ProductRes({this.status, this.message, this.productData});

  ProductRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['ProductData'] != null) {
      productData = <ProductData>[];
      json['ProductData'].forEach((v) {
        productData!.add(new ProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productData != null) {
      data['ProductData'] = this.productData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductData {
  int? productId;
  String? productName;
  int? categoryId;
  String? productDesc;
  String? brandName;
  String? productImage;
  int? productPrice;
  String? pickUpTime;
  int? productQty;
  bool? productStatus;
  String? mbps;
  String? month;
  String? price;
  String? categoryName;

  ProductData(
      {this.productId,
        this.productName,
        this.categoryId,
        this.productDesc,
        this.brandName,
        this.productImage,
        this.productPrice,
        this.pickUpTime,
        this.productQty,
        this.productStatus,
        this.mbps,
        this.month,
        this.price,
        this.categoryName});

  ProductData.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    productName = json['ProductName'];
    categoryId = json['CategoryId'];
    productDesc = json['ProductDesc'];
    brandName = json['Brand_Name'];
    productImage = json['Product_Image'];
    productPrice = json['Product_Price'];
    pickUpTime = json['PickUp_Time'];
    productQty = json['Product_Qty'];
    productStatus = json['ProductStatus'];
    mbps = json['Mbps'];
    month = json['Month'];
    price = json['Price'];
    categoryName = json['CategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProductId'] = this.productId;
    data['ProductName'] = this.productName;
    data['CategoryId'] = this.categoryId;
    data['ProductDesc'] = this.productDesc;
    data['Brand_Name'] = this.brandName;
    data['Product_Image'] = this.productImage;
    data['Product_Price'] = this.productPrice;
    data['PickUp_Time'] = this.pickUpTime;
    data['Product_Qty'] = this.productQty;
    data['ProductStatus'] = this.productStatus;
    data['Mbps'] = this.mbps;
    data['Month'] = this.month;
    data['Price'] = this.price;
    data['CategoryName'] = this.categoryName;
    return data;
  }
}
