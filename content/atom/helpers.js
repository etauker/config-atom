
module.exports.csvToJson = function(csv) {
    csv = csv.trim();

    var lines = csv.split("\n");
    var result = [];
    var headers = lines[0].split(";");

    for (var i=1; i<lines.length; i++) {
            var obj = {};
            var currentLine = lines[i].split(";");
            for (var j=0; j<headers.length; j++){
                obj[headers[j]] = currentLine[j];//.replace("\\r", "");
            }
        result.push(obj);
    }
    var jsonString = JSON.stringify(result);
    jsonString = jsonString.replace(/\\r/g, "");
    return jsonString;
}

module.exports.jsonToCsv = function(input) {
    input = input.trim();
    input = input.replace(/\\r/g, "");
    json = JSON.parse(input);

    var csv = "";
    var headers = [];
    var rows = [];
    headers = Object.keys(json[0]);
    csv += headers.join(';');
    csv += "\r\n";

    // For each row
    for (var i=0; i<json.length; i++) {
        var row = "";

        // var currentLine = lines[i].split(";");

        for (var j=0; j<headers.length; j++){

            row += json[i][headers[j]];
            if (j != headers.length-1) {
                row += ";";
            }
        }
        row += "\r\n";
        csv += row;
    }

    return csv;
}

module.exports.stripUuidDashes = function(input) {
    var output = input.replace(/(........)-(....)-(....)-(............)/g, function(match) {
        var m = match.replace(/-/g, "");
        console.log("m");
        console.log(m);
        return m;
    });
    console.log("output");
    console.log(output);
    return output;
}
