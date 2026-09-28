import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Apple forwards the remote autocapture switch to AmplitudeSwift', () {
    final source = File(
      'darwin/amplitude_flutter/Sources/amplitude_flutter/'
      'SwiftAmplitudeFlutterPlugin.swift',
    ).readAsStringSync();

    expect(
      source,
      contains(
        'args["enableAutoCaptureRemoteConfig"] as? Bool ?? true',
      ),
    );
    expect(
      source,
      contains(
        'enableAutoCaptureRemoteConfig: enableAutoCaptureRemoteConfig',
      ),
    );
  });

  test('Windows rotates session identity without emitting boundary events', () {
    final source = File('windows/amplitude_instance.cpp').readAsStringSync();

    expect(
      source,
      contains(
        'if ((now - last_event_time_) > '
        'config_.min_time_between_sessions_millis)',
      ),
    );
    expect(
      RegExp(
        r'if \(config_\.default_tracking_sessions\) \{\s*'
        r'TrackSessionEnd\(last_event_time_\);\s*\}\s*'
        r'session_id_ = now;\s*'
        r'if \(config_\.default_tracking_sessions\) \{\s*'
        r'TrackSessionStart\(\);',
        multiLine: true,
      ).allMatches(source).length,
      2,
      reason: 'Track and resume must rotate IDs outside the emission gate.',
    );
    expect(
      source,
      contains(
        'last_event_time_ = CurrentTimeMillis();\n  PersistIdentity();',
      ),
      reason: 'Pause persistence must not depend on boundary event emission.',
    );
  });
}
