<%@ Page Language="C#" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="js/signinCheck.js"></script>
    <script>
        if (redirectHandler(sessionStorage && sessionStorage.getItem('idUser') && sessionStorage.getItem('UserRoleId') == 1, 'Default.aspx'));
    </script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Home page for seniors">
    <meta name="author" content="ArjunB">
    <link rel="icon" href="/images/favicon.jpg">

    <title>Home</title>

    <!-- Bootstrap core CSS -->
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="/css/seniorDashboard.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>

</head>

<body>

    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="SeniorDashboard.aspx">Home Service Manager</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="SeniorDashboard.aspx">Home</a></li>
                    <li><a href="javascript:void(0);" onclick="logout();">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3 col-md-2 sidebar" id="sidebar">
                <ul class="nav nav-sidebar">
                    <li class="active"><a href="#">Schedule a Service<span class="sr-only">(current)</span></a></li>
                    <li><a href="SeniorActiveRequests.aspx">Requests Being Serviced</a></li>
                    <li><a href="SeniorCompletedRequests.aspx">Completed Requests</a></li>
                    <li><a href="SeniorRejectedRequests.aspx">Rejected Requests</a></li>
                </ul>
            </div>
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Available Services</h1>
                <div id="servicesDiv" class="col-sm-offset-1">
                </div>
            </div>
        </div>
    </div>

    <!-- Schedule Service Modal  -->
    <div class="modal fade" id="schSrvModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="modalLabel">New request</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="serviceName" class="control-label">Service Type:</label>
                            <input type="text" class="form-control" id="serviceName" disabled>
                            <input type="hidden" id="serviceId" />
                        </div>
                        <div class="form-group">
                            <label for="reqDate" class="control-label">Date:</label>
                            <input type="date" class="form-control" id="reqDate" required>
                        </div>
                        <div class="form-group">
                            <label for="reqTimeFrom" class="control-label">Service Start Time (Example: 13:00 for 1 PM):</label>
                            <input type="time" class="form-control" id="reqTimeFrom" required>
                        </div>
                        <div class="form-group">
                            <label for="reqTimeTo" class="control-label">Service End Time (Example: 14:00 for 2 PM):</label>
                            <input type="time" class="form-control" id="reqTimeTo" required>
                        </div>
                        <script>
                            var today = new Date();
                            var dd = today.getDate();
                            var mm = today.getMonth() + 1;
                            var yyyy = today.getFullYear();
                            if (dd < 10) {
                                dd = '0' + dd;
                            }
                            if (mm < 10) {
                                mm = '0' + mm;
                            }
                            today = yyyy + '-' + mm + '-' + dd;
                            var maxDate = yyyy + 2 + '-' + mm + '-' + dd;
                            document.getElementById("reqDate").setAttribute("max", maxDate);
                        </script>
                        <!-- <div id="success-message"></div> -->
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-success" data-dismiss="modal" id="submitSchedule">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="/js/seniorDashboard.js"></script>
    <script src="js/logout.js"></script>
</body>
</html>

