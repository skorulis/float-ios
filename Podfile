# Uncomment this line to define a global platform for your project


def ios_pods
    pod 'SKCollectionView',:path => '~/dev/ios/SKLibs/SKCollectionView'
    pod "CCTextFieldEffects"
    pod "FontAwesomeKit", :git => 'https://github.com/PrideChung/FontAwesomeKit'
    pod 'SKComponents',:path => '~/dev/ios/SKLibs/SKComponents'
end

def shared_pods
    use_frameworks!
    pod 'SnapKit'
    pod 'SKSwiftLib', :path => '~/dev/ios/SKLibs/SKSwiftLib'
    pod 'FLScene', :path => '~/dev/floats/FLScene'
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
