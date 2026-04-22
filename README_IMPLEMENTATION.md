# ArvyaX - Mini Meditation & Ambience App

A clean, minimal Flutter application for exploring ambiences, starting meditation sessions, and journaling reflections. Built with a focus on architecture, modularity, and user experience.

## Features

✨ **Ambience Library** - Browse and search through curated ambient soundscapes
🎵 **Audio Player** - Play ambiences with frequency wave visualization  
📝 **Journal Reflections** - Record thoughts and mood after each session
📊 **Session History** - View past reflections with timestamps
🎨 **Clean UI** - Minimal, premium design inspired by Apple's aesthetic
💾 **Local Persistence** - All data persisted using Hive

## Quick Start

### Prerequisites
- Flutter 3.11+
- Dart 3.11+

### Installation

1. Clone the repository:
```bash
cd arvyax
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate necessary files:
```bash
flutter pub run build_runner build
```

4. Add audio files to `assets/audio/` directory (optional - app works with placeholder audio)

5. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/                          # Core utilities and configuration
│   ├── theme/                     # Design tokens
│   │   ├── app_colors.dart       # Color palette
│   │   ├── app_decorations.dart  # Shadows, borders, gradients
│   │   ├── app_text_styles.dart  # Typography
│   │   ├── app_icons.dart        # Icon definitions
│   │   └── app_theme.dart        # Theme configuration
│   └── constants/                 # App constants
│
├── data/                          # Data layer
│   ├── datasources/               # Local data access
│   ├── repositories/              # Repository pattern
│   └── models/                    # Data models (Freezed)
│
├── features/                      # Feature modules
│   ├── ambience/                  # Ambience browsing feature
│   │   ├── bloc/                  # State management
│   │   └── presentation/          # UI screens
│   ├── player/                    # Audio player feature
│   │   ├── bloc/                  # State management
│   │   └── presentation/          # UI screens
│   └── journal/                   # Journal reflection feature
│       ├── bloc/                  # State management
│       └── presentation/          # UI screens
│
├── shared/                        # Shared across features
│   ├── components/                # Reusable UI components
│   └── widgets/                   # Shared widgets
│
├── config/                        # App configuration
│   ├── router.dart               # GoRouter configuration
│   └── service_locator.dart      # Dependency injection
│
└── main.dart                      # App entry point

assets/
├── audio/                         # Audio files (add here)
├── images/                        # Image assets
└── data/                          # Data files (ambiences.json)
```

## Architecture

### Clean Architecture with Feature-Based Structure

The app follows **Clean Architecture** principles with a clear separation of concerns:

#### **Layers:**

1. **Data Layer** (`data/`)
   - **DataSources**: Abstract local data access (Hive for persistence)
   - **Repositories**: Repository pattern implementing business logic
   - **Models**: Data models using Freezed for immutability

2. **Business Logic Layer** (`features/*/bloc/`)
   - **BLoCs**: State management using flutter_bloc
   - **Events**: User actions/requests
   - **States**: UI states representing the current business state

3. **Presentation Layer** (`features/*/presentation/`)
   - **Screens**: Full page UI components
   - **Widgets**: Reusable UI components in `shared/components/`

### Data Flow

```
UI (Screens) 
  ↓ (dispatch events)
BLoC (Business Logic)
  ↓ (call methods)
Repository (Data Access)
  ↓ (read/write)
DataSource (Hive/JSON)
  ↓ (persist/retrieve)
Local Storage
```

**Example: Loading Ambiences**
1. Screen dispatches `LoadAmbiences` event to `AmbienceBloc`
2. BLoC calls `AmbienceRepository.getAmbiences()`
3. Repository calls `AmbienceLocalDataSource.getAmbiences()`
4. DataSource loads from `ambiences.json` via rootBundle
5. Data flows back through repository → BLoC → UI with `AmbienceLoaded` state

## Packages & Why They Were Chosen

| Package | Purpose | Why Chosen |
|---------|---------|-----------|
| `flutter_bloc` | State Management | Industry standard, clean architecture friendly |
| `go_router` | Navigation | Modern, declarative routing with deep linking support |
| `hive` | Local Persistence | Fast, encrypted, reliable NoSQL database |
| `hive_flutter` | Hive integration | Seamless Hive setup in Flutter |
| `just_audio` | Audio Playback | Feature-rich, reliable audio player |
| `audio_session` | Audio Session Management | Proper audio handling and interruption management |
| `freezed_annotation` | Code Generation | Immutable models with copyWith() |
| `json_annotation` | JSON Serialization | Type-safe JSON conversion |
| `uuid` | Unique ID Generation | Generates unique IDs for entries |
| `intl` | Date/Time Formatting | Localized date and time formatting |
| `get_it` | Service Locator | Dependency injection container |
| `equatable` | Equality Comparison | Simplifies equality in value objects |
| `flutter_animate` | Animations | Declarative, performant animations |

## Key Components

### Reusable Components (`shared/components/`)

- **PrimaryButton**: CTA button with loading state
- **AmbienceCard**: Grid card for ambience preview
- **MiniPlayer**: Floating player when session is active
- **FrequencyWave**: Audio visualization with wave animation
- **MoodSelector**: 4-state mood picker for reflections
- **SensoryRecipeChips**: Tag display component
- **EmptyState**: Consistent empty state UI
- **ConfirmationDialog**: Reusable dialog component

### State Management

Each feature has its own BLoC:
- **AmbienceBloc**: Manages ambience list and filtering
- **PlayerBloc**: Manages audio playback and session state
- **JournalBloc**: Manages journal entries persistence

## UI/Design System

### Color Palette
- Primary: `#6366F1` (Indigo)
- Tag colors: Focus, Calm, Sleep, Reset (distinct colors)
- Mood colors: Calm, Grounded, Energized, Sleepy

### Design Principles
- Minimal aesthetic with ample whitespace
- Soft shadows for depth (not harsh)
- Rounded corners (12-24px) for friendly feel
- Large, legible typography
- Accessibility considered (color + icons)

### Responsive Design
- Works on small phones (320px) to tablets
- Grid adapts with safe breakpoints
- No hardcoded pixel sizes; uses spacing constants

## Persistence

### What's Persisted
- **Journal Entries**: Stored in Hive with mood and timestamp
- **Active Session State**: Last active session for mini-player restoration

### Storage Locations
- Journal entries: `journal_entries` Hive box
- Session state: `session_state` Hive box

## Audio Files

To use real audio, add `.mp3` or `.wav` files to `assets/audio/`:
- `forest.mp3`
- `ocean.mp3`
- `rain.mp3`
- `mountain.mp3`
- `urban.mp3`
- `garden.mp3`

The app includes frequency wave visualization that animates based on audio playback.

## Code Quality

- **No monolithic files**: Each feature in its own module
- **DRY principle**: Reusable components and utilities
- **Meaningful names**: Descriptive class, method, and variable names
- **Error handling**: Try-catch with user-friendly error states
- **State isolation**: BLoCs manage their own state independently

## Running Tests

```bash
# Run tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## Tradeoffs & Future Improvements

### Current Tradeoffs
1. **No audio visualization spectrum**: Frequency wave is animation-based, not real-time FFT
2. **No advanced player controls**: Seek is basic; no pitch/speed control
3. **Single theme**: No dark mode (can be added easily)
4. **No analytics**: Local logging only

### If We Had Two More Days
1. ✅ **Real-time frequency visualization** - Integrate FFT audio processing for actual spectrum data
2. ✅ **Dark mode** - Add theme toggling with Riverpod provider
3. ✅ **App lifecycle handling** - Pause timer when app backgrounded, resume on foreground
4. ✅ **Haptic feedback** - Add haptic response to button taps and key interactions
5. ✅ **Accessibility** - Text scaling support, screen reader optimization
6. ✅ **Search optimization** - Debounce search input, add search history
7. ✅ **Playlist support** - Queue multiple ambiences
8. ✅ **Social sharing** - Share reflections (with privacy controls)
9. ✅ **Analytics dashboard** - Session stats, mood trends over time
10. ✅ **Offline-first sync** - Sync journal when connection available

## Bonus Features Implemented

- ✅ Clean feature-based architecture with proper layer separation
- ✅ Reusable component system (no repeated code)
- ✅ Frequency wave visualization with smooth animations
- ✅ Mini-player for session continuation
- ✅ Comprehensive state management
- ✅ Local persistence with Hive
- ✅ Error handling and empty states

## Contributing

For architecture questions or improvements, refer to the feature modules for patterns.

## License

MIT License - See LICENSE file for details

---

**Built with ❤️ for mindfulness and clean code.**
