# My Code Structure

A Flutter project showcasing a clean, scalable, and maintainable architecture following best practices.

## Project Architecture

This project follows Clean Architecture principles with a feature-first approach, making it easy to maintain and scale. Each feature is organized into its own module with a clear separation of concerns.

### Directory Structure

```
lib/
├── core/                  # Core functionality and shared components
│   ├── design_system/    # App-wide design system (themes, colors, text styles)
│   ├── extensions/       # Extension methods
│   ├── network/         # Network related code (APIs, DI)
│   ├── services/        # Common services
│   └── widgets/         # Reusable widgets
│
└── features/            # Feature modules
    └── feature_name/    # Each feature follows this structure:
        ├── data/        # Data layer (repositories, data sources)
        ├── domain/      # Domain layer (entities, models)
        ├── logic/       # Business logic (cubits, states)
        ├── ui/          # UI layer (pages, views)
        └── widgets/     # Feature-specific widgets
```

### Layer Organization

1. **Data Layer** (`data/`)
   - Handles data operations and external interactions
   - Contains repositories and data sources
   - Manages API calls and local storage
   - Example: `feature_name_data.dart`

2. **Domain Layer** (`domain/`)
   - Contains business logic models and entities
   - Defines the core business rules
   - Files:
     - `feature_name_entity.dart`: Core business objects
     - `feature_name_model.dart`: Data transfer objects

3. **Logic Layer** (`logic/`)
   - Manages state and business logic using BLoC pattern (Cubit)
   - Files:
     - `feature_name_cubit.dart`: State management and business logic
     - `feature_name_state.dart`: State definitions

4. **UI Layer** (`ui/`)
   - Presents the user interface
   - Files:
     - `feature_name_page.dart`: Page widget with dependencies
     - `feature_name_view.dart`: Actual UI implementation

### Feature Generation

The project includes a script to generate new features with the correct structure:

```bash
./scripts/generate_feature.sh feature_name
```

This creates a new feature with all necessary files and boilerplate code following our architecture.

## Core Modules

- **Design System**: Centralized theme management
- **Network**: API handling and dependency injection
- **Services**: Shared functionality across features
- **Extensions**: Utility extension methods
- **Widgets**: Reusable UI components

## State Management

We use the BLoC pattern (specifically Cubit) for state management:
- Clear separation of UI and business logic
- Predictable state updates
- Easy testing and maintenance

## Getting Started

1. Clone the repository
2. Run `flutter pub get`
3. Use the feature generation script for new features
4. Follow the established patterns for consistency
