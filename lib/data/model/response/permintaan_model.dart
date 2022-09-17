class PermintaanModel {
  int _id;
  int _userId;
  String _namaOs;
  String _rsDirawat;
  String _macamDonor;
  String _tanggal;
  int _darahId;
  String _pengajuanDarah;
  bool _stokPengajuan;
  String _rekomendasiDarah;
  bool _stokRekomendasi;
  String _status;

  PermintaanModel(
    int id,
    int userId,
    String namaOs,
    String rsDirawat,
    String macamDonor,
    String tanggal,
    int darahId,
    String pengajuanDarah,
    bool stokPengajuan,
    String rekomendasiDarah,
    bool stokRekomendasi,
    String status,
  ) {
    this._id = id;
    this._userId = userId;
    this._namaOs = namaOs;
    this._rsDirawat = rsDirawat;
    this._macamDonor = macamDonor;
    this._tanggal = tanggal;
    this._darahId = darahId;
    this._pengajuanDarah = pengajuanDarah;
    this._stokPengajuan = stokPengajuan;
    this._rekomendasiDarah = rekomendasiDarah;
    this._stokRekomendasi = stokRekomendasi;
    this._status = status;
  }

  int get id => _id;
  int get userId => _userId;
  String get namaOs => _namaOs;
  String get rsDirawat => _rsDirawat;
  String get macamDonor => _macamDonor;
  String get tanggal => _tanggal;
  int get darahId => _darahId;
  String get pengajuanDarah => _pengajuanDarah;
  bool get stokPengajuan => _stokPengajuan;
  String get rekomendasiDarah => _rekomendasiDarah;
  bool get stokRekomendasi => _stokRekomendasi;
  String get status => _status;

  PermintaanModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _userId = json['user_id'];
    _namaOs = json['nama_os'];
    _rsDirawat = json['rs_dirawat'];
    _macamDonor = json['macam_donor'];
    _tanggal = json['tanggal'];
    _darahId = json['darah_id'];
    _pengajuanDarah = json['pengajuan_darah'];
    _stokPengajuan = json['stok_pengajuan'];
    _rekomendasiDarah = json['rekomendasi_darah'];
    _stokRekomendasi = json['stok_rekomendasi'];
    _status = json['status'].toString();
  }
}
