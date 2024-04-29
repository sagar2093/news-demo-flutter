# news-demo-flutter
A flutter demo app for api provided by newsapi.org

## Steps to build app
1. Get your own api key from https://newsapi.org/
2. Create file `constants.dart` inside lib folder and create a variable named `newsApiKey` and assign the api key to it like below:
   `const newsApiKey = "your_api_key";`
3. Generate codes using command `dart run build_runner build --delete-conflicting-outputs`
4. Run `flutter run -t lib/main.dart` from the terminal or use IDE run configurations.

## Libraries Used
