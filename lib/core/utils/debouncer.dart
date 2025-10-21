import 'dart:async';
import 'dart:ui';

/// Debounce utility to delay execution of callbacks.
/// Useful for search input, API calls, or any action that should wait
/// for user to stop typing/acting before executing.
class Debounce {
  Debounce({this.milliseconds});
  final int? milliseconds;
  VoidCallback? action;

  Timer? _timer;

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}
