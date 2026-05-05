import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// Web-only import — only compiled on web builds
import 'cv_downloader_web.dart' if (dart.library.io) 'cv_downloader_io.dart';

Future<void> downloadCv() async {
  const String assetPath = 'assets/files/Inas-Nuzeer-Cv.pdf';
  const String fileName = 'Inas-Nuzeer-Cv.pdf';

  try {
    final ByteData data = await rootBundle.load(assetPath);
    final bytes = data.buffer.asUint8List();
    await triggerDownload(bytes, fileName);
  } catch (e) {
    debugPrint('CV download failed: $e');
  }
}
