import 'dart:convert';

import 'package:blood_donation/data/model/response/base/api_response.dart';
import 'package:blood_donation/data/repository/ketersediaan_repo.dart';
import 'package:flutter/foundation.dart';

class KetersediaanProvider extends ChangeNotifier {
  final KetersediaanRepo ketersediaanRepo;

  KetersediaanProvider({@required this.ketersediaanRepo});

  bool _isLoading = false;
  String _pengajuanDarah = '';
  bool _stokPengajuan = false;
  String _rekomendasiDarah = '';
  bool _stokRekomendasi = false;

  bool get isLoading => _isLoading;
  String get pengajuanDarah => _pengajuanDarah;
  bool get stokPengajuan => _stokPengajuan;
  String get rekomendasiDarah => _rekomendasiDarah;
  bool get stokRekomendasi => _stokRekomendasi;

  Future<void> getKetersediaan(int idDarah) async {
    _isLoading = true;
    _pengajuanDarah = null;
    _stokPengajuan = false;

    _rekomendasiDarah = null;
    _stokRekomendasi = false;
    ApiResponse apiResponse = await ketersediaanRepo.getKetersediaan(idDarah);
    if (apiResponse.response.statusCode == 200) {
      bool status = apiResponse.response.data['success'];
      final data = jsonDecode(jsonEncode(apiResponse.response.data['data']));

      final ketersediaan = data['ketersediaan'];
      final alternatif = data['alternatif'];

      if (status) {
        _pengajuanDarah = ketersediaan['golongan_darah'];
        _stokPengajuan = ketersediaan['stok'];

        _rekomendasiDarah = alternatif['golongan_darah'];
        _stokRekomendasi = alternatif['stok'];
      }

      _isLoading = false;
    }
    notifyListeners();
  }
}
