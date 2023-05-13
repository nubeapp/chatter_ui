import 'dart:convert';

import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/services/order_service_interface.dart';
import 'package:http/http.dart' as http;

class OrderService implements IOrderService {
  static String get API_BASE_URL => 'http://0.0.0.0:8000/tickets';
  final http.Client client;

  OrderService({required this.client});

  @override
  Future<List<Order>> getOrdersByUserId() async {
    final response = await client.get(Uri.parse(API_BASE_URL));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get tickets');
    }
  }
}
