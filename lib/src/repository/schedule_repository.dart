import 'package:academic_system/src/constant/api_url.dart';
import 'package:academic_system/src/helper/jwt_refresher.dart';
import 'package:academic_system/src/helper/secure_storage.dart';
import 'package:academic_system/src/model/schedule.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ScheduleRepository {
  Future<List<Schedule>> getStudentSchedules(
      {required String id, required String day}) async {
    Uri url = Uri.parse('$apiUrl/student/schedules');

    var response = await post(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await SecureStorage.getToken('jwt')}',
      },
      body: {
        'id': id,
        'day': day,
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
          ? await getStudentSchedules(id: id, day: day)
          : [];
    }

    return [];
  }

  Future<List<Schedule>> getLecturerSchedules(
      {required String id, required String day}) async {
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
          ? await getLecturerSchedules(id: id, day: day)
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

  Future<List<Schedule>> getAllSchedule() async {
    Uri url = Uri.parse('$apiUrl/all_schedules');

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
          ? await getAllSchedule()
          : [];
    }

    return [];
  }
}
