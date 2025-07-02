import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';
import 'package:on_woori/l10n/app_localizations.dart';

class ProductsDetailPage extends StatelessWidget {
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
          Expanded(child: ProductsDetailScreen( //TODO: API 적용하여 정보 받아오기 - 이미지, 텍스트 등
            1000,
            "상품 이름",
            "브랜드 이름",
            "https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg",
            ["https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg", "https://image.utoimage.com/preview/cp872722/2022/12/202212008462_500.jpg"],
            true,
            "카테고리",
            ["빨", "주", "노"],
            ["S", "M", "L", "XL"],
            discountRate: 10,
          )),
          SizedBox(width: 24,)
        ],
      ),
    );
  }
}

class ProductsDetailScreen extends StatefulWidget {
  //DTO 만들어서 클래스로 정보 전달하는 게 나을 듯
  //API 적용 전까지는 테스트를 위해 하나하나 입력함
  int price;
  String productName;
  String brandName;
  String mainImageUrl;
  List<String> detailImageUrl;
  bool isFavorite;

  String category;
  int discountRate;

  List<String> sizeOptions;
  List<String> colorOptions;

  ProductsDetailScreen(
      this.price,
      this.productName,
      this.brandName,
      this.mainImageUrl,
      this.detailImageUrl,
      this.isFavorite,
      this.category,
      this.sizeOptions,
      this.colorOptions,
      {this.discountRate = 0}
  );

  @override
  State<StatefulWidget> createState() {
    return ProductsDetailScreenState();
  }
}

class ProductsDetailScreenState extends State<ProductsDetailScreen> {
  late int price;
  late String productName;
  late String brandName;
  late String mainImageUrl;
  late List<String> detailImageUrl;
  late bool isFavorite;
  late String category;
  late int discountRate;
  late int discountPrice;
  bool isDiscount = false;
  late List<String> sizeOptions;
  late List<String> colorOptions;

  @override
  void initState() {
    super.initState();
    price = widget.price;
    productName = widget.productName;
    brandName = widget.brandName;
    mainImageUrl = widget.mainImageUrl;
    detailImageUrl = widget.detailImageUrl;
    isFavorite = widget.isFavorite;
    category = widget.category;
    discountRate = widget.discountRate;
    discountPrice = widget.price;
    if (widget.discountRate != 0) {
      isDiscount = true;
      discountPrice = (price - (price * (discountRate / 100))).toInt();
    }
    sizeOptions = widget.sizeOptions;
    colorOptions = widget.colorOptions;
  }

  var icon = Icons.circle;
  int quantity = 1;
  String? color;
  String? size;

  @override
  Widget build(BuildContext context) {
    var li0n = AppLocalizations.of(context);

    return ListView(
      children: [
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      image: DecorationImage(image: NetworkImage(mainImageUrl), fit: BoxFit.cover)
                  ),
                ),
              ),
            ),
            Divider(color: Colors.black, thickness: 1, height: 1,),
            SizedBox(height: 10,),
            Row(children: [
              ProductsNameSection(
                category,
                productName,
                "$price",
                "$discountRate%",
                "$discountPrice",
                discount: isDiscount,
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
                Text(brandName)
              ],
            ),
            Divider(color: Colors.black,),
            SizedBox(height: 20,),
            ProductsDetailImageSection(detailImageUrl),
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
                        Text(productName, style: TextStyle(fontSize: 16),),
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
                        child: Text(li0n!.productPrice, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
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
                child: Text(li0n.cart, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
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
                child: Text(li0n.order, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    backgroundColor: AppColors.primary
                ),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ],
    );
  }
}

class ProductsNameSection extends StatelessWidget { //상품 이름 위젯 할인유무에 따라 리턴
  bool discount;
  String category;
  String productName;
  String originalPrice;
  String discountRate;
  String discountPrice;

  ProductsNameSection(
      this.category,
      this.productName,
      this.originalPrice,
      this.discountRate,
      this.discountPrice,
      {this.discount = false}
  );

  @override
  Widget build(BuildContext context) {
    if (discount) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: TextStyle(fontSize: 10),),
          SizedBox(height: 2,),
          Text(productName, style: TextStyle(fontSize: 16),),
          SizedBox(height: 2,),
          Text(originalPrice, style: TextStyle(fontSize: 10, decoration: TextDecoration.lineThrough),),
          SizedBox(height: 2,),
          Row(
            children: [
              Text(discountRate, style: TextStyle(fontSize: 13, color: Colors.red),),
              SizedBox(width: 5,),
              Text(discountPrice, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
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
        Text(originalPrice, style: TextStyle(fontSize: 10, decoration: TextDecoration.lineThrough),),
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