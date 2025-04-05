module com.javafx.build {
    requires javafx.controls;
    requires javafx.fxml;

    requires org.controlsfx.controls;
    requires org.kordamp.bootstrapfx.core;

    opens com.javafx.build to javafx.fxml;
    exports com.javafx.build;
}