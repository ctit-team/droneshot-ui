.pragma library

function read(url) {
    var req = new XMLHttpRequest()
    req.open("GET", url, false)
    req.send(null)
    return req.responseText
}
