# FarsiLingo
[TOC]

## Changelog
- added project ---- 3/5/2020
- created content ---- 3/10/2020
- UI designed in XD ---- 5/13/2020
- Backend Serviecs running ---- 6/10/2020
- Full UI deployment ---- 6/14/2020
- Final Build and bug fixings ---- 6/18/2020

## Dependencies
- sqlite
- python
- markdown renderer
- quiz maker

## Libraries
- flutter_speed_dial: ^1.2.1
- cupertino_icons: ^0.1.3
- flutter_spinkit: ^4.1.2+1
- sqflite: ^1.3.1
- path_provider: any
- percent_indicator: ^2.1.5
- flutter_markdown: ^0.4.2

## Documentaion
<div dir="rtl">

### main.dart
- void main : این تابع شامل مسیر های اصلی برنامه و تم برنامه میشود

### services:
- ### database.dart:
    - کلاس دینابیس
    - initDB(): باز کردن فایل دیتابیس و کپی کردن در آن در دستگاه
    - newUser(User newUser): اضافه کردن کاربر جدید
    - login(String username, String password): وارد شدن با استفاده از نام کاربری و 
    رمز عبور 
    - getUser,selectUser : بی منطق ترین کد ها برای گرفتن اطلاعات کاربری
    - updateUser: ویرایش اطلاعات مربوط به بحث لولینگ
    - getAllUsers: این دیگه خیلی ضایعس
    - getQuestions(int id): با استفاده از کد درس سوالات اون درس رو بر می گردونه
- ### user.dart
- ### question.dart
    - تشکیل دهنده کلاس مدل
    - متشکل از دو تابع
        toMap و fromMap
    - toMap() : داده ها را از کلاس مدل دریافت و آن را به json تبدیل می کند
    - fromMap: فایل json دریافتی را درون instance ساخته شده از کلاس قرار می دهد
### pages
- ### loading.dart:
    - اولین مسیر برای اجرای برنامه
    - دارای spinkit برای انیمیشن لودینگ
    - برای لاگین اتوماتیک به دنبال فایل در فولدر دیتا می گردد
        ، اگر فایل را پیدا کرد به سرعت لاگین کرده و سپس وارد صفحه اصلی می گردد
        ، در غیر این صورت با صفحه خوش آمد گویی مواجه می گردید
    - loadMain() async: عملیات خوانش فایل در این تابع صورت می گیرد.
- ### home.dart:
    - صفحه اصلی برنامه می باشد
    - اطلاعات کاربر نمایش داده می شود
    - دروس از اینجا مشاهده می گردد
- ### exam.dart:
    - با استفاده از کد درس دریافتی از صفحه اصلی وارد صفحه آزمون می شود و با تهیه 5 سوال به صورت تصادفی آزمون گرفته می شود و سپس وارد صحفه نتیجه می شود.
- ### tips.dart:
    - فایل ها به صورت مارکدان
    - محتوای آموزشی در این قسمت قرار می گیرد
### pages/firsttime
- ### welcome.dart:
    - صفحه خوش آمدگویی
- ### farsicheck.dart:
    - با پرسیدن یک سوال مشخص می شود که فارسی زبان هستید یا اینکه می خواهید فارسی را برای اولین بار فرا بگیرید
- ### login.dart:
    - شامل دو بخش Login و SignUp
    - دو بخش در یک صفحه به صورت آرایه در آمده است
    - با زدن دکمه پایین صفحه این وضعیت را می توان تغییر داد.
### include
- ###  customDialog.dart:
    - دیالوگ باکس ساده برای قسمت دروس
    - با قابلیت navigation به قسمت آزمون و نکات آموزشی
- ###  examResualt.dart:
    - با دریافت نمره از صحفه آزمون نتیجه آزمون را مشخص می کند.
    - در صورت قبولی: نمره بالا 10، صفحه به رنگ سبز در می آید
    - در غیر این صورت: نمره پایین تر از، صفحه به رنگ قرمز در می آید.
</div>