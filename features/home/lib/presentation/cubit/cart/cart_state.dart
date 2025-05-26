import 'package:dependencies/equatable/equatable.dart';
import 'package:pos/data/models/cart.dart';
import 'package:pos/data/models/checkout_body.dart';
import 'package:pos/data/models/checkout_item_body.dart';
import 'package:pos/data/models/item_cart.dart';

class CartState extends Equatable {
  final int? id;
  final List<ItemCart>? items;
  final String? orderId;
  final double? subtotal;
  final double? total;
  final double? tax;
  final int? taxPercentage;
  final CheckoutBody? checkoutBody;
  final bool isCartEmpty;
  final bool initialLoading;

  const CartState({
    this.id,
    this.items,
    this.orderId,
    this.subtotal,
    this.total,
    this.tax,
    this.taxPercentage,
    this.checkoutBody,
    this.isCartEmpty = true,
    this.initialLoading = true,
  });

  CartState updateState({
    required Cart cart,
    bool initialLoading = true,
  }) {
    return copyWih(
      id: cart.id,
      items: cart.items ?? [],
      orderId: cart.orderId,
      subtotal: cart.subtotal,
      total: cart.total,
      tax: cart.tax,
      taxPercentage: cart.taxPercentage,
      initialLoading: initialLoading,
    );
  }

  CartState copyWih({
    int? id,
    List<ItemCart>? items,
    String? orderId,
    double? subtotal,
    double? total,
    double? tax,
    int? taxPercentage,
    bool? initialLoading,
  }) {
    return CartState(
      id: id ?? this.id,
      items: items ?? this.items,
      orderId: orderId ?? this.orderId,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      tax: tax ?? this.tax,
      taxPercentage: taxPercentage ?? this.taxPercentage,
      checkoutBody: CheckoutBody(
        cartId: id ?? this.id,
        items: (items ?? this.items)
                ?.map(
                  (e) => CheckoutItemBody(
                    productId: e.productId,
                    qty: e.qty ?? 0,
                  ),
                )
                .toList() ??
            [],
      ),
      isCartEmpty: (items ?? this.items)?.isEmpty ?? true,
      initialLoading: initialLoading ?? this.initialLoading,
    );
  }

  @override
  List<Object?> get props => [
        id,
        items,
        orderId,
        subtotal,
        total,
        tax,
        taxPercentage,
        checkoutBody,
        isCartEmpty,
        initialLoading,
      ];
}
