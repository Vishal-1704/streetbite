import 'package:supabase_flutter/supabase_flutter.dart';

class UserInfo {
  static final _supabase = Supabase.instance.client;

  static String? _displayName;

  static void setDisplayName(String name) {
    _displayName = name;
  }

  static String? getDisplayName() {
    return _displayName ?? _supabase.auth.currentUser?.userMetadata?['display_name'];
  }

  static String? getUserEmail() {
    return _supabase.auth.currentUser?.email;
  }

  static String? getCurrentUserId() {
    return _supabase.auth.currentUser?.id;
  }
}
