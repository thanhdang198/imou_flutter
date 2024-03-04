import 'platform_event.dart';

class CameraEvent {
  PlatformEvent? eventType;
  dynamic data;

  CameraEvent({this.eventType, this.data});

  CameraEvent.fromJson(Map<String, dynamic> json) {
    if (json['eventType'] is int) {
      eventType = PlatformEvent.values[json['eventType']];
    } else {
      try {
        eventType = PlatformEvent.values.firstWhere(
            (e) => e.toString().split(".").last == json['eventType']);
      } on StateError {
        //When the list is empty or eventType not found (Bad State: No Element)
      } catch (e) {
        // TODO handle the error
      }
    }
  }
}
