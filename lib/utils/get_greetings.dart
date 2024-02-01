String getGreetings() {
  final hour = DateTime.now().hour;
  String greeting = "";
  switch (hour) {
    case int hour when hour < 12:
      greeting = "Good Morning";
      break;
    case int hour when hour < 17:
      greeting = "Good Afternoon";
      break;
    default:
      greeting = "Good Evening";
      break;
  }
  return greeting;
}
