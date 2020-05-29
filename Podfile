# Uncomment the next line to define a global platform for your project
 platform :ios, '9.0'


#是否在IOS开发环境下编译
IOSONLY_MODE=0
#是否发布flutter产物到git服务器
PUBLISH_FLUTTER_PRODUCTION=0
#在纯IOS开发环境下，使用Debug还是Release模式的Flutter产物
USE_FLUTTER_PRODUCTION_TYPE="Debug"

#混合模式走原来的逻辑
if(IOSONLY_MODE==0)
  flutter_application_path = '../my_flutter'
  load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
end

dir = File.dirname(__FILE__)
load File.join(dir,'podhelper.rb')

target 'FlutterCI' do

  if(IOSONLY_MODE ==0)
#混合模式走原来的逻辑
  	install_all_flutter_pods(flutter_application_path)
  else
#IOS独立模式走新加的逻辑
        flutter_production_path = "#{dir}/flutter_production/#{USE_FLUTTER_PRODUCTION_TYPE}"
  	install_all_native_flutter_pods(flutter_production_path)
  end
  if(IOSONLY_MODE==0&&PUBLISH_FLUTTER_PRODUCTION ==1)
  	upload_production(flutter_application_path)
  end


  # Uncomment the next line if you're using Swift or would like to use dynamic frameworks
  # use_frameworks!

  # Pods for FlutterCI
  pod 'AFNetworking', '~> 3.0'

end
