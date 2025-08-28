plugins {
  id("com.android.application")
  id("org.jetbrains.kotlin.android")
  id("dev.flutter.flutter-gradle-plugin")
}

android {
  namespace = "com.wonjongseo.numberone_topik"
  compileSdk = 35
  ndkVersion = "27.0.12077973"

  defaultConfig {
    applicationId = "com.wonjongseo.numberone_topik"
    minSdk = 23
    targetSdk = 35
    versionCode = flutter.versionCode
    versionName = flutter.versionName
  }

  signingConfigs {
    create("release") {
      storeFile = file("../keystore/key.jks")
      val passwordFile = file("../keystore/keystore.password")
      val password = passwordFile.readText().trim()
      storePassword = password
      keyAlias = "key"
      keyPassword = password
    }
  }

  buildTypes {
    release {
      isMinifyEnabled = false
      isShrinkResources = false
      signingConfig = signingConfigs["release"]
    }
  }

  compileOptions {
    isCoreLibraryDesugaringEnabled = true
    sourceCompatibility = JavaVersion.VERSION_11
    targetCompatibility = JavaVersion.VERSION_11
  }

  kotlinOptions {
    jvmTarget = "11"
  }
}

dependencies {
  coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:1.2.2")
}

flutter {
  source = "../.."
}