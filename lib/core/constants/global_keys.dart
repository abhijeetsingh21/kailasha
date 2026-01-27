import 'package:flutter/material.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/core/utils/bloc/app_reset_scope.dart';
class GlobalKeys {
  static final navigatorKey = appRouter.navigatorKey;
  
  
  static final createAccDriverLegalFormKey = GlobalKey<FormState>();
  static final createAccFamilyLegalFormKey = GlobalKey<FormState>();
  static final appResetKey = GlobalKey<AppResetScopeState>();
  static final forgotPassFormKey = GlobalKey<FormState>();
}
