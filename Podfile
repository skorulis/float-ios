# Uncomment this line to define a global platform for your project


def ios_pods
    pod 'Down'
    pod 'SpriteKit-Spring', :git => 'https://github.com/ataugeron/SpriteKit-Spring/'
    pod 'SKCollectionView',:path => '~/dev/ios/SKLibs/SKCollectionView'
    pod "CCTextFieldEffects"
    pod "FontAwesomeKit", :git => 'https://github.com/PrideChung/FontAwesomeKit'
    pod 'SKComponents',:path => '~/dev/ios/SKLibs/SKComponents'
end

def shared_pods
    use_frameworks!
    pod 'SnapKit'
    pod 'SKSwiftLib', :path => '~/dev/ios/SKLibs/SKSwiftLib'
end

target 'FLGame' do
    platform :ios, '10.0'
    shared_pods
    pod 'SKComponents',:path => '~/dev/ios/SKLibs/SKComponents'
end

target 'FLScene' do
    platform :ios, '10.0'
    shared_pods
    ios_pods
end

target 'floatios' do
    platform :ios, '10.0'
	shared_pods
    ios_pods
end

target 'floatiosTests' do
    platform :ios, '10.0'
    shared_pods
    ios_pods
end

target 'FloatMac' do
    platform :osx, '10.12'
    shared_pods
end
