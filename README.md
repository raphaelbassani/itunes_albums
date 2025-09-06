# iTunes Albums Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg)](https://flutter.dev/)
[![Build](https://img.shields.io/github/actions/workflow/status/your-username/itunes_albums_flutter/flutter.yml?branch=main)](https://github.com/your-username/itunes_albums_flutter/actions)
[![Coverage](https://img.shields.io/badge/coverage-0%25-red.svg)](https://github.com/your-username/itunes_albums_flutter)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A **Flutter** application that consumes the **iTunes RSS API** and displays the **Top 100 Albums** in an interactive, animated UI.

## Features

* Display top albums from iTunes with album cover, artist, release date, genre, and track count.
* Animated navigation between albums with swipe gestures.
* Pull-to-refresh functionality.
* Skeleton loading animations using **Shimmer**.
* Error handling with retry button.
* Fully tested with **unit**, **widget**, and **integration tests**.

## Screenshots

*Add screenshots of your app here.*

## Technologies & Packages

* **Flutter 3.x**
* **Riverpod** for state management
* **Shimmer** for loading skeletons
* **CachedNetworkImage** for cached image loading
* **mocktail** for mocking dependencies in tests
* **integration\_test** for full workflow testing
* **Equatable / Either** for models and error handling

## Architecture

This project uses the **MVVM** architecture with a modular folder structure:

```
lib/
├─ core/           # Extensions, enums, generic UI components
├─ features/
│  └─ albums/
│     ├─ data/     # Models, Repositories, Errors
│     ├─ providers # State management with Riverpod
│     ├─ presentation/
│     │  ├─ pages/   # HomePage, AlbumPage
│     │  └─ widgets/ # Reusable UI widgets
```

### State Management

* `AlbumViewModel` (StateNotifier) manages `loading`, `success`, and `failure` states.
* `HomePage` and `AlbumPage` observe providers via `ConsumerWidget` or `ValueListenableBuilder`.

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/itunes_albums_flutter.git
   ```
2. Navigate to the project folder:

   ```bash
   cd itunes_albums_flutter
   ```
3. Install dependencies:

   ```bash
   flutter pub get
   ```
4. Run the app:

   ```bash
   flutter run
   ```

## Testing

Run all tests (unit, widget, integration):

```bash
flutter test
flutter test integration_test
```

Test folder structure:

```
test/
├─ unit/        # Logic and providers
├─ widget/      # UI/widget tests
└─ integration/ # Full workflow tests
```

## Contributing

1. Fork the repository
2. Create a feature branch (`feature/your-feature`)
3. Commit your changes (`git commit -m 'Add feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

## License

This project is licensed under the **MIT License**.
