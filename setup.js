var install = function(oConfig) {
    console.log("Starting config-atom setup - running install");
}
var configure = function(oConfig) {
    console.log("Starting config-atom setup - running configure");
}
var backup = function(oConfig) {
    console.log("Starting config-atom setup - running backup");
}

module.exports.install = install;
module.exports.configure = configure;
module.exports.backup = backup;
