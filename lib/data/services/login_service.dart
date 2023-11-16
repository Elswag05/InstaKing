import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class LoginService with DioMixin {
  Future<Response<dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response =
        await connect(customHeaders: customHeaders).post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    print(response.data);
    return response;
  }
}

class SignOutService with DioMixin {
  Future<Response<dynamic>> logOut() async {
    final header = {
      'Accept': 'application/json',
    };
    final response = await connect(customHeaders: header).get('/user/logout');
    return response;
  }
}

// class LoginApi extends StatelessWidget {
//   const LoginApi({super.key});

//   Future<List<dynamic>> fetchApi() async {
//     Dio dio = Dio();
//     var response = await dio.post(
//       'https://www.affiliate.instaking.store/user-api/auth/login',
//       data: json.encode({
//         'email': 'immadominion@gmail.com',
//         'password': '1234567890',
//       }),
//       options: Options(
//         headers: {
//           'Accept': 'application/json',
//           'Content-Type': 'application/json',
//           'Connection': 'keep-alive',
//         },
//       ),
//     );
//     print(response.data.toString());
//     return response.data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
