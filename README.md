<div align="center">

# Aquaticcy
**A real-time multiplayer Tic Tac Toe app built with Flutter and Firebase.**

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)

Sign up, pick a character skin, battle a friend in a private room with a shareable room code, and climb the global leaderboard!

</div>

---

## Features

- **Authentication** — Email/password sign up and sign in via Firebase Auth, with duplicate-email and password-confirmation checks.
- **Real-time Multiplayer** — Create a game room and get a randomized 4-character room code. Share it with a friend, they join, and both players see moves sync instantly via Firestore streams — no refresh needed.
- **Character Skins** — Choose your player icon from a roster of 9 characters on the Choose page; your pick is saved to your profile.
- **Profile Page** — View your profile picture, score, and live win rate.
- **Leaderboard** — Top 10 players ranked by score, updated in real time from Firestore.
- **Scoring System**
  - **Win** → **+100** points
  - **Draw** → **+25** points
  - **Loss** → **+0** points
  - *Win rate = `gamesWon / (gamesWon + gamesLost + gamesDrawn)`*
- **Dynamic Audio System** — Chill background music plays across menu pages; the moment you enter a match it switches to a more intense battle soundtrack, plus dedicated win/loss/draw sound cues. Includes a mute toggle and volume slider.
- **Custom UI** — Hand-styled pixel-art aesthetic with hard drop-shadows, custom buttons, and animated confirmation badges (copied room code, saved skin, etc.).

---

## Tech Stack

| Layer          | Technology                             |
|----------------|----------------------------------------|
| **Framework**  | Flutter                                |
| **Auth**       | Firebase Authentication                |
| **Database**   | Cloud Firestore *(real-time sync)*     |
| **Audio**      | `audioplayers` package                 |
| **State**      | `StatefulWidget` + `StreamBuilder`     |

---

## Project Structure

```text
lib/
├── Auth/
│   └── Wrapper.dart          # Routes user to Login or Home based on auth state
├── Services/
│   ├── game_services.dart    # Room creation/joining, moves, win detection, leave/end game
│   └── user_service.dart     # User CRUD, score/stat updates, profile picture updates
├── models/
│   ├── game_model.dart       # Game state (board, turn, players, status, winner)
│   └── user_model.dart       # User profile (name, email, stats, score, skin)
├── pages/
│   ├── Login.dart            # Sign up / sign in with tabbed UI
│   ├── home.dart             # Battle hub — create or join a game
│   ├── Ticcy.dart            # Live game board + real-time match state
│   ├── Choose.dart           # Character/skin picker
│   ├── Profile.dart          # Player stats and profile picture
│   └── Leaderboard.dart      # Top 10 players by score
├── routes/
│   └── approutes.dart        # Named route constants
├── widgets/
│   ├── appbar.dart
│   ├── bottomnavbar.dart
│   ├── drawer.dart           # Options drawer (audio, logout, leave room, profile)
│   └── audiomaster.dart      # Global audio playback + volume control widget
└── main.dart
```

---

## Firebase Setup

This project expects two Firestore collections:

- **`users`** — one document per user (keyed by UID), storing name, email, profile picture path, and game stats.
- **`games`** — one document per room (keyed by the 4-character room code), storing the board, current turn, player UIDs, status (`waiting` / `playing` / `finished`), and winner.

### To run this project yourself:

1. Create a [Firebase project](https://console.firebase.google.com/).
2. Enable **Email/Password** sign-in under Authentication.
3. Create a **Cloud Firestore** database.
4. Run `flutterfire configure` *(or manually add your `google-services.json` / `GoogleService-Info.plist`)* to connect the app to your Firebase project.
5. Add your character/skin images under `assets/images/` and audio tracks under `assets/audio/`, matching the paths referenced in the code.

---

## Getting Started

First, make sure you've completed the Firebase setup above — the app won't build/run correctly without a connected Firebase project.

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run
```
