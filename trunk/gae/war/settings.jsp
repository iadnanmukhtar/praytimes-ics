<%@page import="org.vegastone.praytimes.PrayTimeConfigBean"%>
<%@page contentType="text/html;"%>
<%
	PrayTimeConfigBean prayerConfig = new PrayTimeConfigBean(request);
%>
<html class="no-js">
<head>
<title>Pray Times ICS - Settings</title>
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<link type="text/css" href="styles.css" rel="stylesheet" />
<script type="text/javascript" src="modernizr-1.7.min.js"></script>
<script type="text/javascript">
	function getLocation() {
		var config = document.getElementById("config");
		config.z.value = new Date().getTimezoneOffset() * -1;
		if (Modernizr.geolocation){
			  navigator.geolocation.getCurrentPosition(function(position) {
			    config.x.value = position.coords.latitude;
			    config.y.value = position.coords.longitude;
			  });  
		}
	}    
</script>
</head>
<body>
	<div class="header">
		<h1>Pray Time ICS</h1>
		<button type="button" id="settings" onclick="document.getElementById('config').submit();">Done</button>
	</div>
	<div>
		<h2>Settings</h2>
	</div>
	<form id="config" action="/index.jsp">
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
</body>
</html>

