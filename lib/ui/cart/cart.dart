import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:on_woori/data/client/cart_api_client.dart';
import 'package:on_woori/data/entity/request/cart/cart_checkout_request.dart';
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
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);

    try {
      CartRequest request = CartRequest(cartIds: [cartId]);
      CartApiClient().deleteCart(request: request);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.cartItemDeletedSuccess)));
      }
      _refreshCart();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.cartItemDeleteFailed('$e'))));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _checkout(List<CartItem> cartItems) async {
    final l10n = AppLocalizations.of(context)!;
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.cartEmptyError)));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final cartIds = cartItems.map((item) => item.id).toList();
      final request = CartCheckoutRequest(cartIds: cartIds);
      final response = await CartApiClient().postCartCheckOut(request: request);

      if (mounted && response.success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.cartCheckoutSuccess)));
        context.go('/orderlist');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.cartCheckoutFailed(response.message))),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.cartCheckoutError('$e'))));
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
        title: Text(
          l10n.cartPageTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<CartResponse>(
            future: _cartFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting &&
                  !_isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                    child: Text(l10n.cartGenericError('${snapshot.error}')));
              }
              if (!snapshot.hasData ||
                  (snapshot.data!.data?.items?.isEmpty ?? true)) {
                return Center(child: Text(l10n.cartEmptyMessage));
              }

              final cartResponse = snapshot.data!;
              final cartItems = cartResponse.data!.items!;
              final formattedPrice =
              NumberFormat('#,###').format(cartResponse.grandTotal);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: cartItems.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          final cartItem = cartItems[index];
                          return CartListItem(
                            productName: cartItem.product.name,
                            price: cartItem.cartPrice,
                            productCount: cartItem.quantity,
                            option: cartItem.product.optionText,
                            imageUrl: cartItem.product.thumbnailImage?.url ??
                                'https://via.placeholder.com/150',
                            onDelete: () => _deleteCartItem(cartItem.id),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                        const Divider(color: Color(0xFFC9C9C9)),
                      ),
                    ),
                    BottomButton(
                      buttonText: l10n.cartCheckoutButton(formattedPrice),
                      pressedFunc: () => _checkout(cartItems),
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
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}