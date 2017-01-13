//Logout the user logged in to this session.
function logout() {
    if (sessionStorage && sessionStorage.getItem('idUser')) {
        sessionStorage.removeItem('idUser');
        sessionStorage.clear();
	}
	window.location = "Default.aspx";
}
