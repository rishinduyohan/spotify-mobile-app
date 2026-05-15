# Spotify Clone (Flutter)

A full-stack Spotify clone app built with **Flutter**, following **Clean Architecture** principles and leveraging **Firebase** as the backend.

## Features

- **Authentication**: Email and Password Sign Up / Sign In using Firebase Auth.
- **Audio Playback**: Custom integrated audio player using `just_audio`.
- **Explore Music**: Home screen displaying the newest releases and daily playlists fetched from Firestore.
- **Favorites**: Users can like songs and save them to their personalized favorites list syncing directly with the database.
- **Profile Management**: Profile page to manage user details.
- **Theming**: Sleek UI supporting both Light and Dark modes.

## Tech Stack & Libraries

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: `flutter_bloc`
- **Dependency Injection**: `get_it`
- **Error Handling**: `dartz` (Functional programming with Either, Left, Right paradigms)
- **Architecture**: Domain-Driven Design / Clean Architecture (Presentation, Domain, Data layers)
- **Backend Service**: Firebase (Authentication, Cloud Firestore, Storage)

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.
- Recommended IDE: VS Code or Android Studio.
- An Android Emulator (with **Google Play Services** enabled) or physical device to run Firebase features successfully.

### Installation

1. **Clone the repository:**
   ```bash
   git clone <repository_url>
   cd spotify-app/spotify
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration:**
   - The project expects a configured Firebase project.
   - For Android, ensure `android/app/google-services.json` is correctly set up.
   - Enable **Firestore Database** and **Firebase Authentication (Email/Password)** from the Firebase Console before launching.

4. **Run the App:**
   ```bash
   flutter run
   ```

## Folder Structure Summary

```text
lib/
 ├── common/        # Shared widgets, helpers, and utilities across the app
 ├── core/          # Core app configurations (Themes, AppColors, Asset references)
 ├── data/          # Models, Repository implementations, Data Sources (Firebase)
 ├── domain/        # Entities, Repository Interfaces, UseCases
 ├── presantation/  # UI layer (Pages, Widgets, Blocs, Cubits)
 ├── main.dart             # App entry point
 └── service_locator.dart  # Dependency injection setup
```
