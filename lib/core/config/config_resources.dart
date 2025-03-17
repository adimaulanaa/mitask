class StringResources {
  StringResources._(); 

  //! Core 
  // http
  static const String baseUrl = 'https://';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  // time to verification OTP
  static const int remainingTime = 180; // for minutes
  static const int timeOutServer = 120; // for minutes 
  // 
  static const String nameApp = "MiTask"; 
  static const String loading = "Loading ..."; 


  //! Dashboard 
  static const String title = "Title..."; 
  static const String subtitle = "Subtitle..."; 
  static const String notes = "Notes..."; 
  static const String type = "Tipe...";

  static String createTask = "Create New Task"; 
  static String updateTask = "Updated Task"; 

  //! Report 
  static String rTitle = "Report"; 
}