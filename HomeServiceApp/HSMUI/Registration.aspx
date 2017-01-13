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
    <link rel="icon" href="/images/favicon.jpg">

    <title>Registration</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="css/registration.css" rel="stylesheet">

</head>

  <body>

    <div class="container">

    <form class="form-signin">
        <h2 class="form-signin-heading">Register</h2>
	    <div class="form-group">
	    <label for="firstName" class="control-label">First Name</label>
		<input type="text" class="form-control" id="firstName" name="firstName" placeholder="First Name" required>
	    </div>
	    <div class="form-group">
	    <label for="lastName" class="control-label">Last Name</label>
		<input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last Name" required>
	    </div>
	    <div class="form-group">
	    <label for="username" class="control-label">Username</label>
		<input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
	    </div>
	    <div class="form-group">
	    <label for="password" class="control-label">Password</label>
		<input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
	    </div>
	    <div class="form-group">
	    <label for="contactNum" class="control-label">Contact Number</label>
		<input type="text" class="form-control" id="contactNum" name="contactNum" placeholder="Contact Number" required>
	    </div>
	    <div class="form-group">
	    <label for="addressLine1" class="control-label">Address Line 1</label>
		<input type="text" class="form-control" id="addressLine1" name="addressLine1" placeholder="Address Line 1" required>
	    </div>
	    <div class="form-group">
	    <label for="sex" class="control-label">Sex</label>
		<input type="text" class="form-control" id="sex" name="sex" placeholder="Sex" required>
	    </div>
	    <div class="form-group">
		<button type="submit" class="btn btn-lg btn-success btn-block" id="register" name="register">Register</button>
        <a href="Default.aspx">Go Back</a>
	    </div>
    </form>

    </div> <!-- /container -->
	<script src="js/jquery-2.0.0.min.js"></script>
    <script src="js/registration.js"></script>
  </body>
</html>



