import 'package:dio/dio.dart';
import '../utils/constants.dart';
import '../utils/failure.dart';

class ResponseCode {
  static const String invalidemail = INVALIDEMAIL;
  static const String userdisabled = USERDISABLED;
  static const String usernotfound = USERNOTFOUND;
  static const String wrongpassword = WRONGPASSWORD;
  static const String unknown = UNKNOWN;
  static const String networkfailed = NETWORKREQUESTFAILED;
  static const String weakpassword = WEAKPASSWORD;
  static const String channelerror = CHANNELERROR;
  static const String emailinuse = EMAILALREADYEXIST;
}

class ResponseMessage {
  static const String invalidemail = INVALIDEMAILRESPONSE;
  static const String userdisabled = USERDISABLEDRESPONSE;
  static const String usernotfound = USERNOTFOUNDRESPONSE;
  static const String wrongpassword = WRONGPASSWORDRESPONSE;
  static const String unknown = UNKNOWNRESPONSE;
  static const String networkfailed = NETWORKREQUESTFAILEDRESPONSE;
  static const String weakpassword = WEAKPASSWORDRESPONSE;
  static const String channelerror = CHANNELERRORRESPONSE;
  static const String emailinuse = EMAILALREADYEXISTRESPONSE;
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      failure = _handleDioError(error);
    }
    // if (error is FirebaseAuthException) {
    //   failure = _handleError(error);
    // }
  }
}

// Failure _handleError(FirebaseAuthException error) {
//   switch (error.code) {
//     case INVALIDEMAIL:
//       return Failure(message: ResponseMessage.invalidemail);
//     case USERDISABLED:
//       return Failure(message: ResponseMessage.userdisabled);
//     case USERNOTFOUND:
//       return Failure(message: ResponseMessage.usernotfound);
//     case WRONGPASSWORD:
//       return Failure(message: ResponseMessage.wrongpassword);
//     case NETWORKREQUESTFAILED:
//       return Failure(message: ResponseMessage.networkfailed);
//     case CHANNELERROR:
//       return Failure(message: ResponseMessage.channelerror);
//     case EMAILALREADYEXIST:
//       return Failure(message: ResponseMessage.emailinuse);
//     default:
//       return Failure(message: ResponseMessage.unknown);
//   }
// }

Failure _handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return Failure(message: 'Connection Timeout');
    case DioExceptionType.connectionError:
      return Failure(message: 'Connection Timeout');
    case DioExceptionType.unknown:
      return Failure(
        message:
            'The connection to the internet has been lost. Please try again',
      );
    case DioExceptionType.badResponse:
      return Failure(
        message: (error.response!.data as Map<String, dynamic>)['message'],
      );
    case DioExceptionType.badCertificate:
      return Failure(
        message: (error.response!.data as Map<String, dynamic>)['message'],
      );
    case DioExceptionType.sendTimeout:
      return Failure(
        message: (error.response!.data as Map<String, dynamic>)['message'],
      );
    default:
      return Failure(message: 'Unknown Error');
  }
}