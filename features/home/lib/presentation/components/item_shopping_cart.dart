import 'package:common/extension/extension.dart';
import 'package:core/network/api_constant.dart';
import 'package:dependencies/iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/components/qty_counter.dart';
import 'package:pos/data/models/item_cart.dart';

class ItemShoppingCart extends StatelessWidget {
  final ItemCart data;
  final Function(int qty) onQtyChanged;
  final Function(int? productId) onDeleteItemCart;

  const ItemShoppingCart({
    super.key,
    required this.data,
    required this.onQtyChanged,
    required this.onDeleteItemCart,
  });

  @override
  Widget build(BuildContext context) {
    final qty = data.qty ?? 0;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: 82,
            width: 98,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${ApiConstant.baseUrl}/${data.imagePath}',
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    data.name ?? '',
                  ),
                ),
                Flexible(
                  child: Text(
                    data.price.convertToCurrency(),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                qty > 0
                    ? Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  onDeleteItemCart(data.productId);
                                },
                                mouseCursor: SystemMouseCursors.click,
                                child: const Iconify(
                                  Ph.trash_light,
                                  size: 20,
                                  color: Colors.redAccent,
                                ),
                              ),
                              QtyCounter(
                                value: qty,
                                onAddition: () => onQtyChanged(1),
                                onSubtraction: () => onQtyChanged(-1),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
