
# ISS Tracker
> Track the International Space Station's current location, find out next pass times for your area, who's onboard, and more!

![Feature-Graphic](https://user-images.githubusercontent.com/12676218/86264253-7f58fb00-bb7f-11ea-8668-6d3a47cf71ec.png)

## Screenshots
| ![loc-map](https://user-images.githubusercontent.com/12676218/86264235-7a944700-bb7f-11ea-923a-cacc8bbc7f80.jpg)Location Map  |![TransitTimes](https://user-images.githubusercontent.com/12676218/86264241-7bc57400-bb7f-11ea-9030-0f1b6111a3cf.jpg)Transit Times | ![next-pass](https://user-images.githubusercontent.com/12676218/86264245-7c5e0a80-bb7f-11ea-82c3-2c7037809ee3.jpg)Crew members |  ![Themes](https://user-images.githubusercontent.com/12676218/86264246-7cf6a100-bb7f-11ea-959c-396e4756cfee.png)Light & Dark Modes  |
|:---:|:---:|:---:|:---:|


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
[Download the early access version from the Google Play store today!](https://play.google.com/store/apps/details?id=tech.jlemanski.iss_tracker_v2)
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
- Readme styled with one of my other projects [MKD-editor](https://mkd-editor.herokuapp.com/)
