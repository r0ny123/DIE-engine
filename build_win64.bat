set VS_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise"
set QT_PATH=C:\Qt\5.15.2\msvc2019_64
set SEVENZIP_PATH="C:\Program Files\7-Zip"

set BUILD_NAME=die_win64_portable
set SOURCE_PATH=%~dp0
mkdir %SOURCE_PATH%\build
mkdir %SOURCE_PATH%\release
set /p RELEASE_VERSION=<%SOURCE_PATH%\release_version.txt

set QT_PATH=%QT_PATH%
call %VS_PATH%\VC\Auxiliary\Build\vcvars64.bat
set GUIEXE=die.exe
set CONEXE=diec.exe
set ZIP_NAME=%BUILD_NAME%_%RELEASE_VERSION%
set RES_FILE=rsrc

del %SOURCE_PATH%\XArchive\.qmake.stash
del %SOURCE_PATH%\build_libs\.qmake.stash
del %SOURCE_PATH%\gui_source\.qmake.stash
del %SOURCE_PATH%\console_source\.qmake.stash

rmdir /s /q %SOURCE_PATH%\XCapstone\3rdparty\Capstone\release
rmdir /s /q %SOURCE_PATH%\XArchive\3rdparty\lzma\release
rmdir /s /q %SOURCE_PATH%\XArchive\3rdparty\zlib\release
rmdir /s /q %SOURCE_PATH%\XArchive\3rdparty\bzip2\release

rmdir /s /q %SOURCE_PATH%\console_source\release
rmdir /s /q %SOURCE_PATH%\gui_source\release

cd build_libs
%QT_PATH%\bin\qmake.exe build_libs.pro -r -spec win32-msvc "CONFIG+=release"

nmake Makefile.Release clean
nmake
del Makefile
del Makefile.Release
del Makefile.Debug

cd ..

cd gui_source
%QT_PATH%\bin\qmake.exe gui_source.pro -r -spec win32-msvc "CONFIG+=release"

nmake Makefile.Release clean
nmake
del Makefile
del Makefile.Release
del Makefile.Debug

cd ..

cd console_source
%QT_PATH%\bin\qmake.exe console_source.pro -r -spec win32-msvc "CONFIG+=release"

nmake Makefile.Release clean
nmake
del Makefile
del Makefile.Release
del Makefile.Debug

cd ..

mkdir %SOURCE_PATH%\release\%BUILD_NAME%
mkdir %SOURCE_PATH%\release\%BUILD_NAME%\platforms
mkdir %SOURCE_PATH%\release\%BUILD_NAME%\imageformats
mkdir %SOURCE_PATH%\release\%BUILD_NAME%\lang

copy %SOURCE_PATH%\build\release\%GUIEXE% %SOURCE_PATH%\release\%BUILD_NAME%\
copy %SOURCE_PATH%\build\release\%CONEXE% %SOURCE_PATH%\release\%BUILD_NAME%\
copy %QT_PATH%\bin\Qt5Widgets.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %QT_PATH%\bin\Qt5Gui.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %QT_PATH%\bin\Qt5Core.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %QT_PATH%\bin\Qt5Svg.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %QT_PATH%\bin\Qt5OpenGL.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %QT_PATH%\bin\Qt5Script.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %QT_PATH%\bin\Qt5ScriptTools.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %QT_PATH%\bin\Qt5Network.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %QT_PATH%\plugins\platforms\qwindows.dll %SOURCE_PATH%\release\%BUILD_NAME%\platforms\
copy %QT_PATH%\plugins\imageformats\qjpeg.dll %SOURCE_PATH%\release\%BUILD_NAME%\imageformats\
copy %QT_PATH%\plugins\imageformats\qtiff.dll %SOURCE_PATH%\release\%BUILD_NAME%\imageformats\
copy %QT_PATH%\plugins\imageformats\qico.dll %SOURCE_PATH%\release\%BUILD_NAME%\imageformats\
copy %QT_PATH%\plugins\imageformats\qgif.dll %SOURCE_PATH%\release\%BUILD_NAME%\imageformats\

copy %VS_PATH%\VC\Redist\MSVC\14.27.29016\x64\Microsoft.VC142.CRT\msvcp140.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %VS_PATH%\VC\Redist\MSVC\14.27.29016\x64\Microsoft.VC142.CRT\vcruntime140.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %VS_PATH%\VC\Redist\MSVC\14.27.29016\x64\Microsoft.VC142.CRT\msvcp140_1.dll %SOURCE_PATH%\release\%BUILD_NAME%\
copy %VS_PATH%\VC\Redist\MSVC\14.27.29016\x64\Microsoft.VC142.CRT\vcruntime140_1.dll %SOURCE_PATH%\release\%BUILD_NAME%\

xcopy %SOURCE_PATH%\XStyles\qss %SOURCE_PATH%\release\%BUILD_NAME%\qss /E /I
xcopy %SOURCE_PATH%\Detect-It-Easy\db %SOURCE_PATH%\release\%BUILD_NAME%\db /E /I
xcopy %SOURCE_PATH%\Detect-It-Easy\info %SOURCE_PATH%\release\%BUILD_NAME%\info /E /I

%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_de.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_de.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_ja.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_ja.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_pl.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_pl.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_pt_BR.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_pt_BR.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_fr.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_fr.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_ru.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_ru.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_vi.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_vi.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_zh.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_zh.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_zh_TW.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_zh_TW.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_it.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_it.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_ko.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_ko.qm
%QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_tr.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\lang\die_tr.qm
rem %QT_PATH%\bin\lrelease.exe %SOURCE_PATH%\gui_source\translation\die_he.ts -qm %SOURCE_PATH%\release\%BUILD_NAME%\base\lang\die_he.qm

mkdir %SOURCE_PATH%\release\%BUILD_NAME%\signatures
xcopy %SOURCE_PATH%\signatures\crypto.db %SOURCE_PATH%\release\%BUILD_NAME%\signatures\

cd %SOURCE_PATH%\release
if exist %ZIP_NAME%.zip del %ZIP_NAME%.zip
%SEVENZIP_PATH%\7z.exe a %ZIP_NAME%.zip %BUILD_NAME%\*
rmdir /s /q %SOURCE_PATH%\release\%BUILD_NAME%
cd ..
