class NotificationDemoModel {
  final String title;
  final String message;
  final String timeAgo;
  final String iconUrl;

  NotificationDemoModel({
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.iconUrl,
  });
}

final List<NotificationDemoModel> demoNotifications = [
  NotificationDemoModel(
    title: "Ride Accepted",
    message: "You’ve successfully accepted a new ride.",
    timeAgo: "Just now",
    iconUrl: "https://cdn-icons-png.flaticon.com/512/743/743131.png",
  ),
  NotificationDemoModel(
    title: "Connection Lost",
    message: "You’re currently offline. Please check your internet connection.",
    timeAgo: "Yesterday",
    iconUrl: "https://cdn-icons-png.flaticon.com/512/595/595879.png",
  ),
  NotificationDemoModel(
    title: "Documents Under Review",
    message: "Your documents are being reviewed.",
    timeAgo: "1 hour ago",
    iconUrl: "https://cdn-icons-png.flaticon.com/512/1828/1828817.png",
  ),
];
