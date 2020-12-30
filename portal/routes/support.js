module.exports = function (app, request, ports) {
    app.post('/endpoints/support/chat', function (req, res) {
        var options = {
            method: 'POST',
            uri: `${req.protocol}://${req.hostname}:${ports.support}${process.env.CHAT_ENDPOINT}`,
            body: req.body,
            json: true,
            rejectUnauthorized: false,//add when working with https sites
            requestCert: false,//add when working with https sites
            agent: false,//add when working with https sites
        };
        request.post(options, function (error, response, body) {
            console.log('support for ', req.body, ': ', body);
            res.send(body);
        });
    });
};
