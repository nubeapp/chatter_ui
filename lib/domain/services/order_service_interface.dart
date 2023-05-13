import 'package:ui/domain/entities/order.dart';

abstract class IOrderService {
  Future<List<Order>> getOrdersByUserId();
}
