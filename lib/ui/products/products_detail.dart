import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/data/client/products_api_client.dart';
import 'package:on_woori/data/entity/response/products/products_detail_response.dart';
import 'package:on_woori/data/entity/response/products/products_response.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class ProductsDetailPage extends StatelessWidget {
  final String productId;
  ProductsDetailPage(this.productId);

  @override
  Widget build(BuildContext context) {
    final li0n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(li0n!.productDetailTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
        actions: [
          IconButton(onPressed: (){
            context.push('/wish/cart');
          }, icon: Icon(Icons.shopping_bag_outlined))
        ],
      ),
      body: Row(
        children: [
          SizedBox(width: 24,),
          Expanded(child: ProductsDetailScreen(productId)),
          SizedBox(width: 24,),
        ],
      ),
    );
  }
}

class ProductsDetailScreen extends StatefulWidget {
  String id;

  ProductsDetailScreen(this.id);

  @override
  State<StatefulWidget> createState() {
    return ProductsDetailScreenState();
  }
}

class ProductsDetailScreenState extends State<ProductsDetailScreen> {
  final apiClient = ProductsApiClient();
  late Future<ProductsDetailResponse> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _initializeData();
  }

  var icon = Icons.circle_outlined;
  int quantity = 1;
  int totalPrice = 0;
  String? color;
  String? size;
  bool isFavorite = false;
  List<String> sizeOptions = ["사이즈 옵션"];
  List<String> colorOptions = ["컬러 옵션"];

  Future<ProductsDetailResponse> _initializeData() async {
    return apiClient.productDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var li0n = AppLocalizations.of(context);
    return FutureBuilder(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (snapshot.hasError) {
          return Center(child: Text("오류 발생: ${snapshot.error}"),);
        }

        if (!snapshot.hasData) {
          return const Center(child: Text("데이터가 없습니다."),);
        }

        final ProductItem? data = snapshot.data?.data;

        if (data?.isFavorite != null) {
          if (data!.isFavorite) {
            icon = Icons.circle;
          }
        }

        return ListView(
          addAutomaticKeepAlives: true,
          children: [
            SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage(data?.images?.main ?? ""),
                          fit: BoxFit.cover
                      )
                  ),
                ),
              ),
            ),
            Divider(color: Colors.black, thickness: 1, height: 1,),
            SizedBox(height: 10,),
            Row(children: [
              ProductsNameSection(
                data?.stockType ?? "카테고리",
                data?.name ?? "상품명",
                data?.price ?? 1000,
                data?.discount ?? 0,
              ),
              Spacer(),
              GestureDetector(
                child: Icon(icon, size: 30,),
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                    if (isFavorite) {
                      icon = Icons.circle_outlined;
                    } else {
                      icon = Icons.circle;
                    }
                  });
                },
              ),
            ],),
            Divider(color: Colors.black,),
            Row(
              children: [
                CircleAvatar(backgroundColor: AppColors.primary, radius: 16,), //TODO: 이미지 넣을 것
                SizedBox(width: 10,),
                Text(data?.store?.name ?? "브랜드")
              ],
            ),
            Divider(color: Colors.black,),
            SizedBox(height: 20,),
            ProductsDetailImageSection(data?.images?.detail ?? []),
            SizedBox(height: 20,),
            Divider(color: Colors.black,),
            Container( //사이즈 옵션
                color: AppColors.optionStateList,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: size ?? sizeOptions[0],
                      items: sizeOptions.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e, style: TextStyle(fontSize: 16),),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          size = value!;
                        });
                      },
                      menuWidth: double.infinity,
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                    ),
                  ),
                )
            ),
            SizedBox(height: 5,),
            Container( //컬러 옵션
                width: double.infinity,
                color: AppColors.optionStateList,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: color ?? colorOptions[0],
                        items: colorOptions.map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e, style: TextStyle(fontSize: 16),),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            color = value!;
                          });
                        },
                        menuWidth: double.infinity,
                        isExpanded: true,
                        icon: Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                      ),
                    )
                )
            ),
            SizedBox(height: 5,),
            Container( //총합산
              color: AppColors.optionStateList,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data?.name ?? "상품명", style: TextStyle(fontSize: 16),),
                        Text(size ?? "사이즈 옵션", style: TextStyle(fontSize: 13, color: AppColors.grey),),
                        Text(color ?? "컬러 옵션", style: TextStyle(fontSize: 13, color: AppColors.grey),)
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Text("${quantity * (data?.price ?? 0)}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                      ),
                      Row( //수량변경 파트
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity -= 1;
                                }
                              });
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(36, 36)
                            ),
                            child: Icon(Icons.remove, color: Colors.black,),
                          ),
                          Text("$quantity", style: TextStyle(fontSize: 20,),),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            },
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(36, 36)
                            ),
                            child: Icon(Icons.add, color: Colors.black,),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {}, //TODO: 장바구니에 추가
                child: Text(li0n!.cart, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: AppColors.primary
                ),
              ),
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {}, //TODO: 주문 생성
                child: Text(li0n!.order, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: AppColors.primary
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        );
      },
    );
  }
}

class ProductsNameSection extends StatelessWidget { //상품 이름 위젯 할인유무에 따라 리턴
  late bool discount;
  String category;
  String productName;
  int originalPrice;
  int discountRate;

  ProductsNameSection(
      this.category,
      this.productName,
      this.originalPrice,
      this.discountRate
  );

  @override
  Widget build(BuildContext context) {
    if (discountRate == 0) { discount = false; } else { discount = true; }

    if (discount) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: TextStyle(fontSize: 10),),
          SizedBox(height: 2,),
          Text(productName, style: TextStyle(fontSize: 16),),
          SizedBox(height: 2,),
          Text("$originalPrice", style: TextStyle(fontSize: 10, decoration: TextDecoration.lineThrough),),
          SizedBox(height: 2,),
          Row(
            children: [
              Text("$discountRate%", style: TextStyle(fontSize: 13, color: Colors.red),),
              SizedBox(width: 5,),
              Text("${originalPrice - originalPrice * (100 * discountRate)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
            ],
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: TextStyle(fontSize: 10),),
        SizedBox(height: 2,),
        Text(productName, style: TextStyle(fontSize: 16),),
        SizedBox(height: 2,),
        Text("$originalPrice", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      ],
    );
  }
}

class ProductsDetailImageSection extends StatelessWidget { //디테일 이미지 쭉 이어서 리턴
  List<String> detailImageUrl;
  ProductsDetailImageSection(this.detailImageUrl);

  @override
  Widget build(BuildContext context) {
    List<Widget> images = [];
    for (int i = 0; i < detailImageUrl.length; i++) {
      images.add(Image(image: NetworkImage(detailImageUrl[i])));
    }
    return Column(children: images,);
  }
}