<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="js/signinCheck.js"></script>
    <script>
        if (redirectHandler(sessionStorage && sessionStorage.getItem('idUser') && sessionStorage.getItem('UserRoleId') == 3, 'Default.aspx'));
    </script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Add a new service here">
    <meta name="author" content="ArjunB">
    <link rel="icon" href="images/favicon.jpg">

    <title>Add Service</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="css/adminStyle.css" rel="stylesheet">

    <script src="js/jquery-2.0.0.min.js"></script>

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
                <a class="navbar-brand" href="AdminDashboard.aspx">Home Service Manager</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="AdminDashboard.aspx">Dashboard</a></li>
                    <li><a href="javascript:void(0);" onclick="logout();">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3 col-md-2 sidebar" id="sidebar">
                <ul class="nav nav-sidebar">
                    <li><a href="AdminDashboard.aspx">Active Requests</a></li>
                    <li><a href="">Completed Requests</a></li>
                    <li><a href="">Rejected Requests</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li class="active"><a href="#">Add Service <span class="sr-only">(current)</span></a></li>
                    <li><a href="ManageService.aspx">Manage Service</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li><a href="AddCaregiver.aspx">Add Caregiver</a></li>
                    <li><a href="ManageCaregiver.aspx">Manage Caregiver</a></li>
                </ul>
            </div>
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Add Service</h1>
                <form class="form-horizontal col-sm-8" style="margin-top: 50px;">
                    <div class="form-group">
                        <label for="serviceName" class="col-sm-4 control-label">Service Name</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="serviceName" name="serviceName" placeholder="Service Name">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="serviceDesc" class="col-sm-4 control-label">Service Description</label>
                        <div class="col-sm-6">
                            <textarea class="form-control" id="serviceDesc" name="serviceDesc" placeholder="Service Description"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-4 col-sm-5">
                            <div class="radio-inline">
                                <label>
                                    <input type="radio" id="serviceActive" name="serviceStatus" value="1" checked />
                                    Service Active
                                </label>
                            </div>
                            <div class="radio-inline">
                                <label>
                                    <input type="radio" id="serviceInactive" name="serviceStatus" value="0" />
                                    Service Inactive
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-4 col-sm-10">
                            <button type="submit" class="btn btn-success" id="addService" name="addService">Submit</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script src="js/bootstrap.min.js"></script>
    <script src="js/addService.js"></script>
    <script src="js/logout.js"></script>
</body>
</html>



