import 'package:http/http.dart' as http;
import 'package:ui/domain/services/api_service_interface.dart';
import 'package:ui/presentation/styles/logger.dart';

class ApiService implements IApiService {
  ApiService({required this.client});

  static String get API_BASE_URL => 'https://fastapi-course-o7v1.onrender.com';
  final http.Client client;

  @override
  Future<String> connectAPI() async {
    try {
      final response = await client.get(Uri.parse(API_BASE_URL));
      if (response.statusCode == 200) {
        Logger.info('Server is running...');
        return 'Server is running...';
      } else {
        Logger.error('Request failed with status: ${response.statusCode}.');
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      Logger.error('Error: $e');
      throw Exception('Error: $e');
    }
  }
}
