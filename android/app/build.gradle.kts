plugins {
    id("com.android.application")
    // Le plugin Flutter doit obligatoirement être appliqué après le plugin Android
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "letcode.dev.egliloo"
    compileSdk = 35
    
    // CORRECTION : Ajout du signe "=" obligatoire en Kotlin DSL
    ndkVersion = "29.0.14206865" 

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "letcode.dev.egliloo"
        
        // CORRECTION : Forcer API 21 minimum pour la compatibilité avec just_audio
        minSdk = 21 
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Utile pour la gestion multi-index des anciennes API Android
        multiDexEnabled = true
    }

    buildTypes {
        release {
            // CORRECTION : Syntaxe Kotlin DSL pour la signature de debug temporaire
            signingConfig = signingConfigs.getDisabled() 
            
            // Optimisation R8 pour la production (Passer à true avant de publier)
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
