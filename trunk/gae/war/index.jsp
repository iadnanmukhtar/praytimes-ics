<%@page import="java.util.Date"%>
<%@page import="org.vegastone.praytimes.PrayEvent"%>
<%@page import="org.vegastone.praytimes.CalendarIterator"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.vegastone.praytimes.PrayTimeConfigBean"%>
<%@page contentType="text/html;"%>
<%
	PrayTimeConfigBean prayerConfig = new PrayTimeConfigBean(request);
	prayerConfig.addCookie(response);
	ArrayList<String> prayerNames = prayerConfig.getTimeNames();
	Calendar date = Calendar.getInstance();
	date.add(Calendar.DAY_OF_MONTH, prayerConfig.getOffset());
%>
<html>
<head>
<title>Pray Times ICS</title>
<meta name="viewport"
	content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div class="header">
		<h1>Prayer Times for
		<%
			if (prayerConfig.getLocation() == null) {
		%>
			Unknown Location
		<%
			} else {
		%>
			<%=prayerConfig.getLocation()%>
		<%
			}
		%>
		</h1>
		<button type="button" id="settings" onclick="window.location='settings.jsp';">Settings</button>
	</div>
	<div>
		<h2><%=PrayEvent.DATE.format(date.getTime())%></h2>
	</div>
	<form id="config" action="today.jsp">
		<input type="hidden" name="l" value="<%=prayerConfig.getLocation()%>" />
		<input type="hidden" name="x" value="<%=prayerConfig.getX()%>" />
		<input type="hidden" name="y" value="<%=prayerConfig.getY()%>" />
		<input type="hidden" name="z" value="<%=prayerConfig.getZ()%>" />
		<ul>
	<%
		ArrayList<String> prayerTimes = prayerConfig.getPrayerTimes(date,
				prayerConfig.getX(), prayerConfig.getY(), 0.0);
		int i = 0;
		for (String time : prayerTimes) {
			if (i != 1 && i != 4) {
				PrayEvent prayer = new PrayEvent(prayerConfig,
						prayerNames.get(i), date, time);
	%>
			<li class="vevent">
				<dl class="location" title="<%=prayer.getLocation()%>">
					<dt class="summary">
						<%=prayer.getName()%>
					</dt>
					<dd class="dtstart" title="<%=prayer.getISODate().toGMTString()%>">
						<%=prayer.getFormattedTime()%>
					</dd>
				</dl>
			</li>
	<%
			}
			i++;
		}
	%>
		</ul>
		<div class="center">
			<button type="button" onclick="window.location='ical'">Download iCalendar</button>
		</div>
	</form>
	<p>
		Use <strong>Pray Times ICS</strong> to calculate the five daily Muslim prayer times.
		It also supports the download of an <strong>iCalendar/ical/ics</strong> file that could
		be imported into your desktop calendar (Google Calendar, MS Outlook etc.) or published.
		
		Pray Times ICS can also be used to quickly lookup times for prayer on smart phone
		(iPhone, Android, Blackberry, etc.)
	</p>
	<h2><address>by <a href="https://profiles.google.com/adnanmukhtar">Adnan Mukhtar</a>, v1.0</address></h2>
</body>
</html>
