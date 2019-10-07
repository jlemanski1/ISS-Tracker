
# ISS Tracker
> Track the International Space Station's current location, find out next pass times for your area, who's onboard, and more!

## Screenshots
| ![loc-map](https://user-images.githubusercontent.com/12676218/65212935-630d2700-da61-11e9-998f-fc2ca00eca33.png)Location Map  |![residents-space](https://user-images.githubusercontent.com/12676218/65212937-630d2700-da61-11e9-8693-5b36bc64d44a.png)Residents of Space | ![next-pass](https://user-images.githubusercontent.com/12676218/65212936-630d2700-da61-11e9-9908-1ac27a6fd870.png)Next Pass Date & Times |
|:---:|:---:|:---:|

And more, so download the app now and check it out!

## Build
#### Building an AppBundle
~~~bash
cd APPDIR
flutter build appbundle --release/debug
~~~

#### Building an APK
```bash
cd APPDIR
flutter build apk --split-per-abi --release/debug
```

## Installation
[Download the early access version from the Google Play store today!](https://play.google.com/store/apps/details?id=tech.jlemanski.iss_tracker)
#### Installing APK on a device
1. Connect Android device to your computer with a USB cable
2. ```bash
   cd AppDir
   flutter install
   ```

### Required Permissions
- location
    - Essential to calculate the next pass times of for the user's location

### Attributions:
- using [Open Notify](http://open-notify.org/Open-Notify-API/)
	- Instrumental in fetching up to date and accurate, location information from NASA 

