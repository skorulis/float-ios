# Uncomment this line to define a global platform for your project


def ios_pods
    pod 'SKCollectionView',:path => '~/dev/ios/libs/ASCollectionView'
    pod "CCTextFieldEffects"
    pod "FontAwesomeKit", :git => 'https://github.com/PrideChung/FontAwesomeKit'
    pod 'SKComponents',:path => '~/dev/ios/libs/SKComponents'
end

def shared_pods
    use_frameworks!
    pod 'SnapKit'
    pod 'SKSwiftLib', :path => '~/dev/ios/libs/SKSwiftLib'
    pod 'FLScene', :path => '~/dev/ios/FLScene'
end

target 'floatios' do
    platform :ios, '11.0'
	shared_pods
    ios_pods
end

target 'floatiosTests' do
    platform :ios, '11.0'
    shared_pods
    ios_pods
end

target 'FloatMac' do
    platform :osx, '10.13'
    shared_pods
end
