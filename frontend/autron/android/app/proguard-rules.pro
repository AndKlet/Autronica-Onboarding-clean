-keep class com.google.errorprone.annotations.CanIgnoreReturnValue { *; }
-keep class com.google.errorprone.annotations.CheckReturnValue { *; }
-keep class com.google.errorprone.annotations.Immutable { *; }
-keep class com.google.errorprone.annotations.RestrictedApi { *; }
-keep class javax.annotation.Nullable { *; }
-keep class javax.annotation.concurrent.GuardedBy { *; }
-dontwarn javax.annotation.Nullable
-dontwarn javax.annotation.concurrent.GuardedBy