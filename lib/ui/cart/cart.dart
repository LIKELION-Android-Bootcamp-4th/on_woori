import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/data/client/cart_api_client.dart';
import 'package:on_woori/data/entity/request/cart/cart_request.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cartFuture = _fetchCartData();
  }

  Future<CartResponse> _fetchCartData() async {
    try {
      final response = await CartApiClient().getCart();
      return response;
    } catch (e, s) {
      debugPrint("장바구니 조회 오류: $e");
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }

  Future<void> _deleteCartItem(String cartId) async {
    setState(() => _isLoading = true);

    try {
      final requestBody = CartRequest(cartIds: [cartId]);
      await CartApiClient().deleteCart(request: requestBody);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('상품이 장바구니에서 삭제되었습니다.')),
        );
      }
      _refreshCart();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('삭제에 실패했습니다: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _refreshCart() {
    setState(() {
      _cartFuture = _fetchCartData();
    });
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
      body: Stack(
        children: [
          FutureBuilder<CartResponse>(
            future: _cartFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting && !_isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("오류가 발생했습니다.\n${snapshot.error}"));
              }
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
                            imageUrl: cartItem.product.thumbnailImage ?? 'https://via.placeholder.com/150',
                            onDelete: () => _deleteCartItem(cartItem.id),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(color: Color(0xFFC9C9C9)),
                      ),
                    ),
                    BottomButton(
                      buttonText: "${cartResponse.grandTotal}원 결제하기",
                      pressedFunc: () {
                        context.go('/orderlist');
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}