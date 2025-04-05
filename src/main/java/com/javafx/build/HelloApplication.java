package com.javafx.build;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;

import java.io.IOException;

public class HelloApplication extends Application {

    @Override
    public void start(Stage stage) throws IOException {
        // Add System property to help with macOS rendering
        System.setProperty("prism.order", "j2d");

        // We no longer directly call internal JavaFX methods
        // Instead we rely on the VM arguments in the launcher script

        FXMLLoader fxmlLoader = new FXMLLoader(HelloApplication.class.getResource("hello-view.fxml"));
        Scene scene = new Scene(fxmlLoader.load(), 320, 240);
        stage.setTitle("Hello!");
        stage.setScene(scene);

        // Add proper application closing handler
        Platform.setImplicitExit(true);

        // Use Platform.runLater to avoid some macOS rendering issues
        Platform.runLater(() -> {
            stage.show();
        });
    }

    public static void main(String[] args) {
        launch();
    }
}