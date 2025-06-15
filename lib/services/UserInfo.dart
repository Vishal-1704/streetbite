import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class UserInfo {
  static final _supabase = Supabase.instance.client;

  static String? getCurrentUserId() {
    return _supabase.auth.currentUser?.id;
  }

  static String? getDisplayName() {
    return _supabase.auth.currentUser?.userMetadata?['display_name'];
  }

  static String? getUserEmail() {
    return _supabase.auth.currentUser?.email;
  }


}
