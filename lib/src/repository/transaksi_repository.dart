import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/histori_transaksi.dart';
import 'package:http/http.dart';
import 'dart:convert';

class TransaksiRepository {
  Future<String> createCharge(
      String idTagihanPerkuliahan, String nim, String totalTagihan) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/charge');

    var response = await post(
      url,
      body: {
        'id_pembayaran_kuliah': idTagihanPerkuliahan,
        'nim': nim,
        'gross_amount': totalTagihan,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      return 'Transaksi berhasil dibuat';
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await createCharge(idTagihanPerkuliahan, nim, totalTagihan)
          : 'Transaksi gagal dibuat';
    }

    return 'Transaksi gagal dibuat';
  }

  Future<List<HistoriTransaksi>> getAllListHistoriTransaksi(String nim) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/mahasiswa/transaksi/histori');

    var response = await post(
      url,
      body: {
        'nim': nim,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List;

      return jsonResponse
          .map((json) => HistoriTransaksi.createFromJson(json))
          .toList();
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getAllListHistoriTransaksi(nim)
          : [];
    }

    return [];
  }

  Future<String> refreshStatusTransaksi(
    String idTagihanPerkuliahan,
    String idOrder,
  ) async {
    String? jwt = await SecureStorage.getToken('jwt');

    Uri url = Uri.parse('$apiUrl/mahasiswa/pembayaran/status');

    var response = await post(
      url,
      body: {
        'id_pembayaran_kuliah': idTagihanPerkuliahan,
        'id_order': idOrder,
      },
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      return 'Refresh status berhasil';
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await refreshStatusTransaksi(idTagihanPerkuliahan, idOrder)
          : 'Refresh status gagal';
    }

    return 'Refresh status gagal';
  }
}
