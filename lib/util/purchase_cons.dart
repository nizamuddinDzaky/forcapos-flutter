enum PurchaseType {
  pending,
  received,
  returned,
}

const statusPurchase = [
  ['Menunggu', 'pending', PurchaseType.pending],
  ['Diterima', 'received', PurchaseType.received],
  ['Kembali', 'returned', PurchaseType.returned],
];
