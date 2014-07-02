var util = require("util"),
    url = require("url"),
    path = require("path"),
    repl = require("repl"),
    Chrome = require("chrome-remote-interface");

var consoleCbs = [];

var client = Chrome({
  chooseTab: function(tabs) {
    return 0;
  }
});

client.on("connect", function(chrome) {
  chrome.Console.messageAdded(function(msg) {
    console.log(msg.message.text);
  });

  chrome.Console.clearMessages();
  chrome.Console.disable();
  chrome.Console.enable();

  chrome.Console.clearMessages(function() {
    var myEval = function(cmd) {
      chrome.Runtime.evaluate({
        'expression': cmd,
        'generatePreview': true
      }, function(error, response) {

        if (response.wasThrown) {
          console.log("Exception: ", response.result.description);
          console.log(JSON.stringify(response.result, null, 4));
        }
        chrome.close();
      });
    };

    var data = "";

    process.stdin.on('data', function(chunk) {
      data += chunk;
    });
    process.stdin.on('end', function(chunk) {
      myEval(data);
    });

  });

});

client.on("error", function(error) {
  console.log("Error", error);
});

