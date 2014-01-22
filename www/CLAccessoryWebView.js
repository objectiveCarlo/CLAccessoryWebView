
var argscheck = cordova = require('cordova');
            
var CLAccessoryWebViewClass = function () {
    var kClassName = "CLAccessoryWebView";
    var self = this;

    self.execute = function(params, method)
    {
        if(typeof exec === 'undefined')
            {
                if(typeof cordova === 'undefined' || typeof cordova.exec === 'undefined')
                {
                     exec = function (){};
                }else
                {
                    exec = cordova.exec;
                }
            }
            exec(function(){}, function(){}, kClassName, method, params);
    }
    self.open = function(url, x, y)
    {
        self.execute([url, x, y], 'open');
    }

    self.close = function()
    {
        self.execute([], 'close');
    }
}


module.exports =  new CLAccessoryWebViewClass();


