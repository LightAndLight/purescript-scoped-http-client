"use strict";

var ScopedClient = require("scoped-http-client");

exports.create = function(url) {
    return function() {
        return ScopedClient.create(url);
    };
};

exports.scope = function(client) {
    return function(path) {
        return function(cb) {
            return function() {
                client.scope(path, function(cli) {
                    cb(cli)();
                });
            };
        };
    };
};

exports.setPath = function(client) {
    return function(url) {
        return function() {
            client.path(path);
        };
    };
};

exports.getInternal = function(client) {
    return function(err) {
        return function(success) {
            return function() {
                client.get()(function(err2, success2, body) {
                    if (err2 === null) {
                        var result = {
                            response: success2,
                            body: body
                        }
                        success(result)();
                    } else {
                        err(err2)();
                    }
                });
            };
        };
    };
};

exports.delInternal = function(client) {
    return function(err) {
        return function(success) {
            return function() {
                client.del()(function(err2, success2, body) {
                    if (err2 === null) {
                        var result = {
                            response: success2,
                            body: body
                        }
                        success(result)();
                    } else {
                        err(err2)();
                    }
                });
            };
        };
    };
};

exports.postInternal = function(client) {
    return function(data) {
        return function(err) {
            return function(success) {
                return function() {
                    client.post(data)(function(err2, success2, body) {
                        if (err2 === null) {
                            var result = {
                                response: success2,
                                body: body
                            }
                            success(result)();
                        } else {
                            err(err2)();
                        }
                    });
                };
            };
        };
    };
};

exports.putInternal = function(client) {
    return function(data) {
        return function(err) {
            return function(success) {
                return function() {
                    client.put(data)(function(err2, success2, body) {
                        if (err2 === null) {
                            var result = {
                                response: success2,
                                body: body
                            }
                            success(result)();
                        } else {
                            err(err2)();
                        }
                    });
                };
            };
        };
    };
};
