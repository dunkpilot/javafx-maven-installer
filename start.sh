#!/bin/sh
DIR=`dirname $0`
$DIR/java \
  -Dglass.gtk.uiScale=1.0 \
  -Dprism.order=j2d \
  -Djavafx.animation.fullspeed=true \
  -Dsun.java2d.opengl=true \
  --add-exports=javafx.graphics/com.sun.javafx.tk=ALL-UNNAMED \
  --add-exports=javafx.graphics/com.sun.glass.ui=ALL-UNNAMED \
  $JLINK_VM_OPTIONS -m com.fuck.fuck/com.fuck.fuck.HelloApplication "$@"