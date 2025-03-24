const { withPodfile, withMainApplication } = require('@expo/config-plugins');

const withRenderLynx = (config) => {
  config = withPodfile(config, (config) => {
    if (config.modResults.contents.includes("if target.name == 'Lynx'")) return config;
    config.modResults.contents = config.modResults.contents.replace('post_install do |installer|\n', "post_install do |installer|\n\t\tinstaller.pods_project.targets.each do |target|\n\t\t\tif target.name == 'Lynx'\n\t\t\t\ttarget.build_configurations.each do |config|\n\t\t\t\t\tconfig.build_settings['CLANG_CXX_LANGUAGE_STANDARD'] = 'gnu++17'\n\t\t\t\t\tconfig.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'\n\t\t\t\tend\n\t\t\tend\n\t\tend\n\n");

    return config;
  });

  return withMainApplication(config, (config) => {
    if (config.modResults.contents.includes('import com.renderlynx.LynxInitializer')) return config;
    config.modResults.contents = config.modResults.contents.replace('import com.facebook.soloader.SoLoader\n', 'import com.facebook.soloader.SoLoader\nimport com.renderlynx.LynxInitializer\n');
    config.modResults.contents = config.modResults.contents.replace('super.onCreate()\n', 'super.onCreate()\n\t\tval initializer = LynxInitializer()\n\t\tinitializer.initLynxService(applicationContext)\n\t\tinitializer.initLynxEnv(this)\n');

    return config;
  });
};

module.exports = withRenderLynx;
