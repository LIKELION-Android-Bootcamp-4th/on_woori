import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:on_woori/core/styles/app_colors.dart';

import '../../../l10n/app_localizations.dart';

class UserRoleSelectionPage extends StatelessWidget {
  const UserRoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              l10n.signInTitle,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              l10n.signInSubtitle,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(45),
                    decoration:BoxDecoration(
                        border: Border.all(color:AppColors.primarySub, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.person_outline, color: AppColors.primarySub, size: 50,),
                        Text(
                          l10n.signInUserTypeConsumer,
                          style: const TextStyle(
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
                const SizedBox(width: 20,),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(45),
                    decoration:BoxDecoration(
                        border: Border.all(color:AppColors.primarySub, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.storefront_outlined, color: AppColors.primarySub, size: 50,),
                        Text(
                          l10n.signInUserTypeSeller,
                          style: const TextStyle(
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
