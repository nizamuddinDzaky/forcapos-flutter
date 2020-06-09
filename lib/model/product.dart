import 'package:posku/model/BaseResponse.dart';

class Product implements Copyable<Product> {
  String id;
  String code;
  String name;
  String unit;
  String cost;
  String price;
  String alertQuantity;
  String image;
  String thumbImage;
  String categoryId;
  String companyId;
  String subcategoryId;
  String cf1;
  String cf2;
  String cf3;
  String cf4;
  String cf5;
  String cf6;
  String quantity;
  String quantityBooking;
  String taxRate;
  String trackQuantity;
  String details;
  String warehouse;
  String barcodeSymbology;
  String file;
  String productDetails;
  String taxMethod;
  String type;
  String supplier1;
  String supplier1price;
  String supplier2;
  String supplier2price;
  String supplier3;
  String supplier3price;
  String supplier4;
  String supplier4price;
  String supplier5;
  String supplier5price;
  String promotion;
  String promoPrice;
  String startDate;
  String endDate;
  String supplier1PartNo;
  String supplier2PartNo;
  String supplier3PartNo;
  String supplier4PartNo;
  String supplier5PartNo;
  String saleUnit;
  String purchaseUnit;
  String brand;
  String uuid;
  String isDeleted;
  String uuidApp;
  String mtid;
  String itemId;
  String public;
  String pricePublic;
  String weight;
  String eMinqty;
  String creditPrice;
  String isRetail;
  String priceGroupId;
  String productCode;
  String productName;
  String priceKredit;
  String minOrder;
  String unitName;
  String isMultiple;

  Product(
      {this.id,
        this.code,
        this.name,
        this.unit,
        this.cost,
        this.price,
        this.alertQuantity,
        this.image,
        this.thumbImage,
        this.categoryId,
        this.companyId,
        this.subcategoryId,
        this.cf1,
        this.cf2,
        this.cf3,
        this.cf4,
        this.cf5,
        this.cf6,
        this.quantity,
        this.quantityBooking,
        this.taxRate,
        this.trackQuantity,
        this.details,
        this.warehouse,
        this.barcodeSymbology,
        this.file,
        this.productDetails,
        this.taxMethod,
        this.type,
        this.supplier1,
        this.supplier1price,
        this.supplier2,
        this.supplier2price,
        this.supplier3,
        this.supplier3price,
        this.supplier4,
        this.supplier4price,
        this.supplier5,
        this.supplier5price,
        this.promotion,
        this.promoPrice,
        this.startDate,
        this.endDate,
        this.supplier1PartNo,
        this.supplier2PartNo,
        this.supplier3PartNo,
        this.supplier4PartNo,
        this.supplier5PartNo,
        this.saleUnit,
        this.purchaseUnit,
        this.brand,
        this.uuid,
        this.isDeleted,
        this.uuidApp,
        this.mtid,
        this.itemId,
        this.public,
        this.pricePublic,
        this.weight,
        this.eMinqty,
        this.creditPrice,
        this.isRetail,
        this.priceGroupId,
        this.productCode,
        this.productName,
        this.priceKredit,
        this.minOrder,
        this.unitName,
        this.isMultiple});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    unit = json['unit'];
    cost = json['cost'];
    price = json['price'];
    alertQuantity = json['alert_quantity'];
    image = json['image'];
    thumbImage = json['thumb_image'];
    categoryId = json['category_id'];
    companyId = json['company_id'];
    subcategoryId = json['subcategory_id'];
    cf1 = json['cf1'];
    cf2 = json['cf2'];
    cf3 = json['cf3'];
    cf4 = json['cf4'];
    cf5 = json['cf5'];
    cf6 = json['cf6'];
    quantity = json['quantity'];
    quantityBooking = json['quantity_booking'];
    taxRate = json['tax_rate'];
    trackQuantity = json['track_quantity'];
    details = json['details'];
    warehouse = json['warehouse'];
    barcodeSymbology = json['barcode_symbology'];
    file = json['file'];
    productDetails = json['product_details'];
    taxMethod = json['tax_method'];
    type = json['type'];
    supplier1 = json['supplier1'];
    supplier1price = json['supplier1price'];
    supplier2 = json['supplier2'];
    supplier2price = json['supplier2price'];
    supplier3 = json['supplier3'];
    supplier3price = json['supplier3price'];
    supplier4 = json['supplier4'];
    supplier4price = json['supplier4price'];
    supplier5 = json['supplier5'];
    supplier5price = json['supplier5price'];
    promotion = json['promotion'];
    promoPrice = json['promo_price'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    supplier1PartNo = json['supplier1_part_no'];
    supplier2PartNo = json['supplier2_part_no'];
    supplier3PartNo = json['supplier3_part_no'];
    supplier4PartNo = json['supplier4_part_no'];
    supplier5PartNo = json['supplier5_part_no'];
    saleUnit = json['sale_unit'];
    purchaseUnit = json['purchase_unit'];
    brand = json['brand'];
    uuid = json['uuid'];
    isDeleted = json['is_deleted'];
    uuidApp = json['uuid_app'];
    mtid = json['mtid'];
    itemId = json['item_id'];
    public = json['public'];
    pricePublic = json['price_public'];
    weight = json['weight'];
    eMinqty = json['e_minqty'];
    creditPrice = json['credit_price'];
    isRetail = json['is_retail'];
    priceGroupId = json['price_group_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    priceKredit = json['price_kredit'];
    minOrder = json['min_order'];
    unitName = json['unit_name'];
    isMultiple = json['is_multiple'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['cost'] = this.cost;
    data['price'] = this.price;
    data['alert_quantity'] = this.alertQuantity;
    data['image'] = this.image;
    data['thumb_image'] = this.thumbImage;
    data['category_id'] = this.categoryId;
    data['company_id'] = this.companyId;
    data['subcategory_id'] = this.subcategoryId;
    data['cf1'] = this.cf1;
    data['cf2'] = this.cf2;
    data['cf3'] = this.cf3;
    data['cf4'] = this.cf4;
    data['cf5'] = this.cf5;
    data['cf6'] = this.cf6;
    data['quantity'] = this.quantity;
    data['quantity_booking'] = this.quantityBooking;
    data['tax_rate'] = this.taxRate;
    data['track_quantity'] = this.trackQuantity;
    data['details'] = this.details;
    data['warehouse'] = this.warehouse;
    data['barcode_symbology'] = this.barcodeSymbology;
    data['file'] = this.file;
    data['product_details'] = this.productDetails;
    data['tax_method'] = this.taxMethod;
    data['type'] = this.type;
    data['supplier1'] = this.supplier1;
    data['supplier1price'] = this.supplier1price;
    data['supplier2'] = this.supplier2;
    data['supplier2price'] = this.supplier2price;
    data['supplier3'] = this.supplier3;
    data['supplier3price'] = this.supplier3price;
    data['supplier4'] = this.supplier4;
    data['supplier4price'] = this.supplier4price;
    data['supplier5'] = this.supplier5;
    data['supplier5price'] = this.supplier5price;
    data['promotion'] = this.promotion;
    data['promo_price'] = this.promoPrice;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['supplier1_part_no'] = this.supplier1PartNo;
    data['supplier2_part_no'] = this.supplier2PartNo;
    data['supplier3_part_no'] = this.supplier3PartNo;
    data['supplier4_part_no'] = this.supplier4PartNo;
    data['supplier5_part_no'] = this.supplier5PartNo;
    data['sale_unit'] = this.saleUnit;
    data['purchase_unit'] = this.purchaseUnit;
    data['brand'] = this.brand;
    data['uuid'] = this.uuid;
    data['is_deleted'] = this.isDeleted;
    data['uuid_app'] = this.uuidApp;
    data['mtid'] = this.mtid;
    data['item_id'] = this.itemId;
    data['public'] = this.public;
    data['price_public'] = this.pricePublic;
    data['weight'] = this.weight;
    data['e_minqty'] = this.eMinqty;
    data['credit_price'] = this.creditPrice;
    data['is_retail'] = this.isRetail;
    data['price_group_id'] = this.priceGroupId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
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