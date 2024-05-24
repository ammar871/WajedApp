import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wajed_app/common/auth/data/models/user_response.dart';
import '../../common/auth/data/models/auth_response.dart';
import '../../common/auth/data/models/login_request_body.dart';
import '../../common/auth/data/models/signup_request_body.dart';
import '../utils/api_constatns.dart';
part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.checkUserPath)
  Future<AuthResponse> checkUsername(@Body() String userName);

  @POST(ApiConstants.signUpPath)
  Future<AuthResponse> signUp(@Body() SignUpRequestBody signUpRequestBody);

  @POST(ApiConstants.loginPath)
  Future<UserResponse> loginUser(@Body() LoginReqeustBody loginReqeustBody);

  // Future<AuthResponse> checkUsername(String username);
}
