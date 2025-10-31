import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

// --- BAGIAN INI DIUBAH UNTUK KOTLIN DSL ---
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    FileInputStream(keystorePropertiesFile).use { input ->
        keystoreProperties.load(input)
    }
}

fun getKeystoreProperty(key: String): String {
    return keystoreProperties.getProperty(key) ?: throw IllegalStateException("Missing $key in key.properties")
}
// -------------------------------------------

android {
    namespace = "com.example.mitask"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.mitask"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode.toInt()
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") { // Gunakan 'create' untuk Kotlin DSL
            keyAlias = getKeystoreProperty("keyAlias")
            keyPassword = getKeystoreProperty("keyPassword")
            
            // Menggunakan properti 'storeFile' dari key.properties
            val storeFilePath = getKeystoreProperty("storeFile") 
            storeFile = file(storeFilePath) 

            storePassword = getKeystoreProperty("storePassword")
        }
    }

    buildTypes {
        getByName("release") { // Gunakan 'getByName'
            // Pastikan Anda MENGAKTIFKAN signingConfig release di sini
            signingConfig = signingConfigs.getByName("release")
            
            // Aktifkan ProGuard / R8
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

flutter {
    source = "../.."
}