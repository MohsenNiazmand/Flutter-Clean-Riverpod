# Flutter Notes

A comprehensive Flutter sample project demonstrating Clean Architecture principles, state management with Riverpod, and responsive UI design. This project serves as a reference implementation for building scalable Flutter applications with a **Notes App** backend integration.

## 🏗️ Architecture Overview

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/           # Core utilities, constants, and shared functionality
├── features/       # Feature-based modules (auth, notes, profile, main, splash)
├── shared/         # Shared components and domain logic
├── config/         # App configuration (themes, routes, localization)
├── domain/         # Domain entities and data states
└── data/           # Data layer implementations
```

### State Management with Riverpod

- **Riverpod 2.x** for reactive state management
- **Provider pattern** for dependency injection
- **Code generation** with `riverpod_generator` for type-safe providers
- **Hooks integration** for functional state management
- **Optimistic Updates** for better user experience

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

### 🔐 Authentication System
- **JWT-based Authentication** - Secure token-based auth
- **User Registration** - Email activation code flow
- **Password Reset** - 6-digit reset token system
- **Secure Storage** - Encrypted token storage
- **Auto-login** - Persistent authentication state

### 📝 Notes Management
- **CRUD Operations** - Create, Read, Update, Delete notes
- **Optimistic Updates** - Instant UI feedback
- **Local Storage** - Offline-first with Hive database
- **Grid Layout** - Masonry grid with responsive columns
- **Real-time Sync** - Background synchronization with backend
- **Search & Filter** - Advanced note filtering capabilities

### 🎨 UI/UX Features
- **Responsive Design** - Mobile, Tablet, Desktop support
- **Custom Design System** - Consistent UI components
- **Loading States** - Smooth loading animations
- **Empty States** - User-friendly empty state handling
- **Toast Notifications** - Contextual user feedback
- **Error Handling** - Centralized exception management

### 🏗️ Architecture Features
- **Clean Architecture** - Separation of concerns with clear boundaries
- **State Management** - Reactive state with Riverpod
- **Dependency Injection** - GetIt service locator pattern
- **Repository Pattern** - Data access abstraction
- **Use Case Pattern** - Business logic encapsulation
- **Code Generation** - Automated provider and API client generation

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
   git clone https://github.com/MohsenNiazmand/Flutter-Notes.git
   cd flutter_notes
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
- **Optimistic Updates** - Immediate UI feedback with rollback capability
- **Offline-First** - Local storage with background sync

### State Management Flow
```
User Action → Provider → Use Case → Repository → API/Local Storage
     ↓
UI Update ← State Manager ← Data Success/Error ← Response
```

### Data Flow Architecture
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Presentation  │    │     Domain      │    │      Data       │
│                 │    │                 │    │                 │
│ • UI Components │◄──►│ • Use Cases     │◄──►│ • Repositories  │
│ • Providers    │    │ • Entities      │    │ • API Services  │
│ • State Mgmt    │    │ • Business Logic│    │ • Local Storage │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 📝 Code Organization

### Feature Structure
Each feature follows a consistent structure:
```
features/
├── auth/                    # Authentication feature
│   ├── data/
│   │   ├── models/          # Auth data models
│   │   ├── repositories/    # Auth repository implementations
│   │   └── services/        # Auth API services
│   ├── domain/
│   │   ├── entities/        # Auth domain entities
│   │   ├── repositories/    # Auth repository interfaces
│   │   └── usecases/        # Auth business logic
│   └── presentation/
│       ├── providers/       # Auth Riverpod providers
│       └── screens/         # Auth UI screens
├── notes/                   # Notes management feature
│   ├── data/
│   │   ├── models/          # Notes data models
│   │   ├── repositories/    # Notes repository implementations
│   │   └── services/        # Notes API services
│   ├── domain/
│   │   ├── entities/        # Notes domain entities
│   │   ├── repositories/    # Notes repository interfaces
│   │   └── usecases/        # Notes business logic
│   └── presentation/
│       ├── providers/       # Notes Riverpod providers
│       ├── screens/         # Notes UI screens
│       └── widgets/         # Notes-specific widgets
├── main/                    # Main app shell
├── profile/                 # User profile feature
└── splash/                  # App splash screen
```

### Core Components
```
core/
├── constants/               # App constants and keys
├── error/                   # Error handling utilities
├── extensions/              # Dart extensions
├── injection_container.dart # Dependency injection setup
└── utils/                   # Utility functions

shared/
├── data/
│   ├── local/              # Local storage implementations
│   └── model/              # Shared data models
├── domain/
│   └── enums/              # Shared enumerations
└── presentation/
    ├── global_keys.dart    # Global form keys
    ├── screens/            # Shared screens
    └── widgets/            # Reusable UI components
```

## 🔧 Configuration

### Environment Setup
- **API Configuration** - Centralized in `core/constants/constants.dart`
- **Theme System** - Material Design 3 with custom theming
- **Localization** - ARB files for internationalization
- **Routing** - Declarative routes with GoRouter
- **Dependency Injection** - GetIt service locator setup

### Build Configuration
- **Code Generation** - Automated provider and API client generation
- **Linting** - Very Good Analysis for code quality
- **Platform Icons** - Automated icon generation

### Key Configuration Files
- **`main.dart`** - App initialization and dependency setup
- **`injection_container.dart`** - Dependency injection configuration
- **`app_router.dart`** - Navigation and routing setup
- **`app_theme.dart`** - Theme and styling configuration
- **`constants.dart`** - App-wide constants and configuration

## 🔄 State Management Details

### Riverpod Providers
```dart
// Authentication providers
@riverpod
class LoginNotifier extends _$LoginNotifier {
  Future<void> login(String email, String password) async {
    // Login logic with optimistic updates
  }
}

// Notes state management
final notesStateProvider = StateNotifierProvider<NotesStateNotifier, List<NoteModel>>((ref) {
  return NotesStateNotifier();
});
```

### Optimistic Updates Pattern
```dart
// 1. Immediate UI update
stateManager.addNote(optimisticNote);

// 2. API call
final response = await apiService.createNote(data);

// 3. Handle response
await response.fold(
  (l) => stateManager.removeNote(optimisticNote.id!), // Rollback
  (r) => stateManager.updateNote(r.data), // Success
);
```

### Data Synchronization
- **Local First** - Hive database for offline storage
- **Background Sync** - Automatic synchronization with backend
- **Conflict Resolution** - Server data takes precedence
- **Optimistic Updates** - Immediate UI feedback with rollback

## 📚 Learning Resources

This project demonstrates:
- **Clean Architecture** implementation in Flutter
- **Riverpod state management** patterns and best practices
- **Responsive UI design** principles for all devices
- **Cross-platform development** best practices
- **Code organization** and maintainability
- **Offline-first** application development
- **Optimistic updates** for better user experience
- **JWT authentication** flow implementation
- **Repository pattern** for data access
- **Use case pattern** for business logic
- **Dependency injection** with GetIt
- **Code generation** with build_runner
- **Error handling** and user feedback
- **Local storage** with Hive database
- **API integration** with Retrofit and Dio

## 🎯 Key Learning Points

### 1. Clean Architecture Benefits
- **Testability** - Easy to unit test business logic
- **Maintainability** - Clear separation of concerns
- **Scalability** - Easy to add new features
- **Independence** - UI and data layers are decoupled

### 2. State Management Patterns
- **Provider-based** state management with Riverpod
- **Optimistic updates** for immediate user feedback
- **Error handling** with rollback capabilities
- **Loading states** for better UX

### 3. UI/UX Best Practices
- **Responsive design** for all screen sizes
- **Custom design system** for consistency
- **Loading and empty states** for better UX
- **Toast notifications** for user feedback

### 4. Data Management
- **Offline-first** approach with local storage
- **Background synchronization** with backend
- **Conflict resolution** strategies
- **Optimistic updates** with rollback

## 🚀 Getting Started

### Prerequisites
- Flutter 3.4+ 
- Dart 3.0+
- Android Studio / VS Code
- Git

### Quick Start
```bash
# Clone the repository
git clone <repository-url>
   cd flutter_notes

# Install dependencies
flutter pub get

# Generate code (providers, API clients, etc.)
dart run build_runner build --delete-conflicting-outputs

# Run the application
flutter run
```

### Backend Integration
This Flutter app is designed to work with a Django REST Framework backend. Make sure to:
1. Set the correct API base URL in `core/constants/constants.dart`
2. Ensure the backend is running and accessible
3. Configure CORS settings on the backend for web support

## 🤝 Contributing

This is a sample project for educational purposes. Feel free to:
- **Study the architecture patterns** - Learn from the clean architecture implementation
- **Use as a reference** - Reference this project for your own Flutter applications
- **Adapt the patterns** - Modify and adapt patterns to your specific needs
- **Fork and experiment** - Create your own variations and improvements

## 📄 License

This project is provided as a sample implementation for educational purposes. Feel free to use it as a learning resource and reference for your own projects.

---

## 📞 Contact

- **Developer**: Mohsen Niazmand
- **Email**: [mohseniazmand@gmail.com](mailto:mohseniazmand@gmail.com)
- **LinkedIn**: [www.linkedin.com/in/mohsen-niazmand-6b5b12201](https://www.linkedin.com/in/mohsen-niazmand-6b5b12201)
- **GitHub**: [@MohsenNiazmand](https://github.com/MohsenNiazmand)

## 🙏 Acknowledgments

- Flutter team for the amazing cross-platform framework
- Riverpod team for the excellent state management solution
- Django REST Framework team for the robust backend API
- Open source contributors for inspiration and tools

---

**⭐ If you found this project helpful, please give it a star!**

**🔗 This project demonstrates advanced Flutter development skills with Clean Architecture and modern state management patterns suitable for production applications.**

---

**Happy Coding! 🎉**

*This project demonstrates modern Flutter development practices with Clean Architecture, Riverpod state management, and responsive UI design.*
