import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeLoading = useState(true);

    useEffect(() {
      Future.delayed(Durations.long2, () {
        homeLoading.value = false;
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: cBackground,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: homeLoading.value
            ? const Center(child: CircularProgressIndicator())
            : const Center(child: Text('Home'),),
      ),
    );
  }
}
