# Hot Wheels Collection App - Implementation Plan

## Context

Build a cross-platform mobile app (iOS + Android) to store and organize a Hot Wheels die-cast car collection. The app is hosted on Firebase and features camera-based recognition to both identify Hot Wheels models by name and find matching cars in the user's own collection using image similarity.

**Tech stack**: Flutter + Firebase (Auth, Firestore, Cloud Storage, Cloud Functions) + Google Cloud Vision API + CLIP embeddings

---

## Architecture Overview

```
Flutter App (iOS + Android)
├── Camera (ML Kit on-device detection)
├── Firebase Auth (Google Sign-In)
├── Firestore (collection data + vector embeddings)
├── Cloud Storage (car images)
└── Recognition Pipeline
    ├── ML Kit: on-device object detection (is it a car?)
    ├── Cloud Vision API: identify model name/series
    └── CLIP embeddings: match against user's collection

Cloud Functions (Python)
├── identify_car      → Vision API label/web/logo detection
├── generate_embedding → CLIP image embedding → Firestore vector
└── search_similar    → findNearest vector search on user's embeddings
```

---

## Project Setup

1. Create Flutter project: `flutter create --org com.hotwheels --project-name hotwheels_app .`
2. Create Firebase project + `flutterfire configure`
3. Enable: Firebase Auth (Google), Firestore, Cloud Storage, Cloud Functions (Blaze plan)
4. Enable Cloud Vision API in GCP Console

**State management**: Riverpod 3.x (best fit for Firebase streams + CRUD mutations)
**Navigation**: GoRouter with auth-based redirects
**Models**: Freezed for immutable data classes

---

## Key Dependencies

```yaml
# Firebase
firebase_core, firebase_auth, cloud_firestore, firebase_storage, cloud_functions

# Auth
google_sign_in

# State & Navigation
flutter_riverpod, riverpod_annotation, go_router

# Camera & Images
camera, image_picker, image_cropper, cached_network_image, photo_view

# ML Kit
google_mlkit_object_detection, google_mlkit_image_labeling

# Code generation
freezed, freezed_annotation, json_serializable, json_annotation, build_runner
riverpod_generator, riverpod_lint
```

---

## Project Structure

```
lib/
├── main.dart / app.dart                    # Entry point, MaterialApp.router
├── firebase_options.dart                   # Generated
├── core/
│   ├── constants/ (firestore_paths, storage_paths, app_constants)
│   ├── theme/ (app_theme, app_colors)
│   ├── utils/ (image_utils, validators)
│   └── errors/ (app_exception, error_handler)
├── models/
│   ├── car_model.dart                      # HotWheelsCar + CarImage (freezed)
│   ├── user_model.dart                     # AppUser (freezed)
│   └── recognition_result.dart             # RecognitionResult (freezed)
├── services/
│   ├── auth_service.dart                   # Firebase Auth + Google Sign-In
│   ├── firestore_service.dart              # Firestore CRUD
│   ├── storage_service.dart                # Cloud Storage upload/download/delete
│   ├── functions_service.dart              # Cloud Functions callable wrappers
│   ├── ml_kit_service.dart                 # On-device object detection
│   └── recognition_service.dart            # Orchestrates full recognition pipeline
├── providers/
│   ├── auth_provider.dart                  # Auth state + sign-in/out
│   ├── car_providers.dart                  # Collection CRUD + streams
│   ├── image_providers.dart                # Image upload
│   ├── recognition_providers.dart          # Recognition pipeline
│   └── router_provider.dart                # GoRouter with auth redirect
├── features/
│   ├── auth/ (login_screen, google_sign_in_button)
│   ├── splash/ (splash_screen)
│   ├── collection/ (collection_list, car_detail, add_edit_car, car_card, etc.)
│   ├── camera/ (camera_scan_screen, recognition_result_screen, camera_overlay)
│   ├── search/ (search_screen)
│   └── settings/ (settings_screen)
└── widgets/ (shared: app_scaffold, loading_overlay, error_view)

functions/                                  # Firebase Cloud Functions (Python)
├── main.py                                 # Function entry points
├── requirements.txt
├── embedding_generator.py                  # CLIP embedding logic
├── vision_recognizer.py                    # Cloud Vision API wrapper
└── utils.py
```

---

## Firestore Schema

```
users/{userId}                          # Auth UID
  displayName, email, photoUrl, totalCars, createdAt, updatedAt

  cars/{carId}                          # Sub-collection
    name: string                        # e.g., "Twin Mill"
    series: string                      # e.g., "HW Race Day"
    year: int                           # e.g., 2024
    notes: string
    images: [{id, url, storagePath, isPrimary, embeddingRef, createdAt}]
    createdAt, updatedAt

  embeddings/{embeddingId}              # Sub-collection for vector search
    carId: string                       # Reference to car
    imageUrl: string
    vector: vector(512)                 # CLIP embedding (Firestore native vector)
    createdAt
```

**Storage paths**: `users/{userId}/cars/{carId}/{imageId}.jpg`

---

## Screens

| Screen | Route | Description |
|--------|-------|-------------|
| Splash | `/` | Firebase init, auth check |
| Login | `/login` | Google Sign-In |
| Collection List (Home) | `/collection` | Grid of cars, stats header, FAB to add |
| Car Detail | `/collection/:carId` | Image carousel, metadata, edit/delete |
| Add/Edit Car | `/collection/add` or `/:carId/edit` | Form + image picker |
| Camera Scan | `/scan` | Live camera with ML Kit overlay |
| Recognition Results | `/scan/results` | Identified model + collection matches |
| Search | `/search` | Text search across name/series/year |
| Settings | `/settings` | Account info, sign out |

Bottom nav bar: Collection, Scan, Search, Settings

---

## Camera Recognition Pipeline

```
User points camera → ML Kit detects "toy car" (on-device, real-time)
    → User taps capture
    → Image uploaded to Cloud Storage (temp)
    → TWO Cloud Functions run IN PARALLEL:
        1. identify_car: Vision API → model name + series + confidence
        2. search_similar: CLIP embedding → findNearest → top 5 similar cars
    → Results screen shows both:
        Section A: "This looks like: [Model Name] - [Series]"
        Section B: "Similar in your collection: [matched cars]"
```

**Key details**:
- ML Kit runs on-device for real-time bounding box overlay (no cloud calls)
- Vision API uses label + web + logo detection to identify the specific model
- CLIP (openai/clip-vit-base-patch32) generates 512-dim embeddings
- Firestore native `findNearest` for vector similarity search
- Vector search only available in server SDKs → must use Cloud Functions

---

## Security Rules

**Firestore**: Users can only read/write their own `users/{userId}` subtree. Car documents validated (name required, year 1968-2030, max 20 images). Embeddings writable only by Cloud Functions (admin SDK).

**Storage**: Users can only access `users/{userId}/**`. Uploads limited to images, max 10MB.

---

## Implementation Order

### Phase 1: Foundation
- Create Flutter project + Firebase project + dependencies
- Set up folder structure, theme, data models (Freezed), path constants
- Run `build_runner`

### Phase 2: Authentication
- `AuthService` (Firebase Auth + Google Sign-In)
- `auth_provider.dart` (Riverpod)
- Splash + Login screens
- GoRouter with auth redirect
- Auto-create user profile in Firestore on first sign-in

### Phase 3: Core Collection CRUD
- `FirestoreService` + `StorageService`
- `car_providers.dart` (stream + mutations)
- Collection List screen (grid with car cards)
- Add/Edit Car screen (form + image picker + upload)
- Car Detail screen (carousel, metadata, edit/delete)
- Deploy Firestore + Storage security rules

### Phase 4: Search & Polish
- Text search screen (prefix matching on name/series)
- Settings screen
- Bottom navigation bar
- Loading states, error handling, empty states

### Phase 5: Camera & On-Device ML
- `MlKitService` (object detection + image labeling)
- Camera Scan screen with live preview + bounding box overlay
- Capture flow (freeze frame → prepare for cloud processing)
- Test on physical devices (ML Kit requires real hardware)

### Phase 6: Cloud Functions & Vision API
- Initialize Cloud Functions (Python)
- `identify_car` function (Vision API)
- `FunctionsService` in Flutter (callable wrappers)
- Recognition Result screen
- "Add to collection" from recognition results (pre-filled fields)

### Phase 7: Embeddings & Collection Matching
- `generate_embedding` function (CLIP model)
- Create Firestore vector index on `embeddings` collection
- `search_similar` function (findNearest)
- Integrate embedding generation into add-car flow (fire-and-forget)
- Update Recognition Result screen with collection matches
- Backfill existing images with embeddings

### Phase 8: Final Polish
- Performance optimization (lazy loading, pagination)
- Offline support (Firestore persistence is on by default)
- Error handling audit
- App icons and splash screen
- Build APK/IPA

---

## Verification Plan

1. **Auth**: Sign in with Google → verify user doc created in Firestore → sign out → verify redirect to login
2. **CRUD**: Add car with photos → verify in Firestore + Storage → edit → delete → verify cleanup
3. **Camera**: Open scan → verify bounding box overlay on toy car → capture → verify results screen
4. **Vision API**: Scan a known Hot Wheels car → verify model name identified correctly
5. **Collection matching**: Add several cars → scan one of them → verify it appears in "similar" results
6. **Security**: Attempt to access another user's data → verify denied
7. **Run tests**: `flutter test` for unit/widget tests
