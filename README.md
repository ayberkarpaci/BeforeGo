# BeforeGo
**The checklist app that learns what you forget.**

BeforeGo is a Flutter app for situation-based preparation checklists (Library, Gym, Trip...).
Users tick items before leaving and record what they forgot afterwards. The app counts
forgotten items and moves the most frequently forgotten ones to the top of the next checklist.
Each checklist has a city, and a weather tip suggests extra items such as an umbrella.

> **Step 2 status:** the user interface is complete with working navigation and placeholder data.
> Firebase Authentication, Cloud Firestore and the Open-Meteo weather API are added in Step 3,
> so log in and sign up only validate the form for now.

## Requirements
- Flutter **3.47.6** (stable channel), Dart **3.13.5**
- An Android emulator, an iOS simulator or Chrome
- No extra packages are needed

Check your setup with:
```bash
flutter doctor
```

## Run the app
```bash
git clone https://github.com/ayberkarpaci/BeforeGo.git
cd BeforeGo
flutter pub get
flutter run
```
Without an emulator you can run it in Chrome:
```bash
flutter run -d chrome
```

To get past the login screen, enter any valid email address (for example `test@example.com`)
and any password.

## Run the tests
```bash
flutter analyze
flutter test
```
The tests cover form validation, the Home and Settings screens, the date helpers, and
overflow checks on small (360×640) and large (412×915) phone screens.

## Project structure
```
lib/
  main.dart            app entry point and theme
  routes.dart          route names for every screen
  models/              Checklist, ChecklistItem, WeatherInfo and placeholder data
  screens/             one file per screen
  widgets/             reusable widgets (buttons, text field, cards, tiles...)
  utils/               shared colors, text styles, spacing, theme and date helpers
assets/
  images/              logo and welcome illustration
  fonts/               Nunito (custom font)
test/                  widget and unit tests
```

## Screens
| # | Screen | Owner |
|---|---|---|
| 1 | Welcome | Umut Ölçer |
| 2 | Login | Umut Ölçer |
| 3 | Sign Up | Umut Ölçer |
| 4 | Forgot Password | Doğukan Demirkılıç |
| 5 | Home – My Checklists | Ayberk Arpacı |
| 6 | Checklist Detail | Doğukan Demirkılıç |
| 7 | New / Edit Checklist | Doğukan Demirkılıç |
| 8 | Packing Mode | Yusuf Metehan Yalçı |
| 9 | Forgot Report | Yusuf Metehan Yalçı |
| 10 | Statistics | Yusuf Metehan Yalçı |
| 11 | Settings | Ayberk Arpacı |

Checklist cover photos are loaded from [Unsplash](https://unsplash.com) (free to use under the Unsplash License).

## Group Details
CS310 Mobile Application Development – Fall 2026 – **Group 1**
TA: Emirhan Özkan · LA: Ayşe Çamlı

| Name | Student ID |
|---|---|
| Ayberk Arpacı (Step 1 Coordinator) | 32525 |
| Umut Ölçer | 32602 |
| Doğukan Demirkılıç | 28407 |
| Yusuf Metehan Yalçı | 33856 |
