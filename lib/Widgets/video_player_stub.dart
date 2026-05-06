// Non-web stub — this file is imported on non-web platforms.
// The actual implementation lives in video_player_web.dart.

import 'package:flutter/widgets.dart';

Widget buildWebVideoPlayer(String src) {
  // This should never be called on non-web; VideoPlayerWidget handles the
  // platform check before reaching here.
  return const SizedBox.shrink();
}
