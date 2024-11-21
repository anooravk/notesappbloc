Project Overview

This Flutter project is a Notes App made with Bloc that allows users to create, read, update, and delete notes. Additionally, it integrates user authentication,
enabling users to sign in with social media accounts (such as Google or Apple) to manage their notes securely. 


Cloning and Setting Up the Project

1. Clone the Project
If the project is hosted on a platform like GitHub, the first step is to clone the repository to your local machine. Open your terminal and execute the following command:
git clone <repository-url>
This will create a local copy of the project on your system.

2. Navigate to the Project Directory
Once the project has been cloned, move into the project folder using the following command:
cd <project-folder>
This will set the working directory to your Flutter project.

3. Install Dependencies
Now that you’re inside the project directory, you’ll need to install the necessary dependencies for the project to work. In your terminal (or IDE terminal), run:
flutter pub get
This command will fetch all the required packages and set up your Flutter project.


Running the Project

1. Run the Application
To launch the app on an Android or iOS emulator, or a connected physical device, run the following command:
flutter run
This will compile the project, install the app, and launch it in the selected device or emulator.

2. Run on a Specific Device
If you have multiple devices or emulators connected, you can specify the target device. To view all connected devices, use the command:
flutter devices
Then, run the app on a specific device by using:
flutter run -d <device_id>
Where <device_id> is the identifier of the device you want to target.

3. Debugging the App
For a more interactive development experience, run the app in debug mode. This allows you to set breakpoints, use the Flutter Inspector, and log app behavior. To run in debug mode, simply use:
flutter run --debug
This will open up additional tools for inspecting the app and troubleshooting any issues.

