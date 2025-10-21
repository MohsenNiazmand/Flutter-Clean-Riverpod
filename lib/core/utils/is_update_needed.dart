/// Compares two version strings to determine if an update is needed.
/// Handles semantic versioning by padding version parts for proper comparison.
bool isUpdateNeeded(String current, String newVersion) {
  final List<String> currentParts =
      current.split('.').map((e) => e.padLeft(3, '0')).toList();
  final List<String> newParts =
      newVersion.split('.').map((e) => e.padLeft(3, '0')).toList();

  for (int i = 0; i < currentParts.length; i++) {
    final int currentPart = int.parse(currentParts[i]);
    final int newPart = int.parse(newParts[i]);

    if (newPart > currentPart) {
      return true;
    } else if (newPart < currentPart) {
      return false;
    }
  }
  return false;
}
