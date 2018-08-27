Development Setup

Please open altMed.xcworkspace instead of altMed.xcodeproj.

This project uses cocoapods, don't forget to install them.

Steps

Install Xcode

Optional: Install Xcode Command Line Tools via $ xcode-select --install

Check with xcodebuild -version Currently at 9.4

Install cocoapods via $ sudo gem install cocoapods

verify with pod --version currently at 1.5.2

Update cocoapods repo via pod repo update,
cd to the project folder and run $ pod install

Open & build Test->main_test_case->Select device(iPhone7(11.4)).
