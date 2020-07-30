# TuyaSmartCamera

[中文版](./README-zh.md) | [English](./README.md)

---

## Features Overview

Tuya Smart Camera SDK provides the interface package for the communication with remote camera device to accelerate the application development process, including the following features:

* Preview the picture taken by the camera
* Play back recorded video of the remote camera
* Record video
* Talk to the remote camera

## Rapid Integration

#### Using CocoaPods integration（version 8.0 or above is supported）

Add the following line to your Podfile:

```ruby
platform :ios, '9.0'

target 'your_target_name' do

pod 'TuyaSmartCameraKit'
#pod 'TuyaSmartCameraT'
pod 'TuyaSmartHomeKit'

end
```

TuyaSmartCameraKit just support p2p 2.0,  if you want integrate p2p 1.0 camera, you could add this code: ```pod 'TuyaSmartCameraT'```.

```TuyaSmartCameraDefault``` is removed from sdk, you can get it from demo in this repo.

Execute command ```pod update```in the project's root directory to begin integration.

For the instructions of CocoaPods, please refer to : [CocoaPods Guides](https://guides.cocoapods.org/)

## Doc

Refer to Details: [Tuya Smart Camera iOS SDK Doc](https://tuyainc.github.io/tuyasmart_camera_ios_sdk_doc/en/)

