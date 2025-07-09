// import 'package:flutter/material.dart';
// import 'package:on_woori/core/styles/app_colors.dart';
// import 'package:on_woori/data/entity/response/fundings/fundings_response.dart';
// import 'package:on_woori/data/entity/response/products/products_response.dart';
// import 'package:on_woori/l10n/app_localizations.dart';
// import 'package:on_woori/widgets/brand_product_edit_item.dart';
// import 'package:on_woori/widgets/funding_list_item.dart';
//
// class BrandProductEditPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final li0n = AppLocalizations.of(context);
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text(li0n!.brandProductEditTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
//           bottom: TabBar(
//             tabs: [
//               Tab(icon: Text("상품",),),
//               Tab(icon: Text("펀딩"),),
//             ],
//             labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
//             unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: AppColors.grey),
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             BrandProductEditScreen(),
//             BrandFundingEditScreen(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class BrandProductEditScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return BrandProductEditScreenState();
//   }
// }
//
// class BrandProductEditScreenState extends State<BrandProductEditScreen> {
//   final tempIndex = 3;
//   bool selecting = false;
//   List<ProductItem> tempList = [];
//   List<bool> selectionList = [];
//
//   void onChanged(bool? flag, int index) {
//     setState(() {
//       selectionList[index] = flag ?? false;
//     });
//   }
//
//   void toggleSelectAll() {
//     final selectAll = selectionList.any((selected) => !selected);
//     setState(() {
//       for (int i = 0; i < selectionList.length; i++) {
//         selectionList[i] = selectAll;
//       }
//     });
//   }
//
//   void deleteMultiSelection() {
//     List<ProductItem> deletedList = List.from(tempList);
//     List<bool> deletedSelection = List.from(selectionList);
//     for (int i = tempList.length - 1; i >= 0; i--) {
//       if (selectionList[i]) {
//         deletedList.removeAt(i);
//         deletedSelection.removeAt(i);
//       }
//     }
//     setState(() {
//       tempList = List.from(deletedList);
//       selectionList = List.from(deletedSelection);
//       selecting = false;
//     });
//   }
//
//   void deleteSelection(int index) {
//     setState(() {
//       tempList.removeAt(index);
//       selectionList.removeAt(index);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < tempIndex; i++) {
//       tempList.add(ProductItem(id: "id", name: "시험상품", price: 1000, isFavorite: false));
//       selectionList.add(false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (selecting) {
//       bool isAllSelected = selectionList.every((selected) => selected);
//
//       return ListView(
//         padding: EdgeInsets.symmetric(horizontal: 24),
//         children: [
//           Row(
//             children: [
//               Text("선택된 상품 ${selectionList.where((e) => e).length}개", style: TextStyle(fontSize: 16, color: AppColors.grey),),
//               Spacer(),
//               TextButton(
//                 onPressed: (){
//                   toggleSelectAll();
//                 },
//                 child: Text(isAllSelected ? "전체 해제" : "모두 선택", style: TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),),
//               ),
//               TextButton(
//                 onPressed: (){
//                   deleteMultiSelection();
//                 },
//                 child: Text("선택 삭제", style: TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),),
//               )
//             ],
//           ),
//           SizedBox(height: 20,),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: tempList.length,
//             itemBuilder: (context, index) {
//               final item = tempList[index];
//               final selected = selectionList[index];
//               return BrandProductMultiSelectItem(item.name, index, selected, onChanged);
//             },
//           )
//         ],
//       );
//     }
//
//     return ListView(
//       padding: EdgeInsets.symmetric(horizontal: 24),
//       children: [
//         Row(
//           children: [
//             Text("판매중 상품 ${tempList.length}개", style: TextStyle(fontSize: 16, color: AppColors.grey),),
//             Spacer(),
//             TextButton(
//               onPressed: (){
//                 setState(() {
//                   selecting = true;
//                 });
//               },
//               child: Text("다중선택", style: TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),),
//             )
//           ],
//         ),
//         SizedBox(height: 20,),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: tempList.length,
//           itemBuilder: (context, index) {
//             final item = tempList[index];
//             return BrandProductEditListItem(item.name, index, deleteSelection);
//           },
//         )
//       ],
//     );
//   }
// }
//
// class BrandFundingEditScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return BrandFundingEditScreenState();
//   }
//
// }
//
// class BrandFundingEditScreenState extends State<BrandFundingEditScreen> {
//   final tempIndex = 3;
//   List<FundingListItem> tempList = [];
//   List<bool> selectionList = [];
//   bool selecting = false;
//
//   @override
//   void initState() {
//     super.initState();
//     for (int i = 0; i < tempIndex; i++) {
//       tempList.add(FundingsItem(
//           id: "id",
//           title: "펀딩 이름",
//           imageUrl: "imageUrl",
//           linkUrl: "linkUrl")
//       );
//       selectionList.add(false);
//     }
//   }
//
//   void toggleSelectAll() {
//     final selectAll = selectionList.any((selected) => !selected);
//     setState(() {
//       for (int i = 0; i < selectionList.length; i++) {
//         selectionList[i] = selectAll;
//       }
//     });
//   }
//
//   void deleteMultiSelection() {
//     List<FundingsItem> deletedList = List.from(tempList);
//     List<bool> deletedSelection = List.from(selectionList);
//     for (int i = tempList.length - 1; i >= 0; i--) {
//       if (selectionList[i]) {
//         deletedList.removeAt(i);
//         deletedSelection.removeAt(i);
//       }
//     }
//     setState(() {
//       tempList = List.from(deletedList);
//       selectionList = List.from(deletedSelection);
//       selecting = false;
//     });
//   }
//
//   void deleteSelection(int index) {
//     setState(() {
//       tempList.removeAt(index);
//       selectionList.removeAt(index);
//     });
//   }
//
//   void onChanged(bool? flag, int index) {
//     setState(() {
//       selectionList[index] = flag ?? false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (selecting) {
//       bool isAllSelected = selectionList.every((selected) => selected);
//
//       return ListView(
//         padding: EdgeInsets.symmetric(horizontal: 24),
//         children: [
//           Row(
//             children: [
//               Text("선택된 상품 ${selectionList.where((e) => e).length}개", style: TextStyle(fontSize: 16, color: AppColors.grey),),
//               Spacer(),
//               TextButton(
//                 onPressed: (){
//                   toggleSelectAll();
//                 },
//                 child: Text(isAllSelected ? "전체 해제" : "모두 선택", style: TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),),
//               ),
//               TextButton(
//                 onPressed: (){
//                   deleteMultiSelection();
//                 },
//                 child: Text("선택 삭제", style: TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),),
//               )
//             ],
//           ),
//           SizedBox(height: 20,),
//           ListView.builder(
//             shrinkWrap: true,
//             physics: NeverScrollableScrollPhysics(),
//             itemCount: tempList.length,
//             itemBuilder: (context, index) {
//               final item = tempList[index];
//               final selected = selectionList[index];
//               return BrandProductMultiSelectItem(item.title, index, selected, onChanged);
//             },
//           )
//         ],
//       );
//     }
//
//     return ListView(
//       padding: EdgeInsets.symmetric(horizontal: 24),
//       children: [
//         Row(
//           children: [
//             Text("등록된 펀딩 ${tempList.length}개", style: TextStyle(fontSize: 16, color: AppColors.grey),),
//             Spacer(),
//             TextButton(
//               onPressed: (){
//                 setState(() {
//                   selecting = true;
//                 });
//               },
//               child: Text("다중선택", style: TextStyle(fontSize: 16, color: AppColors.editDeleteTextButton),),
//             )
//           ],
//         ),
//         SizedBox(height: 20,),
//         ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: tempList.length,
//           itemBuilder: (context, index) {
//             final item = tempList[index];
//             return BrandProductEditListItem(item.title, index, deleteSelection);
//           },
//         )
//       ],
//     );
//   }
// }