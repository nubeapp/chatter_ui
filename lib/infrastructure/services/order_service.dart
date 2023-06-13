import 'dart:convert';

import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/services/order_service_interface.dart';
import 'package:http/http.dart' as http;
import 'package:ui/presentation/styles/logger.dart';

class OrderService implements IOrderService {
  static String get API_BASE_URL => 'http://0.0.0.0:8000/orders';
  final http.Client client;

  OrderService({required this.client});

  @override
  Future<List<Order>> getOrdersByUserId() async {
    try {
      Logger.debug('Requesting orders...');
      final response = await client.get(Uri.parse(API_BASE_URL));

      if (response.statusCode == 200) {
        Logger.info('Orders have been retrieved successfully!');
        final jsonList = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        return jsonList.map((json) => Order.fromJson(json)).toList();
      } else {
        Logger.error('Failed to get orders');
        throw Exception('Failed to get orders');
      }
    } catch (e) {
      Logger.error('An error occurred while getting orders: $e');
      throw Exception('Failed to get orders');
    }
  }
}
