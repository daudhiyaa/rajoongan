# Rajooongan

Designed to assist you in planning your sail and organizing your catches

## About

### See the app demo on my LinkedIn Post : [Rajoongan Post](https://www.linkedin.com/posts/daudhiyaa_flutter-androids-mobileapps-activity-7094226885903093760-va6u?utm_source=share&utm_medium=member_desktop)

An application integrated `database` & `bluetooth` to assist you in your sailing. This application features two modes: Internet Mode and Bluetooth Mode. In Bluetooth Mode, the app can communicate with a GPS Module using Bluetooth Low Energy (BLE) through ESP32, enabling users to utilize the app even in remote sea areas with limited internet connectivity.

In Bluetooth Mode, the app receives coordinate data from the GPS Module and records it, storing the data in the internal storage of each user's device. This mode also provides sail planning with a map of potential catch locations and the ability to calculate estimated distance, fuel consumption, and sailing time.

On the other hand, in Internet Mode, users can register and login, save personal data, capture data on their catches, and access their sailing history. This mode also includes the "Tau Lebih" feature, which provides a summary of the proper procedures for quarantining laying rajungan eggs.

## Note

- You need to configure & specify your own `firebase project` to run this app

- You need a certain key to able run this app :

  - Google Maps API key
  - Open Weather Maps API key
  - BLE ID (or your own GPS Module + ESP)

- This app is currently available only on Android and has not yet been developed for iOS. So you need `Android Emulator` or `Android Device` to run this app.

> (In the future, I will strive to improve and expand the app, addressing any shortcomings that may exist)
