"use strict";

var ScopedClient = require("scoped-http-client");

exports.create = function(url) {
    return function() {
        return ScopedClient.create(url);
    };
};

exports.getInternal = function(tuple) {
    return function(client) {
        return function(err) {
            return function(success) {
                return function() {
                    client.get()(function(err2, success2, body) {
                        if (err2 === null) {
                            success(tuple(success2,body)())();
                        } else {
                            err(err2)();
                        }
                    });
                };
            };
        };
    };
};
