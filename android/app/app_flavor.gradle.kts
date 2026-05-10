import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    val appName = "Stime"
    val appNameKey = "app_name"
    val flavorDimension = "app-flavor"
    val firebaseWebHostKey = "firebase_web_app_host"
    val firebaseAppHostKey = "firebase_app_host"
    flavorDimensions(flavorDimension)
    productFlavors {
        create("dev") {
            dimension = flavorDimension
            applicationIdSuffix = "dev"
            manifestPlaceholders[appNameKey] = "$appName DEV"
            manifestPlaceholders[firebaseWebHostKey] = "stime-dev-473921.web.app"
            manifestPlaceholders[firebaseAppHostKey] = "stime-dev-473921.firebaseapp.com"
        }
        create("stg") {
            dimension = flavorDimension
            applicationIdSuffix = "stg"
            manifestPlaceholders[appNameKey] = "$appName STG"
            manifestPlaceholders[firebaseWebHostKey] = ""
            manifestPlaceholders[firebaseAppHostKey] = ""
        }
        create("prod") {
            dimension = flavorDimension
            manifestPlaceholders[appNameKey] = appName
            manifestPlaceholders[firebaseWebHostKey] = ""
            manifestPlaceholders[firebaseAppHostKey] = ""
        }
    }
}