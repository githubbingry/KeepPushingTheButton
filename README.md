# Soal 3: Studi Kasus II, “Keep Pushing the Button!”

Sebagai Calon Anggota Divisi Mobile Development, Anda diberikan sebuah tugas untuk membuat sebuah aplikasi mobile Android yang dapat menjalankan sebuah fungsi spesifik. Aplikasi yang dimaksud adalah aplikasi stateful yang memiliki sebuah tombol (jenis apapun) yang dapat menginkrementasi sebuah nilai variabel integer dan menampilkannya dalam sebuah page. Adapun setiap inkrementasi, Anda perlu memperbarui nilai variabel tersebut dalam page dan juga menunjukkan keterangan apakah nilainya ganjil atau genap. Kemudian, terdapat sebuah probabilitas nilai variabel setiap inkrementasi agar masuk ke dalam kategori “Jackpot” apabila nilainya ganjil dan bernilai lebih besar dari 10. Nilai probabilitas tersebut dimulai dengan 0.01 dan terus bertambah (+0.01 s.d. 0.05) seiring tidak “Jackpot”-nya inkrementasi nilai dalam variabel integer tersebut. Apabila “Jackpot”, tombol untuk inkrementasi akan menjadi disabled dan muncul sebuah dialog “Selamat! Anda ‘Jackpot’ pada angka {variabelInteger}”. Silakan membuat program tersebut.

## Overview

Hai, Welcome to KeepPushingTheButton!, here is the opsional assignment for addtitional points in joining GDGoC UNSRI Mobile Development division as member.

Here you can see 2 different version that I make :

- Ver1 : The jackpot probability get added randomly in the set of {0.01, 0.02, 0.03, 0.04, 0.05}
- Ver2 : The jackpot probability get added randomly in the interval of [0.01, 0.05]. For example: 0.042069

### Home Page
<div style="display:flex;">
   <img src="https://github.com/mfazrinizar/KeepPushingTheButton/blob/main/UI_Overview/homepage.png" alt="homepage" width="200"/>
</div>

### Version 1 Page
<div style="display:flex;">
   <img src="https://github.com/mfazrinizar/KeepPushingTheButton/blob/main/UI_Overview/ver1.png" alt="ver1" width="200"/>
   <img src="https://github.com/mfazrinizar/KeepPushingTheButton/blob/main/UI_Overview/ver1_bar.png" alt="ver1_bar" width="200"/>
   <img src="https://github.com/mfazrinizar/KeepPushingTheButton/blob/main/UI_Overview/ver1_fail.png" alt="ver1_fail" width="200"/>
   <img src="https://github.com/mfazrinizar/KeepPushingTheButton/blob/main/UI_Overview/ver1_jackpot.png" alt="ver1_jackpot" width="200"/>
</div>

### Version 2 Page
<div style="display:flex;">
   <img src="https://github.com/mfazrinizar/KeepPushingTheButton/blob/main/UI_Overview/ver2.png" alt="ver2" width="200"/>
   <img src="https://github.com/mfazrinizar/KeepPushingTheButton/blob/main/UI_Overview/ver2_fail.png" alt="ver2_fail" width="200"/>
   <img src="https://github.com/mfazrinizar/KeepPushingTheButton/blob/main/UI_Overview/ver2_jackpot.png" alt="ver2_jackpot" width="200"/>
</div>

## Downloads

Download the latest version of KeepPushingTheButton according to your Android device's architecture type:
- [Arm64-v8a](https://https://github.com/githubbingry/KeepPushingTheButton/releases/download/v0.0.3/app-arm64-v8a-release.apk) (APK for arm64-v8a)
- [Armeabi-v7a](https://https://github.com/githubbingry/KeepPushingTheButton/releases/download/v0.0.3/app-armeabi-v7a-release.apk) (APK for armeabi-v7a or arm32)
- [x86_64](https://https://github.com/githubbingry/KeepPushingTheButton/releases/download/v0.0.3/app-x86_64-release.apk) (APK for x86_64)