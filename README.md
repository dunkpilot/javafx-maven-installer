# JavaFX Maven Installer

It can be tedious trying to figure out how to run and create installers for JavaFX applications because of their native oS requirements this 
repository provides an example with maven that shows how to run a javafx application and then create a native OS installer for it. it is done
with maven commands and also provided scripts to do some tricks for make native OS installers work. 

## Prerequisites
- Please Note** Its common to run into the issue of not using a JDK that has the JFX OS native modules, download the JDK for your OS here https://bell-sw.com/libericajdk/
- Java JDK 17 or newer (Liberica JDK with JavaFX modules recommended)
- Apache Maven 3.6.0 or newer
- For native packaging: JDK 14+ with jpackage support

## Project Structure

```
project-root/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── module-info.java
│   │   │   └── com/javafx/build/
│   │   │       ├── HelloApplication.java
│   │   │       └── HelloController.java
│   │   └── resources/
│   │       └── com/javafx/build/
│   │           └── hello-view.fxml
├── pom.xml
├── build-app.sh
├── build-native.sh
├── build-app.bat
└── build-native.bat
```

## Quick Start

### Build and Run the Application

On macOS/Linux:
```bash
./build-app.sh
./target/app/bin/app
```

On Windows:
```
build-app.bat
target\app\bin\app.bat
```

### Create a Native Installer

On macOS/Linux:
```bash
./build-native.sh
```

On Windows:
```
build-native.bat
```

The native installer will be created in the `target/dist` directory.

## Configuration Details

### POM Configuration

The `pom.xml` file is configured with:
- JavaFX dependencies
- Maven Compiler Plugin
- JavaFX Maven Plugin
- Maven Shade Plugin for creating executable JARs
- JPackage Maven Plugin for native installers

### macOS Compatibility

The application includes special configurations for macOS compatibility:
- Proper JavaFX module exports
- J2D rendering pipeline configuration
- Custom startup script with necessary VM arguments

### Cross-Platform Support

The build scripts detect the current OS and apply the appropriate packaging options:
- macOS: DMG installer
- Linux: DEB installer
- Windows: EXE installer with shortcuts

## Build Scripts

The repository includes four build scripts:

1. `build-app.sh` (macOS/Linux): Builds the application and creates a runtime image
2. `build-native.sh` (macOS/Linux): Creates a native installer
3. `build-app.bat` (Windows): Windows version of the build script
4. `build-native.bat` (Windows): Windows version of the native installer script

## Troubleshooting

### macOS Issues

If you encounter issues on macOS:
- Ensure your JDK is compatible with your macOS version
- Check that the startup script contains the proper VM arguments
- Try setting `-Dprism.order=j2d` if you see rendering issues

### Module Issues

If you see "module not exported" errors:
- Ensure the proper `--add-exports` flags are in your startup script
- Check that your module-info.java has the right requires/exports statements

## Customization

### Application Name and Vendor

Edit the following properties in the POM file:
```xml
<jpackage.appVersion>1.0.0</jpackage.appVersion>
<jpackage.vendor>YourCompany</jpackage.vendor>
```

### Main Class

If you rename your main class, update the mainClass property in the POM:
```xml
<mainClass>com.yourpackage/com.yourpackage.YourMainClass</mainClass>
```

## License

[Add your license information here]=