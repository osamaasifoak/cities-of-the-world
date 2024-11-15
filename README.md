# Flutter Cities App

This Flutter application displays a list of cities with additional functionality for viewing the cities on a map. It uses the Repository Pattern combined with elements of the MVVM (Model-View-ViewModel) architecture and Provider for state management. The app also demonstrates local caching, efficient API management, and a clean, modularized project structure.

## Project Structure

The project is organized into the following directories and files:

### `lib/`
This directory contains the main app logic and UI components.

#### `lib/core/`
Contains core functionality for models, network, and utility classes.

- **`models/`**  
  Defines data models using Hive and JSON serialization.  
  - `cities_model.dart`: Defines the city data model.
  - `city_model.dart`: Defines the individual city data structure.
  - `country_model.dart`: Defines the country data model.
  - `pagination_model.dart`: Defines pagination details for API responses.

- **`network/`**  
  API client setup using Dio for making network requests.  
  - `api_client.dart`: Configures the Dio instance for network calls.

- **`utils/`**  
  Contains utility classes for managing data states like loading, completed, and error states for both Hive and API responses.  
  - `data_state.dart`: Manages different states (loading, success, error) for API and Hive responses.

#### `lib/providers/`
Contains providers for managing app state and data flow.

- **`cities_providers.dart`**  
  Defines state management for cities data using Providers.

#### `lib/repositories/`
Handles the logic of fetching data from local cache and API, ensuring that data is fetched from the API only if not already available in the cache.

- **`cities_repository.dart`**  
  Responsible for providing the data. Checks if the data is available locally (via Hive) and if not, makes an API call to fetch it.

#### `lib/resources/`
Exports commonly used resources like strings, colors, and styles.

- **`resources.dart`**  
  A single file for exporting all resources to make it easy to manage app-wide values.
- **`strings.dart`**  
  Stores all the static text used in the app.

#### `lib/screens/`
Contains the app’s screens and UI components.

- **`cities_listview_screen.dart`**  
  Displays a list view of cities with relevant data.
- **`cities_mapview_screen.dart`**  
  Displays a map view of cities, integrating Google Maps API.
- **`cities_screen.dart`**  
  The main screen containing tabs to navigate between the list and map view of cities.

#### `lib/services/`
Contains services for making API calls and handling business logic.

- **`cities_api_services.dart`**  
  Contains functions to interact with the backend API for fetching city data.

### `test/`
Contains unit tests to ensure the correctness of the app.

- **`cities_provider_test.dart`**  
  Contains tests for the `cities_providers.dart` to ensure the correct state management logic is implemented.

### `main.dart`
The entry point for the app.

## Setup Instructions

To run this app, use the following commands:

1. **Generate necessary files** (for code generation using build_runner):
```flutter pub run build_runner build ```

2. **Run the app** (replace the API keys with actual values):
```flutter run --dart-define=GOOGLE_MAP_KEY=<Your_Google_Map_Key> --dart-define=BASE_URL=<Base_Url>```

## Features
- List and Map views of cities.
- Offline support using Hive.
- Google Maps integration.
- Cached API data to improve app performance.