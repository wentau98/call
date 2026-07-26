# iOS 工程的 Podfile
# 用法：cd ios && pod install

platform :ios, '14.0'
use_frameworks!

target 'VideoCall' do
  # WebRTC 官方预编译 framework（Google 官方已不再直接发布到 CocoaPods，
  # 社区 stasel/WebRTC 仓库托管稳定的二进制，可作为备选。
  # 这里使用 GoogleWebRTC 旧版（仍可用）或 stasel 镜像。
  # 推荐：使用 stasel 维护的版本以获得最新 API
  pod 'WebRTC'
end
