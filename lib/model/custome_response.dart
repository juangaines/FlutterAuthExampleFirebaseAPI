import 'package:firebase_api_example_auth/model/error_firebase.dart';

class CustomeResponse {
  ErrorResponse error;
  dynamic object;
  CustomeResponse(this.error, this.object);
}
