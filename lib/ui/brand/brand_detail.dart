 import 'package:flutter/material.dart';
 import 'package:on_woori/core/styles/app_colors.dart';
 import 'package:on_woori/data/api_client.dart';
import 'package:on_woori/data/client/fundings_api_client.dart';
 import 'package:on_woori/data/client/stores_api_client.dart';
 import 'package:on_woori/data/entity/response/fundings/fundings_response.dart';
 import 'package:on_woori/data/entity/response/stores/stores_response.dart';
 import 'package:on_woori/l10n/app_localizations.dart';
 import 'package:on_woori/ui/products/products_detail.dart';
 import 'package:on_woori/widgets/category_horizontal_scroll.dart';
 import 'package:on_woori/widgets/funding_list_item.dart';
 import 'package:on_woori/widgets/products_double_grid.dart';
 import 'package:on_woori/widgets/products_grid_item.dart';

 import '../../data/entity/response/products/products_response.dart';

 class BrandDetailPage extends StatelessWidget {
   String brandId;
   BrandDetailPage(this.brandId);

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(),
       body: SingleChildScrollView(
         child: Column(
           children: [
             BrandDetailScreen(brandId),
             BrandProductScreen(brandId)
           ],
         ),
       )
     );
   }
 }

 class BrandDetailScreen extends StatefulWidget {
   String id;
   BrandDetailScreen(this.id);

   @override
   State<StatefulWidget> createState() {
     return BrandDetailScreenState();
   }
 }

 class BrandDetailScreenState extends State<BrandDetailScreen> {
   final apiClient = StoresApiClient();
   late Future<StoreDetailResponse> _storesFuture;
   Future<StoreDetailResponse> _initializeData() async {
     return apiClient.storeDetail(widget.id);
   }

   @override
   void initState() {
     super.initState();
     _storesFuture = _initializeData();
   }

   @override
   Widget build(BuildContext context) {
     final li0n = AppLocalizations.of(context);
     return FutureBuilder(
       future: _storesFuture,
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

         final StoreDetailItem? data = snapshot.data?.data;

         return ListView(
           padding: EdgeInsets.symmetric(horizontal: 24),
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           children: [
             BrandNameSection(
               false,
               data?.name ?? "브랜드 이름",
               data?.thumbnailImageUrl ?? ""
             ),
             SizedBox(height: 15,),
             Text(data?.description ?? "브랜드 소개",
               style: TextStyle(
                   fontWeight: FontWeight.bold,
                   color: AppColors.grey,
                   fontSize: 13
               ),
             ),
             SizedBox(height: 30,),
             Divider(color: AppColors.DividerTextBoxLineDivider,),
             SizedBox(height: 10,),
             Text(
               li0n!.home_RecommendedProducts,
               style: TextStyle(
                 fontWeight: FontWeight.w600,
                 fontSize: 18,
               ),
             ),
             SizedBox(height: 10,),
           ],
         );
       },
     );
     // return
   }
 }

 class BrandProductScreen extends StatefulWidget {
   String id;
   BrandProductScreen(this.id);

   @override
   State<StatefulWidget> createState() {
     return BrandProductScreenState();
   }
 }

 class BrandProductScreenState extends State<BrandProductScreen> {
   final apiClient = StoresApiClient();
   late Future<StoreProductsResponse> _storesProductFuture;
   Future<StoreProductsResponse> _initializeProducts() async {
     return apiClient.storeProductList(widget.id);
   }

   @override
   void initState() {
     super.initState();
     _storesProductFuture = _initializeProducts();
   }

   @override
   Widget build(BuildContext context) {
     return FutureBuilder(
       future: _storesProductFuture,
       builder: (context, snapshot) {
         final data = snapshot.data?.data;
         final dataList = data?.items ?? [];
         final li0n = AppLocalizations.of(context);

         return ListView(
           padding: EdgeInsets.symmetric(horizontal: 24),
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           children: [
             SizedBox(
               height: 298,
               child: ListView.separated(
                 scrollDirection: Axis.horizontal,
                 padding: EdgeInsets.zero,
                 itemCount: dataList.length,
                 separatorBuilder: (context, index) => SizedBox(width: 10),
                 itemBuilder: (context, index) => ProductsGridItem(dataList[index]),
               ),
             ),
             Divider(color: AppColors.DividerTextBoxLineDivider,),
             Row(
               children: [
                 Text(
                   li0n!.home_OngoingFunding,
                   style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.w600,
                   ),
                 ),
                 Spacer(),
                 TextButton(
                   onPressed: (){},
                   child: Text(
                     li0n.more,
                     style: TextStyle(
                         fontSize: 16,
                         color: AppColors.grey,
                         decoration: TextDecoration.underline
                     ),
                   ),
                 ),
               ],
             ),
             SizedBox(height: 10,),
             BrandFundingSection(),
             Divider(color: AppColors.DividerTextBoxLineDivider,),
             CategoryHorizontalScroll(),
             SizedBox(height: 20,),
             ProductsNonScrollableGrid(dataList)
           ],
         );
       },
     );
   }

 }

 class BrandFundingSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BrandFundingSectionState();
  }
 }

 class BrandFundingSectionState extends State<BrandFundingSection> {
   final apiClient = FundingsApiClient();
   late Future<FundingsResponse> _fundingFuture;

   Future<FundingsResponse> _initializeProducts() async {
     return apiClient.fundings();
   }

   @override
  void initState() {
    super.initState();
    _fundingFuture = _initializeProducts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fundingFuture,
      builder: (context, snapshot) {
        final data = snapshot.data?.data?.items.take(3).toList() ?? [];
        return Column(
          children: data.map((item) {
            return FundingListItem(
              imageUrl: item.imageUrl ?? '',
              fundingName: item.title,
              brandName: item.companyId?.name ?? '브랜드 없음',
              description: item.description ?? item.linkUrl ?? '',
              linkUrl: item.linkUrl ?? '',
            );
          }).toList(),
        );
      },
    );
  }
 }

 class BrandNameSection extends StatelessWidget {
   final bool _isBrandMine;
   final String _BrandName;
   final String _BrandImageUrl;
   BrandNameSection(this._isBrandMine, this._BrandName, this._BrandImageUrl);

   @override
   Widget build(BuildContext context) {
     final li0n = AppLocalizations.of(context);
     if (_isBrandMine) {
       return Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           CircleAvatar(radius: 36, foregroundImage: NetworkImage(_BrandImageUrl),),
           SizedBox(width: 15,),
           Text(_BrandName, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
           Spacer(),
           TextButton(
             onPressed: (){},
             child: Text(li0n!.edit, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),),
           ),
         ],
       );
     }

     return Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         CircleAvatar(radius: 36, foregroundImage: NetworkImage(_BrandImageUrl)),
         SizedBox(width: 15,),
         Text(_BrandName, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
         Spacer()
       ],
     );
   }
 }