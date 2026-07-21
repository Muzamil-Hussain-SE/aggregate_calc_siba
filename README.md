# SIBA Admission Predictor 🎓

A simple Flutter application that helps prospective students predict which academic programs they are eligible for at SIBA (Sukkur IBA University) based on their test/entry score, using each program's merit threshold.

## Features

- 📊 **Instant Eligibility Check** – Enter your test score and instantly see which programs you qualify for.
- 🏛️ **Multiple Departments Covered** – Includes programs from Computer Science, Business Administration, Electrical Engineering, Computer System Engineering, Mathematics, Media & Communication, Education, and Physical Education.
- 📱 **Responsive Layout** – Automatically adapts between landscape (side-by-side) and portrait (stacked) layouts depending on screen orientation/size.
- ✅ **Input Validation** – Ensures only valid numeric scores (0–100) are accepted.
- 🎨 **Modern UI** – Dark gradient theme with rounded cards, gradient buttons, and a styled credit footer.



## How It Works

1. Enter your test score (0–100) in the input field.
2. Tap **Check**.
3. The app compares your score against the merit threshold of each program.
4. All programs where `your score >= merit` are displayed in a scrollable list.
5. If no programs match, a "better luck next time" message is shown.

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Packages:**
  - [`animated_text_kit`](https://pub.dev/packages/animated_text_kit)
  - `flutter/services` (for input formatting)

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed
- A configured emulator or physical device

### Installation

```bash
# Clone the repository
git clone <your-repo-url>
cd <project-folder>

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Dependencies

Add the following to your `pubspec.yaml` if not already present:

```yaml
dependencies:
  flutter:
    sdk: flutter
  animated_text_kit: ^latest_version
```

## Project Structure

```
lib/
└── main.dart   # Contains the entire app: UI, predictor logic, and program data
```

## Known Limitations / Notes

- Program merit data (`programs` list) is hardcoded in `main.dart`. To update thresholds or add new programs, edit the `programs` list directly.
- The predictor logic (`checkMerit`) uses simple global state (`newList`, `_checked`) rather than a state management solution — suitable for a small app but could be refactored (e.g., with `Provider` or `Riverpod`) for scalability.
- Score validation currently checks for values greater than 100, but does not explicitly block negative numbers.
- Image assets (like the SIBA logo) are loaded via a network URL and require an internet connection to display.

## Contributing

Contributions, bug reports, and suggestions are welcome. Feel free to open an issue or submit a pull request.

## Credits

Made with ❤️ by **Muzamil Hussain**

## License

This project currently has no explicit license. Add a `LICENSE` file if you'd like to make usage terms clear (e.g., MIT, Apache 2.0).
