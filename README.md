# Paper Hangman

Paper Hangman is a cozy Android-first Flutter game inspired by paper notebook hangman.

## Features

- Home, category, game, and settings screens
- Local word lists with category selection
- Accent-insensitive guesses for Brazilian words
- Light notebook and dark night notebook themes
- Simple clean architecture with `ChangeNotifier`

## Structure

```text
lib/
  main.dart
  core/
  data/
  application/
  presentation/
```

## Running

1. Install Flutter locally.
2. Create or update `local.properties` with your Android and Flutter SDK paths if needed.
3. Run:

```bash
flutter pub get
flutter run
```
