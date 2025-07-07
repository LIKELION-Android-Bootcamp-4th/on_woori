import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';

import '../../../l10n/app_localizations.dart';

class UserRoleSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.signInTitle,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 15),
            Text(
              l10n.signInSubtitle,
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(45),
                    decoration:BoxDecoration(
                        border: Border.all(color:AppColors.primarySub, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_outline, color: AppColors.primarySub, size: 50,),
                        Text(
                          l10n.signInUserTypeConsumer,
                          style: TextStyle(
                            color: AppColors.primarySub,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    context.push('/auth/signup/common');
                  },
                ),
                SizedBox(width: 20,),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(45),
                    decoration:BoxDecoration(
                        border: Border.all(color:AppColors.primarySub, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.storefront_outlined, color: AppColors.primarySub, size: 50,),
                        Text(
                          l10n.signInUserTypeSeller,
                          style: TextStyle(
                            color: AppColors.primarySub,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: (){
                    context.push('/auth/signup/seller');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
