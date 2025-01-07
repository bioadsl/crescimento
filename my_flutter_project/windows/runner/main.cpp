#include <flutter/flutter_view_controller.h>
#include <windows.h>
#include <iostream>

int APIENTRY wWinMain(HINSTANCE instance, HINSTANCE prev, wchar_t* command_line, int show_command) {
    // Initialize the Flutter engine
    flutter::FlutterViewController flutter_controller(instance);
    
    // Run the Flutter application
    if (!flutter_controller.Run()) {
        std::cerr << "Failed to run the Flutter application." << std::endl;
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}