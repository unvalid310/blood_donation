class DarahModel {
  String _id;
  String _darah;

  DarahModel(
    String id,
    String darah,
  ) {
    this._id = id;
    this._darah = darah;
  }

  String get id => _id;
  String get darah => _darah;

  DarahModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _darah = json['darah'];
  }
}

class StokDarahModel {
  bool _status;
  String _golonganDarah;
  bool _stok;

  StokDarahModel(
    bool status,
    String golonganDarah,
    bool stok,
  ) {
    this._status = status;
    this._golonganDarah = golonganDarah;
    this._stok = stok;
  }

  bool get status => _status;
  String get golonganDarah => _golonganDarah;
  bool get stok => _stok;

  StokDarahModel.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _golonganDarah = json['golongan_darah'];
    _stok = json['stok'];
  }
}
