import 'dart:async';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Compresses image files based on their size to optimize storage and performance.
/// Uses dynamic quality settings: larger files get more compression.
Future<File?> compressAndGetFile(File? file) async {
  var imageSize = file?.lengthSync() ?? 0 / 1024;
  int quality;
  if (imageSize <= 200) {
    quality = 100;
  } else if (imageSize <= 400) {
    quality = 90;
  } else if (imageSize <= 600) {
    quality = 80;
  } else if (imageSize <= 1000) {
    quality = 70;
  } else if (imageSize <= 2000) {
    quality = 60;
  } else if (imageSize <= 3000) {
    quality = 50;
  } else if (imageSize <= 4000) {
    quality = 40;
  } else {
    quality = 30;
  }

  var result = await FlutterImageCompress.compressAndGetFile(
    file?.absolute.path ?? '',
    '${file?.absolute.path ?? ""}-temp.jpg',
    quality: quality,
  );

  return File(result?.path ?? '');
}


