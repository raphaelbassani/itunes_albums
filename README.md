# iTunes Albums Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-3.35.2-blue.svg)](https://flutter.dev/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

A **Flutter** application that consumes the **iTunes RSS API** and displays the **Top 100 Albums** in an interactive, animated UI.

## Features

* Display top albums from iTunes with album cover, artist, release date, genre, and track count.
* Animated navigation between albums with swipe gestures.
* Pull-to-refresh functionality.
* Skeleton loading animations using **Shimmer**.
* Error handling with retry button.
* Fully tested with +70 **unit** and **widget** tests.

## Technologies & Packages

* **Flutter 3.35.2
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
├─ core/          
│  └─ enums/        # view model status, slide direction
│  └─ extensions/   # context, navigation
│  └─ ui/           # All reusable ui widgets
├─ features/
│  └─ albums/
│     ├─ data/      # Datasources, Errors, Models, Repositories
│     ├─ providers/  # State management with Riverpod
│     ├─ presentation/
│     │  ├─ pages/   # HomePage, AlbumPage
│     │  ├─ viewmodels/   # AlbumViewModel
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
```

Test folder structure:

```
test/
├─ core/        # Enums, Extenions and all UI widgets 
└─ features/      # DataSources, Models, Repositories, Pages, ViewModels and Widgets
```

## Contributing

1. Fork the repository
2. Create a feature branch (`feature/your-feature`)
3. Commit your changes (`git commit -m 'Add feature'`)
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a Pull Request

## License

This project is licensed under the **MIT License**.
