import 'package:posku/main.dart';

class ApiConfig {
//  static const String host = 'http://qp.forca.id/';
  static const String hostDev = 'https://qp.forca.id/';
  static const String host = 'https://pos.forca.id/';
//  static const String host = 'http://10.15.4.102/'; //ip qp
//  static String host = 'http://10.15.4.102:9090/'; //dirty
  static const String path = '${isProd ? host : hostDev}api/v1/distributor/';
  static const String local = '${isProd ? host : hostDev}api/Local/';

  //auth
  static String urlLogin = '${path}auth/login';
  static String urlResetPass = '${path}auth/forgot_password';
  static String urlProfile = '${path}auth/profile';
  static String urlProfileUpdate = '${path}auth/update_profile';

  //sales booking
  static String urlAddPaymentBooking = '${path}sales_booking/add_payments';
  static String urlEditPaymentBooking = '${path}sales_booking/edit_payments';
  static String urlAddSalesBooking = '${path}sales_booking/add_sales_booking';
  static String urlAddDeliveriesBooking = '${path}sales_booking/add_deliveries_booking';
  static String urlListSalesBookingTrx = '${path}sales_booking/list_transaction_sales_booking';
  static String urlListSalesBooking = '${path}sales_booking/list_sales_booking';
  static String urlListPaymentBooking = '${path}sales_booking/list_payments';
  static String urlListDeliveriesBooking = '${path}sales_booking/list_deliveries_booking';
  static String urlDetailSalesBooking = '${path}sales_booking/detail_sales_booking';
  static String urlSalesBookingUpdate = '${path}sales_booking/edit_sales_booking';
  static String urlDetailDeliveries = '${path}sales_booking/detail_deliveries';
  static String urlEditDeliveriesBooking = '${path}sales_booking/edit_deliveries_booking';
  static String urlReturnDeliveriesBooking = '${path}sales_booking/add_return_deliveries';
  static String urlCloseSalesBooking = '${path}sales_booking/close_sales_booking';

  //GR
  static String urlAddGRtoPO = '${path}purchases/add_gr_to_po';
  static String urlListGoodReceived = '${path}purchases/list_goods_received';
  static String urlListGoodReceivedPaging = '${path}purchases/list_goods_received_paging';
  static String urlDetailGoodReceived = '${path}purchases/detail_goods_received';

  //purchase
  static String urlListPurchase = '${path}Purchases/list_purchases';
  static String urlAddPurchase = '${path}Purchases/add_purchases';
  static String urlDetailPurchase = '${path}Purchases/detail_purchases';
  static String urlUpdatePurchase = '${path}Purchases/edit_purchase';
  static String urlReturnPurchase = '${path}Purchases/return_purchases';
  static String urlPaymentPurchase = '${path}Purchases/payments_purchase';
  static String urlAddPaymentPurchase = '${path}Purchases/add_payment';
  static String urlEditPaymentPurchase = '${path}Purchases/edit_payment_purchase';

  //warehouse
  static String urlListWarehouse = '${path}warehouses/list_warehouses';
  static String urlDetailWarehouse = '${path}warehouses/detail_warehouses';

  //supplier
  static String urlListSupplier = '${path}suppliers/list_suppliers';
  static String urlDetailSupplier = '${path}suppliers/detail_suppliers';

  //customer
  static String urlAddPriceGroupCustomer = '${path}customers/add_price_group';
  static String urlCustomerToPGAddEdit = '${path}customers/add_or_edit_customer_to_price_group';
  static String urlPriceGroupUpdate = '${path}customers/update_price_group';
  static String urlAddCustomerGroup = '${path}customers/add_customer_group';
  static String urlCustomerGroupUpdate = '${path}customers/update_customer_group';
  static String urlListCustomer = '${path}customers/list_customers';
  static String urlListCustomerGroup = '${path}customers/customers_groups';
  static String urlListPriceGroup = '${path}customers/price_groups';
  static String urlDetailCustomer = '${path}customers/detail_customers';
  static String urlAddCustomer = '${path}customers/add_customers';
  static String urlUpdateCustomer = '${path}customers/update_customers';
  static String urlCustomerToCGAddEdit = '${path}customers/add_or_edit_customer_to_customer_group';
  static String urlSyncToBK = '${path}customers/sync_customer_to_bk';
  static String urlProductPriceGroup = '${path}customers/group_product_in_prices_group';
  static String urlProductPriceGroupUpdate = '${path}customers/update_product_in_price_group';
  static String urlMemberCustomerGroup = '${path}customers/list_customer_member_of_customer_group';
  static String urlMemberPriceGroup = '${path}customers/list_customer_member_of_price_group';
  static String urlSelectedWarehouse = '${path}customers/list_customer_warehouse';

  //product
  static String urlListProduct = '${path}products/list_products';
  static String urlListProductPurchase = '${path}products/list_product_purchase';

  //local
  static String urlListProvince = '${local}list_province';
  static String urlListCity = '${local}list_city';
  static String urlListStates = '${local}list_states';
}
