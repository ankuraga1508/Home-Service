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
    <meta name="description" content="Completed requests for administrator">
    <meta name="author" content="ArjunB">

    <title>Completed Requests</title>

    <link rel="icon" href="images/favicon.jpg">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:300,600,400' rel='stylesheet' type='text/css'>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="css/jsgrid.min.css" />
    <link type="text/css" rel="stylesheet" href="css/jsgrid-theme.min.css" />
    <link type="text/css" href="css/adminStyle.css" rel="stylesheet">
    <link type="text/css" href="css/showRequests.css" rel="stylesheet">
    <link type="text/css" href="css/assignRequest.css" rel="stylesheet" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.11.2/themes/cupertino/jquery-ui.css">

    <script src="js/jquery-2.0.0.min.js"></script>
    <script src="http://code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
    <script src="js/jsgrid.core.js"></script>
    <script src="js/jsgrid.load-indicator.js"></script>
    <script src="js/jsgrid.load-strategies.js"></script>
    <script src="js/jsgrid.sort-strategies.js"></script>
    <script src="js/jsgrid.field.js"></script>
    <script src="js/jsgrid.field.text.js"></script>
    <script src="js/jsgrid.field.number.js"></script>
    <script src="js/jsgrid.field.select.js"></script>
    <script src="js/jsgrid.field.checkbox.js"></script>
    <script src="js/jsgrid.field.control.js"></script>
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
                    <li class="active"><a href="#">Completed Requests <span class="sr-only">(current)</span></a></li>
                    <li><a href="AdminRejectedRequests.aspx">Rejected Requests</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li><a href="AddService.aspx">Add Service</a></li>
                    <li><a href="ManageService.aspx">Manage Service</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li><a href="AddCaregiver.aspx">Add Caregiver</a></li>
                    <li><a href="ManageCaregiver.aspx">Manage Caregiver</a></li>
                </ul>
            </div>
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Completed Requests</h1>
            </div>
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <div class="col-sm-offset-1">
                    <style type="text/css">
                        .tg {
                            border-collapse: collapse;
                            border-spacing: 0;
                            border-color: #999;
                        }

                            .tg td {
                                font-family: Arial, sans-serif;
                                font-size: 14px;
                                padding: 10px 20px;
                                border-style: solid;
                                border-width: 1px;
                                overflow: hidden;
                                word-break: normal;
                                border-color: #999;
                                color: #444;
                                background-color: #F7FDFA;
                            }

                            .tg th {
                                font-family: Arial, sans-serif;
                                font-size: 16px;
                                font-weight: normal;
                                padding: 10px 20px;
                                border-style: solid;
                                border-width: 1px;
                                overflow: hidden;
                                word-break: normal;
                                border-color: #999;
                                color: #fff;
                                background-color: #337ab7;
                            }

                            .tg .tg-62xo {
                                font-weight: bold;
                                font-size: 14px;
                                text-align: center;
                                vertical-align: top;
                            }

                            .tg .tg-qgs5 {
                                font-size: 14px;
                                background-color: #efefef;
                                color: #000000;
                                text-align: center;
                                vertical-align: top;
                            }
                    </style>
                    <table class="tg" id="activeReqTable">
                        <tr>
                            <th class="tg-9hbo"><strong>Service Type</strong></th>
                            <th class="tg-9hbo"><strong>Scheduled Date</strong></th>
                            <th class="tg-9hbo"><strong>Service Start Time</strong></th>
                            <th class="tg-9hbo"><strong>Service End Time</strong></th>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            var requesterid = sessionStorage.getItem("idUser");
            $.ajax({
                type: "GET",
                url: "api/request/getrequestbyfilters?status=3",
                dataType: "json",
                success: function (data) {
                    var jsonData = JSON.parse(data);
                    for (var i = 0; i < jsonData.length; i++) {
                        var obj = jsonData[i];
                        var tableData = '<tr><td class="tg-yxcv">' + obj.serviceName + '</td><td class="tg-yxcv">' + obj.ScheduleDate + '</td><td class="tg-yxcv">' + obj.StartTime + '</td><td class="tg-yxcv">' + obj.EndTime + '</td></tr>';
                        $(tableData).appendTo('#activeReqTable');
                    }
                }
            });
        });
    </script>
    <script src="js/logout.js"></script>
</body>
</html>


