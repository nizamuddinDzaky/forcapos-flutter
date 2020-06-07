enum DeliveryType {
  packing,
  delivering,
  done,
}

const statusDeliveries = [
  ['Sedang Dikemas', 'packing', DeliveryType.packing],
  ['Dalam Pengiriman', 'delivering', DeliveryType.delivering],
  ['Sudah Diterima', 'done', DeliveryType.done],
];
