import 'package:http/http.dart' as http;
import 'package:ui/domain/services/api_service_interface.dart';
import 'package:ui/presentation/styles/logger.dart';

class ApiService implements IApiService {
  ApiService();

  static String get API_BASE_URL => 'http://0.0.0.0:8000/';

  @override
  Future<void> connectAPI() async {
    try {
      final response = await http.get(Uri.parse(API_BASE_URL));
      if (response.statusCode == 200) {
        Logger.info('Server is running...');
      } else {
        Logger.error('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      Logger.error('Error: $e');
    }
  }
}
