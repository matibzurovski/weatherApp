# Weather App

## Steps to run
1) Clone the project
2) Run `pod install` on the root folder
3) Open the workspace
4) Run

## Improvements
I wasn't able to implementing the following details due to lack of time:
- Introduction of the `Coordinator` pattern. Basically, a business logic class that would be responsible of presenting a view controller (`MapViewController`) and dealing with the other controllers (`LocationController` & `WeatherController`).
- Unit tests
- Not so boring UI 😀

## Known issues
As I've commented on the code, I didn't implement the app to show the weather info after a double tap, but instead added a long pressure gesture recognizer. This is because the map default behavior is to zoom itself after a double tap. More info on the code at `MapViewController.swift`.
