# Dart POW Challenge Package

Finally a POW challenge(captcha) package for dart.

---

Note: Ideas borrowed at [xenohunter/lapti-pow-captcha](https://github.com/xenohunter/lapti-pow-captcha)

## POW Challenge Idea


If there are some methods in the API which take much time to serve, you may want to guard them against DDoS attacks. A way of doing that is described below.

The server keeps some secret data `SECRET` which is unknown to anyone. The server can also generate additional salt to go into generating a `challenge`, say for example, `session_id` of the visit. Then the server returns a token `token` which is `Hash(SECRET + additional salt)`, and also a number `complexity` which sets the complexity level.

The client then takes `token` and tries to find such an int value `nonce` that the first n characters of hex string representation of `Hash(token + nonce.toString())` are `0` characters, where n equals `complexity`.

When the needed `nonce` is found the client sends a request to the server and attach `nounce`.

The server then calculates the `Hash(token + nounce)` and checks if the result matches the given complexity.