@echo off
set idx=
"D:\Program Files\Microvirt\MEmu\memuc.exe" listvms
set /p idx=输入模拟器id:
set pic_path=
"D:\Program Files\Microvirt\MEmu\memuc.exe" -i %idx% adb shell "ls /sdcard | grep png"
set /p pic_path=选择图片名称:

 "D:\Program Files\Microvirt\MEmu\memuc.exe" -i %idx% adb pull /sdcard/%pic_path% %pic_path%
 pause