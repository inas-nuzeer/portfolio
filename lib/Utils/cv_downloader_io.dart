import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

/// Saves the PDF to a temp file and opens it on mobile/desktop.
Future<void> triggerDownload(List<int> bytes, String fileName) async {
  final Directory tempDir = await getTemporaryDirectory();
  final File file = File('${tempDir.path}/$fileName');
  await file.writeAsBytes(bytes);
  await OpenFilex.open(file.path);
}
