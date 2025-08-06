# Scripts Documentation

## Feature Generator Script

The `generate_feature.sh` script helps you quickly scaffold a new feature in your Flutter project following a clean architecture pattern.

### Usage

1. Make the script executable (one-time setup):
```bash
chmod +x scripts/generate_feature.sh
```

2. Generate a new feature:
```bash
./scripts/generate_feature.sh <feature_name>
```

Example:
```bash
./scripts/generate_feature.sh user_profile
```

### Generated Structure

For a feature named `example`, the script will generate:

```
lib/features/example/
├── data/
│   └── example_data.dart
├── domain/
│   ├── example_entity.dart
│   └── example_model.dart
├── logic/
│   ├── example_cubit.dart
│   └── example_state.dart
├── ui/
│   ├── example_page.dart
│   └── example_view.dart
└── widgets/
```

### File Descriptions

- **data/example_data.dart**: Data layer implementation
- **domain/**
  - **example_entity.dart**: Entity definitions
  - **example_model.dart**: Model implementations
- **logic/**
  - **example_cubit.dart**: Cubit implementation for state management
  - **example_state.dart**: State definitions for the Cubit
- **ui/**
  - **example_page.dart**: Page widget with BlocProvider injection
  - **example_view.dart**: Main view implementation with Scaffold
- **widgets/**: Directory for feature-specific widgets

### Naming Conventions

- The script automatically converts any feature name format to snake_case
- Examples of valid feature names:
  - `userProfile` → `user_profile`
  - `UserProfile` → `user_profile`
  - `user-profile` → `user_profile`
  - `User Profile` → `user_profile`

### Generated Code

- All generated files include basic boilerplate code
- The Cubit is properly set up with initial state
- The UI files include proper BlocProvider and BlocBuilder implementations
- All necessary Flutter and bloc package imports are included