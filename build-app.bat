@echo off
REM Script to build the app and replace the startup script

echo ===== Building JavaFX App =====
echo Compiling and packaging...
call mvn clean package

echo Creating runtime image with JLink...
call mvn javafx:jlink

echo Replacing the startup script...
(
echo @echo off
echo setlocal
echo set DIR=%%~dp0
echo "%%DIR%%java" ^
echo   -Dglass.gtk.uiScale=1.0 ^
echo   -Dprism.order=j2d ^
echo   -Djavafx.animation.fullspeed=true ^
echo   -Dsun.java2d.opengl=true ^
echo   --add-exports=javafx.base/com.sun.javafx=com.fuck.fuck ^
echo   --add-exports=javafx.graphics/com.sun.javafx.tk=ALL-UNNAMED ^
echo   --add-exports=javafx.graphics/com.sun.glass.ui=ALL-UNNAMED ^
echo   %%JLINK_VM_OPTIONS%% -m com.fuck.fuck/com.fuck.fuck.HelloApplication %%*
) > target\app\bin\app.bat

echo ===== App Build Complete =====
echo You can run it with: .\target\app\bin\app.bat
echo.
echo To create a native installer, run: .\build-native.bat