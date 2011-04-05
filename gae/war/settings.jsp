<%@page import="org.vegastone.praytimes.PrayTimeConfigBean"%>
<%@page contentType="text/html;"%>
<%
	PrayTimeConfigBean prayerConfig = new PrayTimeConfigBean(request);
	if (request.getMethod().toUpperCase().equals("POST"))
		prayerConfig.addCookie(response);
%>
<html class="no-js">
<head>
<title>Pray Times ICS - Settings</title>
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<link type="text/css" href="styles.css" rel="stylesheet" />
<script type="text/javascript">
	function getLocation() {
		if (navigator.geolocation)
			  navigator.geolocation.getCurrentPosition(positionSuccessHandler, positionErrorHandler);
	}
	function positionSuccessHandler(position) {
		var config = document.getElementById("config");
	    config.x.value = Math.round(position.coords.latitude * 1000) / 1000;
	    config.y.value = Math.round(position.coords.longitude * 1000) / 1000;
	}    
	function positionErrorHandler(error) {
	    var message = "";   
	    switch (error.code) {
	        case error.PERMISSION_DENIED:
	            message = "This website does not have permission to use " + 
	                      "the Geolocation API";
	            break;
	        case error.POSITION_UNAVAILABLE:
	            message = "The current position could not be determined.";
	            break;
	        case error.PERMISSION_DENIED_TIMEOUT:
	            message = "The current position could not be determined " + 
	                      "within the specified timeout period.";            
	            break;
	    }
	    if (message == "") {
	        var strErrorCode = error.code.toString();
	        message = "The position could not be determined due to " + 
	                  "an unknown error (Code: " + strErrorCode + ").";
	    }
	    alert(message);
	}
</script>
<script type="text/javascript">
  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-10540377-3']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();
</script>
</head>
<body>
	<div class="header">
		<h1>Pray Times ICS</h1>
		<button type="button" id="settings" onclick="document.getElementById('config').submit();">Done</button>
	</div>
	<div>
		<h2>Settings</h2>
	</div>
	<form id="config" method="post" action="/settings.jsp">
		<input type="hidden" name="z" value="" />
		<ul>
			<li>
				<dl>
					<dt>
						<label>Location</label>
					</dt>
					<dd>
						<input type="text" name="l" size="10"
	<%
		if (prayerConfig.getLocation() != null && !prayerConfig.getLocation().equals("null")) {
	%>
							value="<%=prayerConfig.getLocation()%>"
	<%
		}
	%>
							placeholder="Name your location" />
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<label>Latitude</label>
					</dt>
					<dd>
						<input type="text" name="x" size="10"
							value="<%=prayerConfig.getX()%>" placeholder="0.00" />
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<label>Longitude</label>
					</dt>
					<dd>
						<input type="text" name="y" size="10"
							value="<%=prayerConfig.getY()%>" placeholder="0.00" />
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<label>Fajr/Isha</label>
					</dt>
					<dd>
						<select name="s">
							<option value="2">Islamic Society of North America
								(ISNA)</option>
							<option value="1">University of Islamic Sciences,
								Karachi</option>
							<option value="3">Muslim World League (MWL)</option>
							<option value="4">Umm al-Qura, Makkah</option>
							<option value="5">Egyptian General Authority of Survey</option>
							<option value="6">Institute of Geophysics, University of
								Tehran</option>
							<option value="0">Ithna Ashari</option>
						</select>
					</dd>
				</dl>
			</li>
			<li>
				<dl>
					<dt>
						<label>Asr</label>
					</dt>
					<dd>
						<select name="j">
							<option value="0">Shafi'i, Hanbali, Maliki</option>
							<option value="1">Hanafi</option>
						</select>
					</dd>
				</dl>
			</li>
		</ul>
		<div class="center">
			<button type="button" onclick="getLocation()">Get
				Location</button>
		</div>
	</form>
	<h2><address>by <a href="https://profiles.google.com/adnanmukhtar">Adnan Mukhtar</a>, v1.0</address></h2>
	<script type="text/javascript">
		var config = document.getElementById("config");
		config.z.value = new Date().getTimezoneOffset() * -1;
	<%
		if (request.getMethod().toUpperCase().equals("POST")) {
	%>
		window.location = '/';
	<%
		}
	%>
	</script>
</body>
</html>

