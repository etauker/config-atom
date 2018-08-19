const { execSync } = require('child_process');

var install = function(oConfig) {
    console.log("Starting config-atom setup - running install");
};

var configure = function(oConfig) {
    console.log("Starting config-atom setup - running configure");
    process.chdir(oConfig.workspace + "/config-atom");
    _executeCommand("bash update-config.sh --install");
};

var backup = function(oConfig) {
    console.log("Starting config-atom setup - running backup");
    process.chdir(oConfig.workspace + "/config-atom");
    _executeCommand("bash backup.sh --commit --backup");
};

function _executeCommand(sCommand) {
    command = execSync(sCommand, function(err, stdout, stderr) {
        if (err) {
            // should have err.code here?
        }

        if (stderr) {
            console.log("--------------------------------------------------");
            console.log("Error executing command: " + sCommand);
            console.log("--------------------------------------------------");
            console.log("stderr: " + stderr);
            console.log("--------------------------------------------------");
        }
        console.log("Command Output: ");
        console.log(stdout);
    });

    // command.on('exit', function (code) {
    //     console.log("exit code: " + code);
    // });
};

module.exports.install = install;
module.exports.configure = configure;
module.exports.backup = backup;
