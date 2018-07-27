let fs = require('fs');
let helper = require('../development-setup/lib/helper.js');

(function() {
    console.log("Starting config-atom setup - running setup.js");
    var aArgs = helper.getArguments();

    // Set up each item under the settings option of configuration
    aArgs["SETTINGS"].forEach(function(oSetting) {
        var sConfigRepo = helper.extractRepoName(oSetting.repository);
        var sBranch = oSetting.branch || "master";
        if (!fs.existsSync(sConfigRepo)) {
            helper.cloneRepository(oSetting.repository);
        }
        helper.changeDirectory(aArgs["PLATFORM"], aArgs["WORKSPACE"], sConfigRepo);
        // helper.executeCommand("git checkout " + sBranch);
        // helper.executeCommand("git pull origin " + sBranch);

        // TODO: Carry out specific setup steps here...

    });
})();
