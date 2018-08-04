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
    pod "TextFieldEffects"
    pod "CCTextFieldEffects"
    pod 'SpriteKit-Spring', :git => 'https://github.com/ataugeron/SpriteKit-Spring/'
    pod 'SKSwiftLib', :path => '~/dev/ios/SKLibs/SKSwiftLib'
    pod 'SKComponents',:path => '~/dev/ios/SKLibs/SKComponents'
    pod 'SKCollectionView',:path => '~/dev/ios/SKLibs/SKCollectionView'
    pod 'SCNMathExtensions'
end

target 'FLGame' do
    shared_pods
end

target 'FLScene' do
    shared_pods
end

target 'floatios' do
	shared_pods
end

target 'floatiosTests' do
    shared_pods
end
