#gson
-keepattributes Signature
-dontwarn com.google.gson.**
#-keep class sun.misc.Unsafe {*;}
-keep class com.google.gson.**{*;}

#eventbus
-keep class org.greenrobot.eventbus.**{*;}
#-keepclassmembers class **{
##    @org.greenrobot.eventbus.Subscribe <methods>;
#}
#-keep enum org.greenrobot.eventbus.ThreadMode {*;}

#zxing.jar
-dontwarn com.google.zxing.**
-keep class com.google.zxing.**{*;}

#lechangeSDK.jar
-dontwarn com.lechange.**
-keep class com.lechange.**{*;}
-dontwarn com.company.**
-keep class com.company.**{*;}

#pulltorefreshlib.jar
-dontwarn com.lechange.pulltorefreshlistview.**
-keep class com.lechange.pulltorefreshlistview.**{*;}

#DHScanner-1.0.7.aar
-dontwarn com.mm.android.**
-keep class com.mm.android.**{*;}

#imageload4dh.jar
-dontwarn com.nostra13.universalimageloader.**
-keep class com.nostra13.universalimageloader.**{*;}