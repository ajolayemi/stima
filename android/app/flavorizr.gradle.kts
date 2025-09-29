import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "com.incampagna.stima.dev"
            resValue(type = "string", name = "app_name", value = "Stime in campo DEV")
        }
        create("stg") {
            dimension = "flavor-type"
            applicationId = "com.incampagna.stima.stg"
            resValue(type = "string", name = "app_name", value = "Stime in campo STG")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "com.incampagna.stima"
            resValue(type = "string", name = "app_name", value = "Stime in campo")
        }
    }
}