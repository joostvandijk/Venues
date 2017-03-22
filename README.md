# Venues
An iOS app to browse nearby venues using the Foursquare API

## Getting Started
1. Open `Venues.xcworkspace`.
2. Enter your Foursquare client identifier & secret in `AppDelegate.swift:29`.
3. Run the app. 👟

## Screenshots
![Screenshot 1](https://cloud.githubusercontent.com/assets/8394738/24197254/347db1f8-0f01-11e7-9dd9-5cdf866fd1c8.png)
![Screenshot 2](https://cloud.githubusercontent.com/assets/8394738/24197253/345c1192-0f01-11e7-9c77-d45d5b771ebf.png)

## The Code
- My main goal was to implement a scaleable and testable architecture.
- The communication with Foursquare has been implemented in a separate framework.
- In this framework, I've tried to replicate Foursquare's API structure as much as possible.
- The app communicates with the Foursquare framework using the `VenueService` protocol, and maps the framework's structures into an application specific `Venue` structure.
- Combined with the usage of dependency injection, it's easy to test the app (swap the `Foursquare.Session` for a mock `VenueService`, as seen in `NearbyVenueSearchControllerTests`).

## Dependencies
I've tried to use as few dependencies as possible. The following dependencies have been used:
- [Unbox](https://github.com/JohnSundell/Unbox) for JSON decoding.
- [This UIColor extension](http://stackoverflow.com/a/33397427) for converting a HEX string to a UIColor instance.
