# Uncomment this line to define a global platform for your project
platform :ios, '10.0'

def shared_pods
    use_frameworks!
    pod "FontAwesomeKit", :git => 'https://github.com/PrideChung/FontAwesomeKit'
    pod 'SnapKit'
    pod 'Fabric'
    pod 'Crashlytics'
    pod "PromiseKit"
    pod "DateToolsSwift"
    pod 'SKSwiftLib', :path => '~/dev/ios/SKLibs/SKSwiftLib'
    pod 'SKComponents',:path => '~/dev/ios/SKLibs/SKComponents'
end

target 'floatios' do
	shared_pods
end

target 'floatiosTests' do
    shared_pods
end
