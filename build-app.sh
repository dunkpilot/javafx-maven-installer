#!/bin/bash
# Script to build the app and replace the startup script
# Exit on any error
set -e

echo "===== Building JavaFX App ====="
echo "Compiling and packaging..."
mvn clean package

echo "Creating runtime image with JLink..."
mvn javafx:jlink

echo "Replacing the startup script..."
cat > target/app/bin/app << 'EOL'
#!/bin/sh
DIR=`dirname $0`
$DIR/java \
  -Dglass.gtk.uiScale=1.0 \
  -Dprism.order=j2d \
  -Djavafx.animation.fullspeed=true \
  -Dsun.java2d.opengl=true \
  --add-exports=javafx.base/com.sun.javafx=com.fuck.fuck \
  --add-exports=javafx.graphics/com.sun.javafx.tk=ALL-UNNAMED \
  --add-exports=javafx.graphics/com.sun.glass.ui=ALL-UNNAMED \
  $JLINK_VM_OPTIONS -m com.fuck.fuck/com.fuck.fuck.HelloApplication "$@"
EOL

# Make sure the script is executable
chmod +x target/app/bin/app

echo "===== App Build Complete ====="
echo "You can run it with: ./target/app/bin/app"
echo ""
echo "To create a native installer, run: ./build-native.sh"