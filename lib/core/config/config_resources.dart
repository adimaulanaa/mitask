class StringResources {
  StringResources._();

  //! Core
  // http
  static const String baseUrl = 'https://';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  static const String networkFailureMessage =
      "Koneksi internet Anda tidak stabil atau terputus. Silakan periksa jaringan Anda dan coba kembali.";
  // time to verification OTP
  static const int remainingTime = 180; // for minutes
  static const int timeOutServer = 120; // for minutes
  //
  static const String nameApp = "MiTask";
  static const String credit = "Developed by · Adi Maulana · Bantraka";
  static const String subNameApp = "Manajemen Tugas Harian";
  static const String loading = "Loading ...";

  // Status
  static const String statusNotStarted = "Not Started";
  static const String statusHoldProgres = "Hold Progress";
  static const String statusComplated = "Complated";

  //! Dashboard
  static const String title = "Title...";
  static const String subtitle = "Subtitle...";
  static const String notes = "Notes...";
  static const String type = "Tipe...";

  static const String featureAbout = "Tentang Aplikasi";
  static const String featureApps = "Fitur Aplikasi";
  static const String featureSocialContact = "Sosial & Kontak";
  static const String featurePrevacy = "Privasi Pengguna";

  static const String featureAppsLabel =
      "MiTask adalah aplikasi manajemen tugas yang dirancang untuk membantu pengguna mengatur aktivitas dan meningkatkan produktivitas.";
  static const String featurePrevacyLabel =
      "Aplikasi ini hanya menyimpan data secara lokal dan tidak mengirimkan data apa pun ke server luar.";
  static const String email = "Email";
  static const String emailLabel = "adimaulana0777@email.com";
  static const String github = "GitHub";
  static const String githubLabel = "github.com/adimaulanaa";
  static const String linkedIn = "LinkedIn";
  static const String linkedInLabel = "linkedin.com/in/adi-maulana";

  static String createTask = "Create New Task";
  static String updateTask = "Updated Task";

  //! Report
  static String rTitle = "Report";
}
