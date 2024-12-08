import 'package:eventifyQr/shared_Preference.dart';
import 'package:http/http.dart' as http;
import 'popup_helper.dart';

class CustomHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    var token = await GetPreference('token').then((r) => r);

    // Check if token is null and show alert
    if (token == "guest") {
      PopupHelper.showTokenNotFoundError();
      // Return a dummy response to avoid sending the request
    }

    // Apply middleware logic here
    if (token != null) {
      request.headers['token'] = token;
    }
    request.headers['Content-Type'] = 'application/json';

    // Send the modified request using the inner client
    return _inner.send(request);
  }
}
