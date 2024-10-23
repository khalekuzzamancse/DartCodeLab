### How to Use a Separate Dart SDK (e.g., Dart Dev SDK 3.7.0)

If you need to use a separate Dart SDK (such as a specific version like Dart Dev SDK 3.7.0) for a particular project, follow these steps to switch to it temporarily without affecting other projects.

#### Steps:

1. **Download and Install the Dart Dev SDK (3.7.0)**:
   - Download the Dart Dev SDK (version 3.7.0) and extract it to a specific directory (e.g., `E:\installed_apps\dart_dev_sdk\dart-sdk`).

2. **Add the Dart Dev SDK Path to the Environment Variables**:
   - **Add** the path to the Dart Dev SDK’s `bin` folder (e.g., `E:\installed_apps\dart_dev_sdk\dart-sdk\bin`).
   - **Move the Dart Dev SDK Path to the Top** of the list, **before** any existing Dart or Flutter paths to ensure the system prioritizes the dev SDK.

3. **Verify the Switch to Dart Dev SDK**:
   - Open a new terminal session and run:
     ```bash
     dart --version
     ```
   - Ensure that it shows the Dart Dev SDK version (e.g., 3.7.0-something).

4. **Switch Back to the Original SDK After Finishing**:
   - Once you’ve finished working with the Dart Dev SDK, go back to the **Environment Variables** and move the Dart Dev SDK path **below** any other Dart or Flutter paths.
   - This ensures your other projects using the stable or previous SDK versions are not affected.

5. **Verify the Switch Back**:
   - After moving the Dart Dev SDK path back down, open a new terminal and run:
     ```bash
     dart --version
     ```
   - Confirm that it’s now using the previous version of Dart.


## Using the macro
- Create a new file `analysis_options.yaml` as the root of your packages in which you want to use macros
   ```yaml
   analyzer:
  enable-experiment:
    - enhanced-parts
    - macros
   ```
- Configure the the `pubspec.yaml` g.
 ```yaml
      name: macro_concept
      publish_to: none
      environment:
      sdk: ">=3.6.0-0 <4.0.0"
      dependencies:
      macros: ^0.1.0-main
      json: ^0.20.2 
      dev_dependencies:
      _fe_analyzer_shared: any
      args: ^2.3.0
      checks: ^0.2.0
      dart_style: ^2.2.1
   ```

 - You can not run direcly the `main` function  use the  following command:
   - Move the directory where 
   - `dart run --enable-experiment=macros main.dart`
   - here `main.dart` is the file file in that current directory
   - if you have the file in the `lib` directory then move to the libs and then run this command with the file name
-Additionally tips:
   - In Intellij or Android Studio you can configure
   this, just the `--enable-experiment=macros` in the `additional run args` field and in the `dart entry point` field refer the absolute path of `main.dart`

- Note: After doing all of this if not working then 
clean the cache such as clean the `.dart tool` , `pubspec.lock` directory and other and again fetch the dependencies again.