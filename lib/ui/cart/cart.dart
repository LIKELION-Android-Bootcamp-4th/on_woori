import 'package:flutter/material.dart';
import 'package:on_woori/data/client/cart_api_client.dart';
import 'package:on_woori/data/entity/response/cart/cart_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/bottom_button.dart';
import 'package:on_woori/widgets/cart_list_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<CartResponse> _cartFuture;

  @override
  void initState() {
    super.initState();
    _cartFuture = _fetchCartData();
  }

  Future<CartResponse> _fetchCartData() async {
    try {
      final response = await CartApiClient().cart();
      return response;
    } catch (e, s) {
      debugPrint("장바구니 조회 오류: $e");
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "장바구니",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: FutureBuilder<CartResponse>(
        future: _cartFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData || (snapshot.data!.data?.items?.isEmpty ?? true)) {
            return const Center(child: Text("장바구니가 비었습니다."));
          }
          final cartResponse = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cartResponse.data!.items!.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final cartItem = cartResponse.data!.items![index];

                      return CartListItem(
                        productName: cartItem.product.name,
                        price: cartItem.cartPrice,
                        productCount: cartItem.quantity,
                        option: cartItem.product.optionText,
                        imageUrl: cartItem.product.thumbnailImage ?? 'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg',
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(color: Color(0xFFC9C9C9)),
                  ),
                ),
                BottomButton(
                  buttonText: "${cartResponse.grandTotal}원 결제하기",
                  pressedFunc: () {
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}