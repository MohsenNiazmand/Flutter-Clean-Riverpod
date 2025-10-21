# Flutter Clean Architecture with Riverpod

A comprehensive Flutter sample project demonstrating Clean Architecture principles, state management with Riverpod, and responsive UI design. This project serves as a reference implementation for building scalable Flutter applications.

## 🏗️ Architecture Overview

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/           # Core utilities, constants, and shared functionality
├── features/       # Feature-based modules (auth, home, profile, etc.)
├── shared/         # Shared components and domain logic
├── config/         # App configuration (themes, routes, localization)
└── data/           # Data layer implementations
```

### State Management with Riverpod

- **Riverpod 2.x** for reactive state management
- **Provider pattern** for dependency injection
- **Code generation** with `riverpod_generator` for type-safe providers
- **Hooks integration** for functional state management

### Key Technologies & Packages

- **Flutter 3.4+** - Cross-platform UI framework
- **Riverpod** - State management and dependency injection
- **GoRouter** - Declarative routing
- **Dio** - HTTP client with interceptors
- **Retrofit** - Type-safe API client generation
- **Hive** - Local database
- **Flutter Secure Storage** - Secure data persistence
- **GetIt** - Service locator for dependency injection

## 🎨 Responsive UI Design

The project implements a comprehensive responsive design system:

### Device Type Detection
```dart
// Automatic device type detection based on screen width
if (context.deviceType == DeviceTypeEnum.mobile) {
  // Mobile-specific UI
} else if (context.deviceType == DeviceTypeEnum.tablet) {
  // Tablet-specific UI
} else {
  // Desktop-specific UI
}
```

### Responsive Utilities
- **DeviceTypeExtension** - Automatic device type detection
- **ResponsivePadding** - Adaptive padding based on device type
- **ResponsiveOffset** - Platform-aware vertical offsets
- **Breakpoints**: Mobile (<600px), Tablet (600-1250px), Desktop (≥1250px)

### Cross-Platform Support
- ✅ **Web** - Full responsive web application
- ✅ **Android** - Native mobile experience
- ✅ **iOS** - Native mobile experience
- ✅ **Desktop** - Adaptive desktop interface

## 🚀 Features

- **Authentication Flow** - Login, registration, password reset
- **Clean Architecture** - Separation of concerns with clear boundaries
- **State Management** - Reactive state with Riverpod
- **Responsive Design** - Adaptive UI for all screen sizes
- **Localization** - Multi-language support ready
- **Error Handling** - Centralized exception management
- **Logging** - Comprehensive debugging utilities
- **File Management** - Image compression and file picking
- **Navigation** - Type-safe routing with GoRouter

## 📱 Platform-Specific Adaptations

### Web
- Path-based URLs (no hash routing)
- Responsive breakpoints optimized for desktop
- Web-specific UI adjustments

### Mobile (Android/iOS)
- Native platform look and feel
- Platform-specific navigation patterns
- Optimized touch interactions

## 🛠️ Development Setup

1. **Prerequisites**
   ```bash
   flutter --version  # Ensure Flutter 3.4+
   dart --version     # Ensure Dart 3.0+
   ```

2. **Installation**
   ```bash
   git clone <repository-url>
   cd flutter_clean_riverpod
   flutter pub get
   ```

3. **Code Generation**
   ```bash
   # Generate Riverpod providers and Retrofit clients
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the Application**
   ```bash
   # Web
   flutter run -d chrome
   
   # Android
   flutter run -d android
   
   # iOS
   flutter run -d ios
   ```

## 📦 Key Dependencies

### State Management
- `hooks_riverpod` - Reactive state management
- `riverpod_annotation` - Code generation annotations
- `riverpod_generator` - Provider code generation

### Networking
- `dio` - HTTP client
- `retrofit` - API client generation
- `curl_logger_dio_interceptor` - Request logging

### UI & Navigation
- `go_router` - Declarative routing
- `flutter_hooks` - Functional state management
- `bot_toast` - Toast notifications

### Data Persistence
- `hive` - Local database
- `hive_flutter` - Flutter integration
- `flutter_secure_storage` - Secure storage

### Utilities
- `get_it` - Dependency injection
- `logger` - Logging utility
- `image_picker` - File selection
- `flutter_image_compress` - Image optimization

## 🏛️ Architecture Patterns

### Clean Architecture Layers
1. **Presentation Layer** - UI components and state management
2. **Domain Layer** - Business logic and entities
3. **Data Layer** - Repository implementations and data sources

### Design Patterns
- **Repository Pattern** - Data access abstraction
- **Use Case Pattern** - Business logic encapsulation
- **Provider Pattern** - Dependency injection
- **Observer Pattern** - State management with Riverpod

## 📝 Code Organization

### Feature Structure
Each feature follows a consistent structure:
```
features/auth/
├── data/
│   ├── models/          # Data models
│   ├── repositories/    # Repository implementations
│   └── services/        # API services
├── domain/
│   ├── entities/        # Domain entities
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Business logic
└── presentation/
    ├── providers/       # Riverpod providers
    └── screens/         # UI screens
```

## 🔧 Configuration

### Environment Setup
- **API Configuration** - Centralized in `core/constants/constants.dart`
- **Theme System** - Material Design 3 with custom theming
- **Localization** - ARB files for internationalization
- **Routing** - Declarative routes with GoRouter

### Build Configuration
- **Code Generation** - Automated provider and API client generation
- **Linting** - Very Good Analysis for code quality
- **Platform Icons** - Automated icon generation

## 📚 Learning Resources

This project demonstrates:
- Clean Architecture implementation in Flutter
- Riverpod state management patterns
- Responsive UI design principles
- Cross-platform development best practices
- Code organization and maintainability

## 🤝 Contributing

This is a sample project for educational purposes. Feel free to:
- Study the architecture patterns
- Use as a reference for your own projects
- Adapt the patterns to your specific needs

## 📄 License

This project is provided as a sample implementation for educational purposes.
