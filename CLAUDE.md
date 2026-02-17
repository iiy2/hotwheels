# CLAUDE.md — Hot Wheels Collection App

This file provides context for AI assistants working in this codebase.

## Project Overview

**hotwheels_app** is a cross-platform Flutter application for managing a personal Hot Wheels die-cast car collection. It includes camera-based recognition using Google ML Kit and Firebase for backend services.

- **Platform targets**: Android, iOS, Web, macOS, Linux, Windows
- **Flutter SDK**: ^3.9.0-196.1.beta (beta channel required)
- **Package name**: `hotwheels_app`

---

## Common Commands

```bash
# Install dependencies
flutter pub get

# Run code generation (Freezed, Riverpod, JSON serialization)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation during development
dart run build_runner watch --delete-conflicting-outputs

# Static analysis
flutter analyze

# Run tests
flutter test

# Run the app
flutter run

# Build for a specific platform
flutter build apk          # Android
flutter build ios          # iOS
flutter build web          # Web
flutter build macos        # macOS
```

**Important**: Always run `dart run build_runner build` after modifying any file annotated with `@freezed`, `@riverpod`, or `@JsonSerializable`. Generated files (`.freezed.dart`, `.g.dart`) must not be edited manually.

---

## Architecture

The app follows a layered architecture:

```
lib/
├── main.dart               # Entry point — wraps app in ProviderScope
├── app.dart                # MaterialApp + router configuration
│
├── core/                   # Shared utilities (no business logic)
│   ├── constants/          # App-wide constants and Firestore/Storage paths
│   ├── errors/             # AppException hierarchy + ErrorHandler
│   ├── theme/              # Colors and ThemeData
│   └── utils/              # Image utilities, validators
│
├── models/                 # Immutable data models (Freezed + JSON)
├── services/               # Firebase integration layer (Auth, Firestore, Storage)
├── providers/              # Riverpod state management + GoRouter config
├── features/               # Screen-level UI organized by feature
│   ├── auth/               # Login screen
│   ├── splash/             # Splash/loading screen
│   ├── collection/         # List, detail, add/edit car screens
│   ├── camera/             # Camera scan screen (stub — ML Kit not yet wired)
│   ├── search/             # Text search screen
│   └── settings/           # User settings, sign-out
└── widgets/                # Reusable shared UI components
```

### Architectural Layers (dependency direction: top → bottom)

```
Features / Widgets
      ↓
  Providers  (Riverpod)
      ↓
  Services   (Firebase wrappers)
      ↓
  Models / Core
```

Features must not directly call Firebase; they go through providers → services.

---

## Key Technologies

| Concern | Library |
|---|---|
| State management | `flutter_riverpod` + `riverpod_annotation` |
| Navigation | `go_router` |
| Immutable models | `freezed` + `freezed_annotation` |
| JSON serialization | `json_serializable` + `json_annotation` |
| Auth | `firebase_auth` + `google_sign_in` |
| Database | `cloud_firestore` |
| File storage | `firebase_storage` |
| Cloud functions | `cloud_functions` |
| Camera | `camera`, `image_picker`, `image_cropper` |
| On-device ML | `google_mlkit_object_detection`, `google_mlkit_image_labeling` |
| Image display | `cached_network_image`, `photo_view` |

---

## Models

All models use **Freezed** for immutability and **json_serializable** for serialization. Each model file has two generated companion files:

```
lib/models/car_model.dart           # Source (edit this)
lib/models/car_model.freezed.dart   # Generated (do not edit)
lib/models/car_model.g.dart         # Generated (do not edit)
```

### HotWheelsCar

```dart
HotWheelsCar({
  String? id,               // Firestore document ID (excluded from toJson)
  required String name,     // Required, max 100 chars
  String series,            // Optional, max 100 chars, default ''
  int? year,                // Optional, 1968–2030
  String notes,             // Optional, default ''
  List<CarImage> images,    // Max 20, default []
  DateTime? createdAt,
  DateTime? updatedAt,
})
```

### CarImage

```dart
CarImage({
  required String id,          // Timestamp-based: millisecondsSinceEpoch
  required String url,         // Download URL from Firebase Storage
  required String storagePath, // Path in Storage bucket
  bool isPrimary,              // Default false
  String? embeddingRef,        // Reference to embeddings sub-collection
  DateTime? createdAt,
})
```

### AppUser

Mirrors Firebase Auth user info stored in Firestore under `users/{userId}`.

### RecognitionResult / SimilarMatch

Used for future ML-based similarity search results (not yet fully wired).

### TimestampConverter

A custom `JsonConverter` that handles Firestore `Timestamp` ↔ `DateTime` conversion transparently in all models.

---

## State Management (Riverpod)

Providers live in `lib/providers/`. Generated `.g.dart` files must stay in sync.

### Key Providers

| Provider | Type | Purpose |
|---|---|---|
| `authStateProvider` | `Stream<User?>` | Firebase auth state |
| `appUserProvider` | `AsyncValue<AppUser?>` | Current user's Firestore doc |
| `carsProvider` | `Stream<List<HotWheelsCar>>` | Real-time car collection |
| `carProvider(id)` | `AsyncValue<HotWheelsCar?>` | Single car document |
| `routerProvider` | `GoRouter` | Navigation router |

### Notifier Pattern

Mutating operations use `AsyncNotifier`/`Notifier` subclasses:

```dart
@riverpod
class AddCar extends _$AddCar {
  @override
  FutureOr<void> build() {}

  Future<void> add(HotWheelsCar car) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(firestoreServiceProvider).addCar(car));
  }
}
```

Always use `_requireUserId()` (a helper on providers that need auth) to assert the user is signed in before performing Firestore operations.

---

## Navigation (GoRouter)

Defined in `lib/providers/router_provider.dart`. Routes:

| Path | Screen | Auth Required |
|---|---|---|
| `/` | SplashScreen | No |
| `/login` | LoginScreen | No (redirect if authed) |
| `/collection` | CollectionListScreen | Yes |
| `/collection/add` | AddEditCarScreen | Yes |
| `/collection/:carId` | CarDetailScreen | Yes |
| `/collection/:carId/edit` | AddEditCarScreen | Yes |
| `/scan` | CameraScanScreen | Yes |
| `/search` | SearchScreen | Yes |
| `/settings` | SettingsScreen | Yes |

The router uses a `redirect` callback that checks `authStateProvider`. Unauthenticated users are sent to `/login`; authenticated users are sent away from `/` and `/login` to `/collection`.

Bottom navigation wraps `/collection`, `/scan`, `/search`, `/settings` in a `ShellRoute` with `AppScaffold`.

---

## Firebase Data Structure

### Firestore

```
users/{userId}
  displayName: string
  email: string
  photoUrl: string
  totalCars: int
  createdAt: Timestamp
  updatedAt: Timestamp

  cars/{carId}
    name: string         (required)
    series: string
    year: int
    notes: string
    images: Array<CarImage>
    createdAt: Timestamp
    updatedAt: Timestamp

  embeddings/{embeddingId}   (written by Cloud Functions only)
    carId: string
    imageUrl: string
    vector: vector(512)      (CLIP ViT-B/32 embeddings)
    createdAt: Timestamp
```

### Cloud Storage

```
users/{userId}/cars/{carId}/{imageId}.jpg
users/{userId}/temp/{fileName}
```

### Security Rules Summary

- **Firestore**: Users can only read/write their own `users/{userId}/**`. The `embeddings` sub-collection is read-only for users (written by Cloud Functions via admin SDK).
- **Storage**: Users can only access their own `users/{userId}/**`. Files must be images (JPEG/PNG/WebP) and ≤ 10 MB.

---

## Error Handling

Errors use a sealed `AppException` hierarchy defined in `lib/core/errors/app_exception.dart`:

- `AuthException`
- `FirestoreException`
- `StorageException`
- `NetworkException`
- `ValidationException`
- `UnknownException`

`ErrorHandler.userMessage(exception)` converts any exception to a user-facing string. Always catch errors in providers and surface them via `AsyncValue.error` — never let raw Firebase exceptions reach the UI.

---

## Code Conventions

### File Naming

- Files: `snake_case.dart`
- Classes: `PascalCase`
- Functions/variables: `camelCase`
- Constants: `camelCase` (in constant classes, e.g., `AppConstants.maxImagesPerCar`)

### Model Files

Each model file must declare its generated parts at the top:

```dart
part 'car_model.freezed.dart';
part 'car_model.g.dart';
```

### Providers

- Use `@riverpod` annotation for code-generated providers
- Keep `keepAlive: true` only for providers that must survive widget disposal (e.g., `routerProvider`)
- Avoid `ref.read` inside `build()` — use `ref.watch` for reactive dependencies

### Widgets

- Prefer `ConsumerWidget` / `ConsumerStatefulWidget` over `StatelessWidget` / `StatefulWidget` when accessing providers
- `AppScaffold`: The bottom-nav shell — do not add navigation logic inside feature screens
- `ErrorView`: Standard error display with optional retry callback
- `LoadingOverlay`: Use for blocking async operations

### Constants

Key values from `lib/core/constants/app_constants.dart`:

```dart
maxImagesPerCar = 20
maxImageSizeBytes = 10 * 1024 * 1024  // 10 MB
embeddingDimension = 512              // CLIP ViT-B/32
similarSearchLimit = 5
minCarYear = 1968
maxCarYear = 2030
```

### Theme

Hot Wheels brand colors defined in `lib/core/theme/app_colors.dart`:

- Primary: `#CC0000` (red)
- Secondary: `#FF6600` (orange)

Material 3 is enabled. Use `Theme.of(context)` for colors — do not hardcode hex values in widgets.

---

## Testing

Tests live in `test/`. The existing suite covers widget rendering for `SplashScreen`, `ErrorView`, and `LoadingOverlay`.

Run tests with:

```bash
flutter test
```

When adding new features:
- Widget tests go in `test/` mirroring the `lib/` structure
- Use `ProviderScope` overrides to mock providers in widget tests
- Do not import Firebase packages directly in tests — mock via provider overrides

---

## Code Generation Workflow

When modifying annotated files, regenerate before testing:

1. Edit the source `.dart` file (e.g., add a field to a Freezed model)
2. Run: `dart run build_runner build --delete-conflicting-outputs`
3. Verify no analyzer errors: `flutter analyze`
4. Commit both the source file and all regenerated `.g.dart` / `.freezed.dart` files together

Never manually edit `*.freezed.dart` or `*.g.dart` files.

---

## Stub / Unimplemented Features

The following are planned but not yet implemented:

- **Camera scan** (`lib/features/camera/camera_scan_screen.dart`): ML Kit on-device object detection and Cloud Vision API integration
- **Embedding generation**: Cloud Functions (`identify_car`, `generate_embedding`, `search_similar`) are not yet deployed
- **Vector similarity search**: Firestore vector index exists in the schema but the search UI is not wired

See `PLAN.md` for the full 8-phase implementation roadmap.

---

## Claude Settings

Permitted commands are declared in `.claude/settings.json` and `.claude/settings.local.json`:

- `flutter pub get`
- `dart run build_runner build`
- `flutter analyze`
- `flutter test`
