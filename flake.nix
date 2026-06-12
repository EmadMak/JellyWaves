{
description = "Flutter 3.13.x";
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
  flake-utils.url = "github:numtide/flake-utils";
};
outputs = { nixpkgs, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        buildToolsVersions = [ "34.0.0" "35.0.0" ];
        platformVersions = [ "34" "36" ];
        abiVersions = [ "x86_64" ];
        systemImageTypes = [ "google_apis" ];

        includeEmulator = true;
        includeSystemImages = true;

        includeNDK = true;
        ndkVersions = [ "28.2.13676358" ];

        includeCmake = true;
        cmakeVersions = [ "3.22.1" ];
      };
      androidSdk = androidComposition.androidsdk;
    in
    {
      devShell =
        with pkgs; mkShell {
          ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
          ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
          ANDROID_AVD_HOME = "$HOME/.android/avd";
          ANDROID_SDK_HOME = "$HOME/.android";
          ANDROID_AAPT2_BINARY="${androidSdk}/libexec/android-sdk/build-tools/35.0.0/aapt2";
          JAVA_HOME = pkgs.jdk17;

          buildInputs = [
            flutter
            androidSdk
            jdk17
            android-tools
          ];

          shellHook = ''
            export ANDROID_SDK_ROOT=${androidComposition.androidsdk}/libexec/android-sdk
            export GRADLE_OPTS="-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidComposition.androidsdk}/libexec/android-sdk/build-tools/35.0.0/aapt2"

            if [ ! -d "$HOME/.android/avd/test.avd" ]; then
              echo "Creating emulator..."

              echo "no" | avdmanager create avd \
                -n test \
                -k "system-images;android-36;google_apis;x86_64"
            fi

            alias adb-up="QT_QPA_PLATFORM=xcb emulator -avd test -no-snapshot -gpu swiftshader_indirect"
            alias adb-home="adb shell input keyevent 3"
            alias adb-back="adb shell input keyevent 4"
            alias adb-power="adb shell input keyevent 26"
            alias adb-ra="adb shell input keyevent 187"
          '';
        };
    });
}
