enum SalesType {
  pending,
  reserved,
  close,
}

const statusSales = [
  ['Menunggu', 'pending', SalesType.pending],
  ['Dipesan', 'reserved', SalesType.reserved],
  ['Selesai', 'close', SalesType.close],
];
