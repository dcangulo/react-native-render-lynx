const { withPodfile, withXcodeProject, IOSConfig, withMainApplication, withDangerousMod } = require('@expo/config-plugins');
const path = require('path');
const fs = require('fs');

const withRenderLynx = (config, options) => {
  config = withPodfile(config, (config) => {
    if (config.modResults.contents.includes("if target.name == 'Lynx'")) return config;
    config.modResults.contents = config.modResults.contents.replace('post_install do |installer|\n', "post_install do |installer|\n\t\tinstaller.pods_project.targets.each do |target|\n\t\t\tif target.name == 'Lynx'\n\t\t\t\ttarget.build_configurations.each do |config|\n\t\t\t\t\tconfig.build_settings['CLANG_CXX_LANGUAGE_STANDARD'] = 'gnu++17'\n\t\t\t\t\tconfig.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'\n\t\t\t\tend\n\t\t\tend\n\t\tend\n\n");

    return config;
  });

  config = withXcodeProject(config, (config) => {
    const bundlePath = options?.ios?.bundlePath || options?.bundlePath;
    if (bundlePath === undefined) return config;

    const bundleName = path.basename(bundlePath);
    const sourcePath = path.resolve(config.modRequest.projectRoot, bundlePath);
    const destinationPath = path.join(IOSConfig.Paths.getSourceRoot(config.modRequest.projectRoot), bundleName);

    fs.copyFileSync(sourcePath, destinationPath);

    const projectName = IOSConfig.XcodeUtils.getProjectName(config.modRequest.projectRoot);
    const filePath = path.join(projectName, bundleName);
    if (config.modResults.hasFile(filePath)) return config;

    config.modResults = IOSConfig.XcodeUtils.addResourceFileToGroup({
      filepath: filePath,
      groupName: projectName,
      project: config.modResults,
      isBuildFile: true,
    });

    return config;
  });

  config = withMainApplication(config, (config) => {
    if (config.modResults.contents.includes('import com.renderlynx.LynxInitializer')) return config;
    config.modResults.contents = config.modResults.contents.replace('import com.facebook.soloader.SoLoader\n', 'import com.facebook.soloader.SoLoader\nimport com.renderlynx.LynxInitializer\n');
    config.modResults.contents = config.modResults.contents.replace('super.onCreate()\n', 'super.onCreate()\n\t\tval initializer = LynxInitializer()\n\t\tinitializer.initLynxService(applicationContext)\n\t\tinitializer.initLynxEnv(this)\n');

    return config;
  });

  return withDangerousMod(config, [
    'android',
    (config) => {
      const bundlePath = options?.android?.bundlePath || options?.bundlePath;
      if (bundlePath === undefined) return config;

      const bundleName = path.basename(bundlePath);
      const sourcePath = path.resolve(config.modRequest.projectRoot, bundlePath);
      const destinationPath = path.resolve(config.modRequest.platformProjectRoot, 'app', 'src', 'main', 'assets', bundleName);
      const destinationDirectory = path.dirname(destinationPath);

      if (!fs.existsSync(destinationDirectory)) fs.mkdirSync(destinationDirectory);
      fs.copyFileSync(sourcePath, destinationPath);

      return config;
    }
  ]);
};

module.exports = withRenderLynx;
