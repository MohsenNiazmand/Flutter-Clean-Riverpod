import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentLocationProvider = StateProvider<String>((ref)=>Routes.home);
