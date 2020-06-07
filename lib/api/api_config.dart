class ApiConfig {
  static String host = 'https://qp.forca.id/';
//  static String host = 'http://10.15.4.102:9090/';
  static String path = '${host}api/v1/distributor/';
  static String local = '${host}api/Local/';

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

  //purchase
  static String urlAddGRtoPO = '${path}purchases/add_gr_to_po';
  static String urlListGoodReceived = '${path}purchases/list_goods_received';
  static String urlListGoodReceivedPaging = '${path}purchases/list_goods_received_paging';
  static String urlDetailGoodReceived = '${path}purchases/detail_goods_received';

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

  //product
  static String urlListProduct = '${path}products/list_products';

  //local
  static String urlListProvince = '${local}list_province';
  static String urlListCity = '${local}list_city';
  static String urlListStates = '${local}list_states';
}
