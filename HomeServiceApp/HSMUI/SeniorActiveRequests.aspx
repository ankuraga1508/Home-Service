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
    <meta name="description" content="Active requests for seniors">
    <meta name="author" content="ArjunB">
    <link rel="icon" href="/images/favicon.jpg">

    <title>Active Requests</title>

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
                    <li><a href="SeniorDashboard.aspx">Shedule a Service</a></li>
                    <li class="active"><a href="#">Requests Being Serviced<span class="sr-only">(current)</span></a></li>
                    <li><a href="SeniorCompletedRequests.aspx">Completed Requests</a></li>
                    <li><a href="SeniorRejectedRequests.aspx">Rejected Requests</a></li>
                </ul>
            </div>
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
                <h1 class="page-header">Requests Being Serviced</h1>
                <div class="col-sm-offset-1" style="padding-top:30px">
                    <style type="text/css">
                    .tg  {border-collapse:collapse;border-spacing:0;border-color:#999;}
                    .tg td{font-family:Arial, sans-serif;font-size:16px;padding:10px 20px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#444;background-color:#F7FDFA;}
                    .tg th{font-family:Arial, sans-serif;font-size:18px;font-weight:normal;padding:10px 20px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#999;color:#fff;background-color:#337ab7;}
                    .tg .tg-62xo{font-weight:bold;font-size:14px;text-align:center;vertical-align:top}
                    .tg .tg-qgs5{font-size:14px;background-color:#efefef;color:#000000;text-align:center;vertical-align:top}
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
    <script src="/js/seniorActiveRequests.js"></script>
    <script src="js/logout.js"></script>
</body>
</html>

