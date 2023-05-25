part of 'firebase_cloud_messaging.dart';

@pragma('vm:entry-point')
Future<void> onNotificationReceived(RemoteMessage message) async {
  logger(message.toMap().toString(), name: "onNotificationReceived");
  final Map<String, dynamic> data = message.data;
  if (data.isEmpty && message.notification != null) {
    await _createNotification(
      title: message.notification!.title.toString(),
      body: message.notification!.body.toString(),
    );
  } else if (data.isNotEmpty) {
    final LocalDatabase localDatabase = await LocalDatabase.instance.init();
    final Map<String, dynamic> content = jsonDecode(data["content"]);
    final Map<String, dynamic> payload = content["payload"];
  }
}
