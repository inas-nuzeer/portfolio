// Non-web stub — this file is imported on non-web platforms.
// The actual implementation lives in video_player_web.dart.

import 'package:flutter/widgets.dart';

Widget buildWebVideoPlayer(String src, {String? controlId}) {
  // Never called on non-web; VideoPlayerWidget guards with kIsWeb.
  return const SizedBox.shrink();
}

// No-op stubs for the DOM control functions.
void pauseAndHideVideo(String controlId) {}
void showVideo(String controlId) {}
