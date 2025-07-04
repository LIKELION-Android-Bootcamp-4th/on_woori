import 'package:flutter/material.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';
import 'package:on_woori/widgets/bottom_button.dart';
import 'package:on_woori/widgets/cart_list_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ListView.separated(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return CartListItem(
                    productName: "상품명",
                    price: 1680000,
                    productCount: 1,
                    option: "옵션",
                    imageUrl:
                        "https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg",
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(color: Color(0xFFC9C9C9)),
              ),
            ),
            // 하단 버튼
            BottomButton(buttonText: "0원 결제하기", pressedFunc: (){}),
          ],
        ),
      ),
    );
  }
}
