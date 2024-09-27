# Flutter best practices
## 1. Folder and code structure
### 1.1 Folder structure
The application separates folders by type/domain:
- **screens** - All pages should be put here. This is the "heart" of the UI. Keep seperate from business logic.
- **services** - Should handle all business logic such as API calls, data storage and complex calculations
- **view_models** - Data models and blueprints, defined as dart classes
- **widgets** - Small, reusable UI components

When creating a new screen, its route can be defined in the app.dart class in root.

### 1.2 Code structure
### 1.2.1 Naming conventions
Try to use names that are clear and consise. Long enough to be clear but not so long that they become complicated:
- Use **UpperCamelCase** for naming classes, typedefs, enums and extension names (e.g., MyClass, MyEnum)
- Use **lowerCamelCase** for naming variables, parameters, fields and methods (e.g., myVariable, myMethod)
- Use **snake_case** for naming source files and folders (e.g., /view_models, auth_service.dart) 

## 2. Use of widgets
Widgets are an integral part of flutter development. 
- Create custom widgets that handle forms and  navigation
- Create widgets for frequently used UI components.
- Split complex widets into smaller ones to avoid complicated screens.
- Try to use Stateless widgets over Stateful widgets. Move stateful logic to services or view_models.

## 3. Effective Dart
### 3.1 Documentation
**DON'T** use block comments for documentation
```dart
void good(String name) {
    // Assume we have a valid name.
    print('Hi, $name!');
}

void bad(String name) {
    /* Assume we have a valid name. */
    print('Hi, $name!')
}
```
**DO** use /// doc comments to document
```dart
/// The number of characters in this chunk when unsplit.
int get length => ...
```
Using a doc comment instead of a regular comment enables dart doc to find it and generate documentation for it. Dart doc supports both javadoc (/*...**/) and ///, but /// is preffered.
<br>

**DO** separate the first sentence of a doc comment into its own paragraph
```dart
/// Initiates the login process for the current platform.
///
/// - On web: 
/// - On mobile: 
Future<void> login() async {
    print('Logging in...');
}
```
**DO** use square brackets in doc comments to refer to in-scope identifiers
```dart
/// Throws a [StateError] if ...
/// similar to [anotherMethod()], but ...
```






