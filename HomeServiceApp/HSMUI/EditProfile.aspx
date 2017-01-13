<%@ Page Language="C#" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="Register here">
    <meta name="author" content="IanP">
    <link rel="icon" href="images/favicon.jpg">
    <title>Edit Profile</title>
    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="css/SimpleForm.css" rel="stylesheet">
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="assets/js/ie-emulation-modes-warning.js"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
    <div id="header">
        <h1>Edit Profile</h1>
    </div>
    <div class="container" id="fields">
        <form>
            <ul>
                <li>
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" required/>
                </li>
                <li>
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" required/>
                </li>
                <li>
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" required/>
                </li>
                <li>
                    <label for="password">Password</label>
                    <input type="text" id="password" name="password" required/>
                </li>
                <li>
                    <label for="contactNum">Contact Number</label>
                    <input type="text" id="contactNum" name="contactNum" required/>
                </li>
                <li>
                    <label for="altContactNum">Alternate Contact Number</label>
                    <input type="text" id="altContactNum" name="altContactNum" />
                </li>
                <li>
                    <label for="addressLine1">Address Line 1</label>
                    <input type="text" id="addressLine1" name="addressLine1" required/>
                </li>
                <li>
                    <label for="addressLine2">Address Line 2</label>
                    <input type="text" id="addressLine2" name="addressLine2" />
                </li>
                <li>
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" required/>
                </li>
                <li>
                    <label for="state">State</label>
                    <input type="text" id="state" name="state" required/>
                </li>
                <li>
                    <label for="zipCode">Zip Code</label>
                    <input type="text" id="zipCode" name="zipCode" required/>
                </li>
                <li>
                    <label for="sex">Sex</label>
                    <input type="text" id="sex" name="sex" required/>
                </li>
                <li>
                    <label for="dateOfBirth">Date of Birth</label>
                    <input type="text" id="dateOfBirth" name="dateOfBirth" />
                </li>
            </ul>
            <button type="submit" id="update" name="update">Update</button>
            <button id="registration-cancel">Cancel</button>
        </form>
    </div>
    <!-- Bootstrap core JavaScriptw
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="assets/js/ie10-viewport-bug-workaround.js"></script>
    <script src="js/editProfile.js"></script>
</body>
</html>
