# Flutter Clean Architecture Project

Một dự án mẫu về Clean Architecture trong Flutter, sử dụng REST API và các design patterns phổ biến.

## Cấu trúc Project
lib/
├── core/
│   ├── error/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   └── network/
│       ├── network_info.dart
│       └── dio_client.dart
├── data/
│   ├── data_sources/
│   │   └── post_remote_data_source.dart
│   └── models/
│       └── post_model.dart
├── repositories/
│   ├── post_repository.dart
│   └── post_repository_impl.dart
├── presentation/
│   ├── bloc/
│   │   └── post/
│   └── pages/
└── main.dart

## Các tính năng

- ✅ Clean Architecture
- ✅ BLoC Pattern  
- ✅ Repository Pattern
- ✅ Dependency Injection
- ✅ Error Handling
- ✅ Unit Testing
- ✅ REST API Integration

## Technical Stack

- **State Management**: flutter_bloc 
- **API Client**: retrofit + dio
- **Dependency Injection**: get_it
- **Code Generation**: freezed
- **Error Handling**: dartz (Either)
- **Testing**: mocktail, bloc_test

## Cài đặt

1. Clone project
```bash
git clone https://github.com/your-username/project-name.git

Cài đặt dependencies
flutter pub get

Chạy code generation
flutter pub run build_runner build --delete-conflicting-outputs

Testing
Project bao gồm các loại tests:

Data Sources Tests:


API call success/failure cases
Response parsing


Repository Tests:


Network connectivity
Data source integration
Error handling


BLoC Tests:


State management
Event handling
Error scenarios


Widget Tests:


UI rendering
Loading states
Error states

Chạy tests: flutter test

Chạy tests với coverage: flutter test --coverage

Các Pattern đã áp dụng

Repository Pattern


Tách biệt data layer và domain layer
Dễ dàng thay đổi data source
Xử lý errors một cách thống nhất


BLoC Pattern


Quản lý state
Tách biệt UI và business logic
Dễ dàng testing


Dependency Injection


Giảm coupling
Dễ dàng testing
Quản lý dependencies hiệu quả

Error Handling

Exception Types


ServerException
CacheException


Failure Types


ServerFailure
NetworkFailure

Either Type

Acknowledgments

Clean Architecture by Uncle Bob
Flutter Bloc Library
Retrofit for Dart