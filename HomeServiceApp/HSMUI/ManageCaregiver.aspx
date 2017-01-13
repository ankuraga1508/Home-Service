<%@ Page Language="C#" %>

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
    <meta name="description" content="Manage a caregiver here">
    <meta name="author" content="IanP">
    <link rel="icon" href="images/favicon.jpg">

    <title>Manage Caregiver</title>

    <!--#include virtual="/includes/globalscript.aspx"-->

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
                    <li><a href="AdminCompletedRequests.aspx">Completed Requests</a></li>
                    <li><a href="AdminRejectedRequests.aspx">Rejected Requests</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li><a href="AddService.aspx">Add Service</a></li>
                    <li><a href="ManageService.aspx">Manage Service</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li><a href="AddCaregiver.aspx">Add Caregiver</a></li>
                    <li class="active"><a href="#">Manage Caregiver <span class="sr-only">(current)</span></a></li>
                </ul>
            </div>
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Manage Caregiver</h1>
                <form class="form-horizontal col-sm-8" style="margin-top: 50px;">
                    <div class="form-group">
                        <label for="username" class="col-sm-4 control-label">Username</label>
                        <div class="col-sm-6">
                            <select class="form-control" id="username" name="username">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="firstName" class="col-sm-4 control-label">First Name</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="lastName" class="col-sm-4 control-label">Last Name</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-4 control-label">Password</label>
                        <div class="col-sm-6">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-4 col-sm-10">
                            <button class="btn btn-success" id="updateCaregiver" name="updateCaregiver">Submit</button>
                        </div>
                    </div>
                    <div id="hidden-fields">
                        <input type="hidden" id="idUser" />
                        <input type="hidden" id="UserName" />
                        <input type="hidden" id="UserEmail" />
                        <input type="hidden" id="UserMobile" />
                        <input type="hidden" id="UserSSN" />
                        <input type="hidden" id="CreatedBy" />
                        <input type="hidden" id="CreatedOn" />
                        <input type="hidden" id="LoginId" />
                        <input type="hidden" id="IsActive" />
                        <input type="hidden" id="Address" />
                        <input type="hidden" id="Sex" />
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="js/bootstrap.min.js"></script>
    <!-- Just to make our placeholder images work. Don't actually copy the next line! -->
    <script src="assets/js/vendor/holder.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>
    <script src="js/updateCaregiver.js"></script>
    <script src="js/logout.js"></script>
</body>
</html>
