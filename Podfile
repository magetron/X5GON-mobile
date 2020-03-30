platform :ios, '13.3'
use_frameworks!
inhibit_all_warnings!

def shared_pods
	pod 'SwiftSoup'
	pod 'JGProgressHUD'
end

target 'x5gon-mobile' do
	use_frameworks!
	shared_pods
	
	target 'x5gon-mobileTests' do
		inherit! :search_paths
	end
end

target 'x5gon-mobileUITests' do
	shared_pods
end


