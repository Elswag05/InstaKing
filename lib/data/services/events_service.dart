import 'package:dio/dio.dart' show Response;
import 'package:insta_king/data/services/dio_mixin.dart';

class EventService with DioMixin {
  Future<Response<dynamic>> fetchEvents() async {
    return await sendRequest(() {
      return connect().get(
        '/events',
      );
    });
  }
}
