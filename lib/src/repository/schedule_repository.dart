import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/new_schedule.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ScheduleRepository {
  Future<List<Schedule>> getStudentSchedules({
    required String id,
    required String day,
    required String idKrs,
    required String tahunAkademik,
    required String semester,
  }) async {
    Uri url = Uri.parse('$apiUrl/student/schedules');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'id': id,
        'id_krs': idKrs,
        'day': day,
        'tahun_akademik': tahunAkademik,
        'semester': semester
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);

      List<Schedule> schedules = jsonResponse
          .map((schedule) => Schedule.createFromJson(schedule))
          .toList();

      return schedules;
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getStudentSchedules(
              id: id,
              day: day,
              idKrs: idKrs,
              tahunAkademik: tahunAkademik,
              semester: semester,
            )
          : [];
    }

    return [];
  }

  Future<List<Schedule>> getLecturerSchedules({
    required String id,
    required String day,
    required String tahunAkademik,
    required String semester,
  }) async {
    Uri url = Uri.parse('$apiUrl/lecturer/schedules');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'id': id,
        'day': day,
        'tahun_akademik': tahunAkademik,
        'semester': semester,
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);

      List<Schedule> schedules = jsonResponse
          .map((schedule) => Schedule.createFromJson(schedule))
          .toList();

      return schedules;
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getLecturerSchedules(
              id: id,
              day: day,
              tahunAkademik: tahunAkademik,
              semester: semester,
            )
          : [];
    }

    return [];
  }

  Future<List<Schedule>> getSchedulesByDay({required String day}) async {
    Uri url = Uri.parse('$apiUrl/schedules/$day');

    var response = await get(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);

      List<Schedule> schedules = jsonResponse
          .map((schedule) => Schedule.createFromJson(schedule))
          .toList();

      return schedules;
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getSchedulesByDay(day: day)
          : [];
    }

    return [];
  }

  Future<List<Schedule>> getAllSchedule(
    String tahunAkademik,
    String semester,
  ) async {
    Uri url = Uri.parse('$apiUrl/all_schedules');

    var response = await post(url, headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
    }, body: {
      'tahun_akademik': tahunAkademik,
      'semester': semester,
    });

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);

      List<Schedule> schedules = jsonResponse
          .map((schedule) => Schedule.createFromJson(schedule))
          .toList();

      return schedules;
    } else if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await getAllSchedule(
              tahunAkademik,
              semester,
            )
          : [];
    }

    return [];
  }

  Future<String> createNewSchedule(NewSchedule newSchedule) async {
    Uri url = Uri.parse('$apiUrl/create/schedule');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'new_schedule': jsonEncode(newSchedule),
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await createNewSchedule(newSchedule)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<String> updateSchedule(NewSchedule newSchedule) async {
    Uri url = Uri.parse('$apiUrl/update/schedule');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'new_schedule': jsonEncode(newSchedule),
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await updateSchedule(newSchedule)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<String> deleteSchedule(List<String> id) async {
    Uri url = Uri.parse('$apiUrl/delete/schedule');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'schedule_id': jsonEncode(id),
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await deleteSchedule(id)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<String> setJadwalKrs(
      String tanggalMulai, String tanggalSelesai) async {
    Uri url = Uri.parse('$apiUrl/set/jadwal_krs');

    String formattedTanggalMulai = tanggalMulai.split('-').reversed.join('-');
    String formattedTanggalSelesai =
        tanggalSelesai.split('-').reversed.join('-');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'tanggalMulai': formattedTanggalMulai,
        'tanggalSelesai': formattedTanggalSelesai,
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await setJadwalKrs(tanggalMulai, tanggalSelesai)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }

  Future<String> setTahunAkademik(String tahunAkademik, String semester) async {
    Uri url = Uri.parse('$apiUrl/set/tahun_akademik');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'tahunAkademik': tahunAkademik,
        'semester': semester,
      },
    );

    if (response.statusCode == 401) {
      return await JWTRefresher.refreshToken(response)
          ? await setJadwalKrs(tahunAkademik, semester)
          : 'session expired';
    }

    return jsonDecode(response.body)["message"];
  }
}
