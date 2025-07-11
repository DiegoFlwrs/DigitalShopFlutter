import 'package:digital_shop/features/navigation/data/models/order/order_history_item.dart';
import 'package:digital_shop/features/navigation/data/models/payment/paymentHistoryItem.dart';
import 'package:digital_shop/features/navigation/domain/useCases/navegation_usecase.dart';
import 'package:flutter/material.dart';  

class OrderHistoryController extends ChangeNotifier {
  final NavegationUseCase useCase;

  OrderHistoryController({required this.useCase});

  // ========== ÓRDENES ==========
  List<OrderHistoryItem> _orders = [];
  List<OrderHistoryItem> get orders => _orders;

  bool _isLoadingOrders = false;
  bool get isLoadingOrders => _isLoadingOrders;

  String? _orderError;
  String? get orderError => _orderError;

  Future<void> loadOrders(int userId) async {
    _isLoadingOrders = true;
    _orderError = null;
    notifyListeners();

    try {
      _orders = await useCase.executeGetOrderHistory(userId);
      print("Órdenes: $_orders");
    } catch (e) {
      print(e);
      _orderError = 'No se pudo cargar el historial de pedidos';
    } finally {
      _isLoadingOrders = false;
      notifyListeners();
    }
  }

  // ========== PAGOS ==========
  List<PaymentHistoryItem> _payments = [];
  List<PaymentHistoryItem> get payments => _payments;

  bool _isLoadingPayments = false;
  bool get isLoadingPayments => _isLoadingPayments;

  String? _paymentError;
  String? get paymentError => _paymentError;

  Future<void> loadPayments(int userId) async {
    _isLoadingPayments = true;
    _paymentError = null;
    notifyListeners();

    try {
      _payments = await useCase.getPaymentHistory(userId);
      print("Pagos: $_payments");
    } catch (e) {
      print(e);
      _paymentError = 'No se pudo cargar el historial de pagos';
    } finally {
      _isLoadingPayments = false;
      notifyListeners();
    }
  }
}
