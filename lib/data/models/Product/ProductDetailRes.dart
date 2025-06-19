class ProductDetailRes {
  bool? status;
  String? message;
  ProductDetail? productDetail;

  ProductDetailRes({this.status, this.message, this.productDetail});

  ProductDetailRes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productDetail = json['ProductDetail'] != null
        ? new ProductDetail.fromJson(json['ProductDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productDetail != null) {
      data['ProductDetail'] = this.productDetail!.toJson();
    }
    return data;
  }
}

class ProductDetail {
  int? productId;
  String? productName;
  int? categoryId;
  String? productDesc;
  String? brandName;
  List<String>? productImage;
  int? productPrice;
  String? pickUpTime;
  int? productQty;
  bool? productStatus;
  List<int>? mbps;
  List<int>? month;
  List<int>? price;
  String? categoryName;

  ProductDetail(
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

  ProductDetail.fromJson(Map<String, dynamic> json) {
    productId = json['ProductId'];
    productName = json['ProductName'];
    categoryId = json['CategoryId'];
    productDesc = json['ProductDesc'];
    brandName = json['Brand_Name'];
    productImage = json['Product_Image'].cast<String>();
    productPrice = json['Product_Price'];
    pickUpTime = json['PickUp_Time'];
    productQty = json['Product_Qty'];
    productStatus = json['ProductStatus'];
    mbps = json['Mbps'].cast<int>();
    month = json['Month'].cast<int>();
    price = json['Price'].cast<int>();
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