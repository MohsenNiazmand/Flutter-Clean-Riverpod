
import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Utility for picking files from device storage.
/// Supports various file types and custom extensions.
Future<XFile?> pickFile({FileType? type, List<String>? extensions}) async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: type ?? FileType.any,
    allowedExtensions: extensions,
  );

  if (result != null) {
    final xFile=result.files.first.xFile;
    return xFile;
  }
  return null;
}