import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

Greetings getGreetings(BuildContext context) {
  final hour = DateTime.now().hour;
  final provider = Provider.of<GreetingProvider>(context);
  final greetings;
  switch (hour) {
    case int hour when hour < 12:
      greetings = Greetings(
          title: "Good Morning", imageUrl: "assets/images/good_morning.jpg");
      provider.onUpdate();

      break;
    case int hour when hour < 17:
      greetings = Greetings(
          title: "Good Afternoon",
          imageUrl: "assets/images/good_afternoon.jpg");
      provider.onUpdate();
      break;
    default:
      greetings = Greetings(
          title: "Good Evening", imageUrl: "assets/images/good_evening.jpg");
      provider.onUpdate();
      break;
  }
  return greetings;
}

class GreetingProvider extends ChangeNotifier {
  onUpdate() {
    notifyListeners();
  }
}

class Greetings {
  String title;
  String imageUrl;

  Greetings({
    required this.title,
    required this.imageUrl,
  });

  factory Greetings.fromJson(Map<String, dynamic> json) => Greetings(
        title: json["title"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "imageYrl": imageUrl,
      };
}
