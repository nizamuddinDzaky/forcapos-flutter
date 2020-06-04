import 'package:posku/model/BaseResponse.dart';

class Product implements Copyable<Product> {
  String id;
  String priceGroupId;
  String productCode;
  String productName;
  String price;
  String priceKredit;
  String minOrder;
  String unitName;
  String isMultiple;

  Product(
      {this.id,
      this.priceGroupId,
      this.productCode,
      this.productName,
      this.price,
      this.priceKredit,
      this.minOrder,
      this.unitName,
      this.isMultiple});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priceGroupId = json['price_group_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    price = json['price'];
    priceKredit = json['price_kredit'];
    minOrder = json['min_order'];
    unitName = json['unit_name'];
    isMultiple = json['is_multiple'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price_group_id'] = this.priceGroupId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['price_kredit'] = this.priceKredit;
    data['min_order'] = this.minOrder;
    data['unit_name'] = this.unitName;
    data['is_multiple'] = this.isMultiple;
    return data;
  }

  @override
  copy() {
    return Product();
  }

  @override
  copyWith({
    id,
    priceGroupId,
    productCode,
    productName,
    price,
    priceKredit,
    minOrder,
    unitName,
    isMultiple,
  }) {
    return Product(
      id: id ?? this.id,
      priceGroupId: priceGroupId ?? this.priceGroupId,
      productCode: productCode ?? this.productCode,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      priceKredit: priceKredit ?? this.priceKredit,
      minOrder: minOrder ?? this.minOrder,
      unitName: unitName ?? this.unitName,
      isMultiple: isMultiple ?? this.isMultiple,
    );
  }
}
