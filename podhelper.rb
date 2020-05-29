# Install pods needed to embed Flutter application, Flutter engine, and plugins
# from the host application Podfile.
#
# @example
#   target 'MyApp' do
#     install_all_flutter_pods 'my_flutter'
#   end
# @param [String] flutter_application_path Path of the root directory of the Flutter module.
#                                          Optional, defaults to two levels up from the directory of this script.
#                                          MyApp/my_flutter/.ios/Flutter/../..
def install_all_native_flutter_pods(flutter_application_path = nil)
#  flutter_application_path ||= File.join('..', '..')
  nativemode = 0;
  install_native_flutter_engine_pod(flutter_application_path)
  install_native_flutter_plugin_pods(flutter_application_path)
  install_native_flutter_application_pod(flutter_application_path)
end

# Install Flutter engine pod.
#
# @example
#   target 'MyApp' do
#     install_flutter_engine_pod
#   end
def install_native_flutter_engine_pod(flutter_application_path)
  engine_dir = File.join(flutter_application_path, 'engine')

  # Keep pod path relative so it can be checked into Podfile.lock.
  # Process will be run from project directory.
  engine_pathname = Pathname.new engine_dir
  puts "engine_dir: #{engine_pathname}"
  project_directory_pathname = Pathname.new Dir.pwd
  puts "project_directory_pathname: #{project_directory_pathname}"
  relative = engine_pathname.relative_path_from project_directory_pathname
  puts "relative: #{relative}"
  puts "engine_pathname.relative_path_from project_directory_pathname: #{relative}"
  pod 'Flutter', :path => relative.to_s, :inhibit_warnings => true
end

# Install Flutter plugin pods.
#
# @example
#   target 'MyApp' do
#     install_flutter_plugin_pods 'my_flutter'
#   end
# @param [String] flutter_application_path Path of the root directory of the Flutter module.
#                                          Optional, defaults to two levels up from the directory of this script.
#                                          MyApp/my_flutter/.ios/Flutter/../..
def install_native_flutter_plugin_pods(flutter_application_path)
  #flutter_application_path ||= File.join('..', '..')

  # Keep pod path relative so it can be checked into Podfile.lock.
  # Process will be run from project directory.
  current_directory_pathname = Pathname.new flutter_application_path
  project_directory_pathname = Pathname.new Dir.pwd
  relative = current_directory_pathname.relative_path_from project_directory_pathname


  Dir.foreach flutter_application_path do |sub|
        # 忽略隐藏文件
        if sub =~ /\.(.*)/ 
            next
        end
        if sub =='engine' 
            next
        end

       sub_abs_path = File.join(flutter_application_path, sub)
        puts "sub_abs_path: #{sub_abs_path}"
        pod sub, :path=>sub_abs_path, :inhibit_warnings => true
  end

end

# Install Flutter application pod.
#
# @example
#   target 'MyApp' do
#     install_flutter_application_pod '../flutter_settings_repository'
#   end
# @param [String] flutter_application_path Path of the root directory of the Flutter module.
#                                          Optional, defaults to two levels up from the directory of this script.
#                                          MyApp/my_flutter/.ios/Flutter/../..
def install_native_flutter_application_pod(flutter_application_path)
  app_framework_dir = File.join(flutter_application_path, 'App.framework')
  app_framework_dylib = File.join(app_framework_dir, 'App')
  if !File.exist?(app_framework_dylib)
    # Fake an App.framework to have something to link against if the xcode backend script has not run yet.
    # CocoaPods will not embed the framework on pod install (before any build phases can run) if the dylib does not exist.
    # Create a dummy dylib.
    FileUtils.mkdir_p(app_framework_dir)
    `echo "static const int Moo = 88;" | xcrun clang -x c -dynamiclib -o "#{app_framework_dylib}" -`
  end

  # Keep pod and script phase paths relative so they can be checked into source control.
  # Process will be run from project directory.
  current_directory_pathname = Pathname.new flutter_application_path
  project_directory_pathname = Pathname.new Dir.pwd
  relative = current_directory_pathname.relative_path_from project_directory_pathname
  pod 'my_flutter', :path => relative.to_s, :inhibit_warnings => true
end

def upload_production(flutter_application_path)
    current_pathname = Pathname.new flutter_application_path
    project_pathname = Pathname.new Dir.pwd
    script_phase :name => 'Upload Flutter Production Script',
    :script => "set -e\nset -u\n\"${SRCROOT}\"/#{current_pathname}/xcode_backend.sh build",
    :execution_position => :before_compile
  
end
