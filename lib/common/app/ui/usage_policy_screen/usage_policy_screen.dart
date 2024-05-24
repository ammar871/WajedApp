import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:wajed_app/core/theming/styles.dart';
import 'package:wajed_app/core/utils/strings.dart';

import '../../../../core/utils/app_model.dart';

class UsagePolicyScreen extends StatelessWidget {
  const UsagePolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldkey,
      // drawer: const DrawerWidget(),
      appBar: AppBar(
    
        elevation: 0,
        automaticallyImplyLeading: true,
        title:  Text(
          Strings.policy.tr(),
          style: TextStyles.textStyleFontBold16BlackAppBar,
        ),
    
      ),
            body:Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      
      child:SingleChildScrollView(
        child: Html(
        data: privacy,
      ),
      ),

      ) ,
    );
 
  }
}