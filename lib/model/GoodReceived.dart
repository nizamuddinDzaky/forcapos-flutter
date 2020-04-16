class GoodReceived {
  String id;
  String companyCode;
  String companyName;
  String noPp;
  String tanggalPp;
  Null noKontrak;
  String noSo;
  String tipeOrder;
  String tanggalSo;
  String incotrem;
  String noDo;
  String tanggalDo;
  String kodeProduk;
  String namaProduk;
  String qtyDo;
  String uom;
  String noTransaksi;
  String noSpj;
  String tanggalSpj;
  String jamSpj;
  String noSpss;
  String noPolisi;
  String namaSopir;
  String kodeDistributor;
  String distributor;
  String kodeShipto;
  String namaShipto;
  String alamatShipto;
  String kodeDistrik;
  String distrik;
  String kodeKecamatan;
  String namaKecamatan;
  String kodeEkspeditur;
  String ekspeditur;
  String kodePlant;
  String namaPlant;
  String namaKapal;
  String status;
  String statusPenerimaan;
  String lineSo;
  String nomerPo;
  String tanggalAntri;
  String jamAntri;
  String tanggalMasuk;
  String jamMasuk;
  String supplierId;
  String warehouseId;
  String billerId;
  String createdAt;
  Null updatedAt;
  Null note;
  Null attachment;
  String total;
  String productDiscount;
  Null orderDiscountId;
  Null orderDiscount;
  String totalDiscount;
  String productTax;
  String orderTaxId;
  Null orderTax;
  String totalTax;
  String shipping;
  String grandTotal;

  GoodReceived(
      {this.id,
      this.companyCode,
      this.companyName,
      this.noPp,
      this.tanggalPp,
      this.noKontrak,
      this.noSo,
      this.tipeOrder,
      this.tanggalSo,
      this.incotrem,
      this.noDo,
      this.tanggalDo,
      this.kodeProduk,
      this.namaProduk,
      this.qtyDo,
      this.uom,
      this.noTransaksi,
      this.noSpj,
      this.tanggalSpj,
      this.jamSpj,
      this.noSpss,
      this.noPolisi,
      this.namaSopir,
      this.kodeDistributor,
      this.distributor,
      this.kodeShipto,
      this.namaShipto,
      this.alamatShipto,
      this.kodeDistrik,
      this.distrik,
      this.kodeKecamatan,
      this.namaKecamatan,
      this.kodeEkspeditur,
      this.ekspeditur,
      this.kodePlant,
      this.namaPlant,
      this.namaKapal,
      this.status,
      this.statusPenerimaan,
      this.lineSo,
      this.nomerPo,
      this.tanggalAntri,
      this.jamAntri,
      this.tanggalMasuk,
      this.jamMasuk,
      this.supplierId,
      this.warehouseId,
      this.billerId,
      this.createdAt,
      this.updatedAt,
      this.note,
      this.attachment,
      this.total,
      this.productDiscount,
      this.orderDiscountId,
      this.orderDiscount,
      this.totalDiscount,
      this.productTax,
      this.orderTaxId,
      this.orderTax,
      this.totalTax,
      this.shipping,
      this.grandTotal});

  GoodReceived.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyCode = json['company_code'];
    companyName = json['company_name'];
    noPp = json['no_pp'];
    tanggalPp = json['tanggal_pp'];
    noKontrak = json['no_kontrak'];
    noSo = json['no_so'];
    tipeOrder = json['tipe_order'];
    tanggalSo = json['tanggal_so'];
    incotrem = json['incotrem'];
    noDo = json['no_do'];
    tanggalDo = json['tanggal_do'];
    kodeProduk = json['kode_produk'];
    namaProduk = json['nama_produk'];
    qtyDo = json['qty_do'];
    uom = json['uom'];
    noTransaksi = json['no_transaksi'];
    noSpj = json['no_spj'];
    tanggalSpj = json['tanggal_spj'];
    jamSpj = json['jam_spj'];
    noSpss = json['no_spss'];
    noPolisi = json['no_polisi'];
    namaSopir = json['nama_sopir'];
    kodeDistributor = json['kode_distributor'];
    distributor = json['distributor'];
    kodeShipto = json['kode_shipto'];
    namaShipto = json['nama_shipto'];
    alamatShipto = json['alamat_shipto'];
    kodeDistrik = json['kode_distrik'];
    distrik = json['distrik'];
    kodeKecamatan = json['kode_kecamatan'];
    namaKecamatan = json['nama_kecamatan'];
    kodeEkspeditur = json['kode_ekspeditur'];
    ekspeditur = json['ekspeditur'];
    kodePlant = json['kode_plant'];
    namaPlant = json['nama_plant'];
    namaKapal = json['nama_kapal'];
    status = json['status'];
    statusPenerimaan = json['status_penerimaan'];
    lineSo = json['line_so'];
    nomerPo = json['nomer_po'];
    tanggalAntri = json['tanggal_antri'];
    jamAntri = json['jam_antri'];
    tanggalMasuk = json['tanggal_masuk'];
    jamMasuk = json['jam_masuk'];
    supplierId = json['supplier_id'];
    warehouseId = json['warehouse_id'];
    billerId = json['biller_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    note = json['note'];
    attachment = json['attachment'];
    total = json['total'];
    productDiscount = json['product_discount'];
    orderDiscountId = json['order_discount_id'];
    orderDiscount = json['order_discount'];
    totalDiscount = json['total_discount'];
    productTax = json['product_tax'];
    orderTaxId = json['order_tax_id'];
    orderTax = json['order_tax'];
    totalTax = json['total_tax'];
    shipping = json['shipping'];
    grandTotal = json['grand_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_code'] = this.companyCode;
    data['company_name'] = this.companyName;
    data['no_pp'] = this.noPp;
    data['tanggal_pp'] = this.tanggalPp;
    data['no_kontrak'] = this.noKontrak;
    data['no_so'] = this.noSo;
    data['tipe_order'] = this.tipeOrder;
    data['tanggal_so'] = this.tanggalSo;
    data['incotrem'] = this.incotrem;
    data['no_do'] = this.noDo;
    data['tanggal_do'] = this.tanggalDo;
    data['kode_produk'] = this.kodeProduk;
    data['nama_produk'] = this.namaProduk;
    data['qty_do'] = this.qtyDo;
    data['uom'] = this.uom;
    data['no_transaksi'] = this.noTransaksi;
    data['no_spj'] = this.noSpj;
    data['tanggal_spj'] = this.tanggalSpj;
    data['jam_spj'] = this.jamSpj;
    data['no_spss'] = this.noSpss;
    data['no_polisi'] = this.noPolisi;
    data['nama_sopir'] = this.namaSopir;
    data['kode_distributor'] = this.kodeDistributor;
    data['distributor'] = this.distributor;
    data['kode_shipto'] = this.kodeShipto;
    data['nama_shipto'] = this.namaShipto;
    data['alamat_shipto'] = this.alamatShipto;
    data['kode_distrik'] = this.kodeDistrik;
    data['distrik'] = this.distrik;
    data['kode_kecamatan'] = this.kodeKecamatan;
    data['nama_kecamatan'] = this.namaKecamatan;
    data['kode_ekspeditur'] = this.kodeEkspeditur;
    data['ekspeditur'] = this.ekspeditur;
    data['kode_plant'] = this.kodePlant;
    data['nama_plant'] = this.namaPlant;
    data['nama_kapal'] = this.namaKapal;
    data['status'] = this.status;
    data['status_penerimaan'] = this.statusPenerimaan;
    data['line_so'] = this.lineSo;
    data['nomer_po'] = this.nomerPo;
    data['tanggal_antri'] = this.tanggalAntri;
    data['jam_antri'] = this.jamAntri;
    data['tanggal_masuk'] = this.tanggalMasuk;
    data['jam_masuk'] = this.jamMasuk;
    data['supplier_id'] = this.supplierId;
    data['warehouse_id'] = this.warehouseId;
    data['biller_id'] = this.billerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['note'] = this.note;
    data['attachment'] = this.attachment;
    data['total'] = this.total;
    data['product_discount'] = this.productDiscount;
    data['order_discount_id'] = this.orderDiscountId;
    data['order_discount'] = this.orderDiscount;
    data['total_discount'] = this.totalDiscount;
    data['product_tax'] = this.productTax;
    data['order_tax_id'] = this.orderTaxId;
    data['order_tax'] = this.orderTax;
    data['total_tax'] = this.totalTax;
    data['shipping'] = this.shipping;
    data['grand_total'] = this.grandTotal;
    return data;
  }
}
