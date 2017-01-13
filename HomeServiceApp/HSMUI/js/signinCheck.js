function redirectHandler(condition, url) {
    if (!condition) {
        window.location = url;
        sessionStorage.clear();
    } else {
        return true;
    }
}