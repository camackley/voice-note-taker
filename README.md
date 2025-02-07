# Voice Note Taker - Flutter Application

## Overview
Voice Note Taker is a Flutter-based application that allows users to record, upload, and play back voice notes. The app utilizes Firebase for cloud storage and Firestore for managing metadata. It employs Riverpod for state management to ensure a clean and scalable architecture.

## Features
- Record voice notes.
- Upload recordings to Firebase Storage.
- Show real-time upload progress.
- Store metadata in Firestore.
- Play back voice notes from the cloud.
- State management using Riverpod.

## Getting Started
### Prerequisites
Before running the application, ensure you have the following installed:
- Flutter SDK (latest stable version)
- Dart SDK
- Firebase CLI (See official [Firebase CLI guide](https://firebase.google.com/docs/cli))
- An active Firebase project with Storage and Firestore enabled

### Setup
1. **Clone the repository**
   ```sh
   git clone https://github.com/camackley/voice-note-taker.git
   cd voice-note-taker
   ```

2. **Install dependencies**
   ```sh
   flutter pub get
   ```

3. **Run the application**
   ```sh
   flutter run
   ```

4. **(Optional) Setup Firebase using FlutterFire CLI**
   - Run the following command in the root of your project:
     ```sh
     flutterfire configure
     ```
   - Select your Firebase project and choose the platforms you want to configure.
   - This will generate `firebase_options.dart` inside the `lib` directory, automatically setting up Firebase for your project.

## What Could Be Improved With More Time
1. **Unit and Integration Tests**
   - Implement comprehensive unit tests for recording, uploading, and playback functionalities.
   - Add widget tests for UI components.
   - Automate testing using `flutter test`.

2. **Error Handling Enhancements**
   - Implement robust error handling for network failures and permission denials.
   - Display user-friendly messages for errors in Firebase interactions.

3. **Scalability Considerations**
   - Improve storage optimization by compressing audio files before upload.
   - Implement caching mechanisms to minimize network requests for repeated audio playback.
   - Explore alternatives such as a dedicated backend service for processing audio files if the project scales significantly.
