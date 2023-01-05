##Build instructions for making appimage

#Depends - appimagetool

build project for linux with `flutter build linux --release`

copy build binaries (all files and folders inside) `build/linux/{architecture (Eg:x64)}/release/bundle/` to `build_linux/AppImage/Simple-Weather-App.AppDir/`

cd to `build_linux/AppImage`

run `appimagetool Simple-Weather-App.AppDir`


