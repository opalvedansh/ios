require 'xcodeproj'
project_path = 'ios/Runner.xcodeproj'
project = Xcodeproj::Project.open(project_path)

# Remove the Swift Package reference
project.root_object.package_references.delete_if do |pkg|
  pkg.repositoryURL.to_s.include?("FlutterGeneratedPluginSwiftPackage") || pkg.name == "FlutterGeneratedPluginSwiftPackage" || pkg.class.name.include?("SwiftPackage")
end

# Remove from frameworks build phase
project.targets.each do |target|
  target.frameworks_build_phase.files.delete_if do |file|
    file.product_ref.nil? ? false : (file.product_ref.name == "FlutterGeneratedPluginSwiftPackage" || file.product_ref.productName == "FlutterGeneratedPluginSwiftPackage")
  end
end

project.save
puts "Cleaned up pbxproj!"
