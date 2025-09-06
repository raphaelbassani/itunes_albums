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

* **Flutter** 3.35.2
* **Riverpod** for state management
* **Dio** for requests
* **Shimmer** for loading skeletons
* **CachedNetworkImage** for cached image loading
* **mocktail** for mocking dependencies in tests
* **Equatable/Either** for models and error handling

## Architecture

This project follows **Clean Code**, **SOLID principles**, and **Domain-Driven Design (DDD)**:

* **Clean Code**: Modular folder structure, readable names, single responsibility per class, and clear separation of concerns.
* **SOLID**:
    * **S**: Each class has a single responsibility (e.g., `AlbumViewModel` handles album state only).
    * **O**: Open/Closed principle is applied; new features can be added via new widgets or providers.
    * **L**: Liskov substitution used in mocks and abstractions for testing.
    * **I**: Interfaces and abstract classes used for repositories to allow dependency injection.
    * **D**: Dependency Inversion applied with Riverpod and repository abstractions.
* **DDD**:
    * `AlbumModel` represents the domain entity.
    * `AlbumRepository` abstracts data sources (API or local cache).
    * `AlbumViewModel` contains domain logic for album fetching and state transitions.

### Folder Structure

```
lib/
├─ core/          
│  └─ enums/        # view model status, slide direction
│  └─ extensions/   # context, navigation
│  └─ ui/           # All reusable UI widgets
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
├─ core/        # Enums, Extensions, and all UI widgets 
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
