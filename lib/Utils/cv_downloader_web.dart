// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

/// Triggers a browser file download on Flutter Web.
Future<void> triggerDownload(List<int> bytes, String fileName) async {
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..style.display = 'none';

  html.document.body!.append(anchor);
  anchor.click();
  anchor.remove();

  html.Url.revokeObjectUrl(url);
}
