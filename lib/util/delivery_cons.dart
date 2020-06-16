enum DeliveryType {
  packing,
  delivering,
  delivered,
//  done,
}

const statusDeliveries = [
  ['Sedang Dikemas', 'packing', DeliveryType.packing],
  ['Dalam Pengiriman', 'delivering', DeliveryType.delivering],
  ['Sudah Diterima', 'delivered', DeliveryType.delivered],
];
