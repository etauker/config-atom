const { execSync } = require('child_process');
let helper = require('../development-setup/lib/helper.js');

var install = function(oConfig) {
    console.log("-- [config-atom] - running install");
    helper.changeDirectory(oConfig.platform, oConfig.workspace, "config-atom", oConfig.options.debug);
    helper.executeCommand(`bash install.sh --os=${oConfig.platform}`, oConfig.options.debug);
};

var configure = function(oConfig) {
    console.log("-- [config-atom] - running configure");
    helper.changeDirectory(oConfig.platform, oConfig.workspace, "config-atom", oConfig.options.debug);
    helper.executeCommand("bash update-config.sh --install", oConfig.options.debug);
};

var backup = function(oConfig) {
    console.log("-- [config-atom] - running backup");
    helper.changeDirectory(oConfig.platform, oConfig.workspace, "config-atom", oConfig.options.debug);
    helper.executeCommand("bash backup.sh --commit --push", oConfig.options.debug);
};

module.exports.install = install;
module.exports.configure = configure;
module.exports.backup = backup;
