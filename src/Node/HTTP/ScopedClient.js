"use strict";

ScopedClient = require("scoped-http-client");

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
                            success(tuple(success2,body));
                        } else {
                            err(err2);
                        }
                    });
                };
            };
        };
    };
};

exports.postInternal = function(tuple) {
    return function(client) {
        return function(data) {
            return function(err) {
                return function(success) {
                    return function() {
                        client.post(data)(function(err2, success2, body) {
                            if (err2 === null) {
                                success(tuple(success2,body));
                            } else {
                                err(err2);
                            }
                        });
                    };
                };
            };
        };
    };
};

exports.delInternal = function(tuple) {
    return function(client) {
        return function(err) {
            return function(success) {
                return function() {
                    client.del()(function(err2, success2, body) {
                        if (err2 === null) {
                            success(tuple(success2,body));
                        } else {
                            err(err2);
                        }
                    });
                };
            };
        };
    };
};

exports.putInternal = function(tuple) {
    return function(client) {
        return function(data) {
            return function(err) {
                return function(success) {
                    return function() {
                        client.put(data)(function(err2, success2, body) {
                            if (err2 === null) {
                                success(tuple(success2,body));
                            } else {
                                err(err2);
                            }
                        });
                    };
                };
            };
        };
    };
};
