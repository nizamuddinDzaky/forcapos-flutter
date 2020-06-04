class Zone {
  String provinceCode;
  String kabupatenCode;
  String kecamatanCode;
  String lat;
  String lng;
  String provinceName;
  String kabupatenName;
  String kecamatanName;
  String txt;
  String idWilayah;

  Zone(
      {this.provinceCode,
        this.kabupatenCode,
        this.kecamatanCode,
        this.lat,
        this.lng,
        this.provinceName,
        this.kabupatenName,
        this.kecamatanName,
        this.txt,
        this.idWilayah});

  Zone.fromJson(Map<String, dynamic> json) {
    provinceCode = json['province_code'];
    kabupatenCode = json['kabupaten_code'];
    kecamatanCode = json['kecamatan_code'];
    lat = json['lat'];
    lng = json['lng'];
    provinceName = json['province_name'];
    kabupatenName = json['kabupaten_name'];
    kecamatanName = json['kecamatan_name'];
    txt = json['txt'];
    idWilayah = json['id_wilayah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_code'] = this.provinceCode;
    data['kabupaten_code'] = this.kabupatenCode;
    data['kecamatan_code'] = this.kecamatanCode;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['province_name'] = this.provinceName;
    data['kabupaten_name'] = this.kabupatenName;
    data['kecamatan_name'] = this.kecamatanName;
    data['txt'] = this.txt;
    data['id_wilayah'] = this.idWilayah;
    return data;
  }

  toProvince() {
    txt = provinceName;
  }

  toCity() {
    txt = kabupatenName;
  }

  toState() {
    txt = kecamatanName;
  }

  @override
  String toString() {
    return txt ?? '~';
  }
}
