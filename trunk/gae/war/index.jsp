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
<title>Pray Times ICS - iCalendar Generator</title>
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta name="keywords" content="Muslim, Islam, Prayer, Salah, Salat, Namaz, iCalendar, vCalendar, ical, ics" />
<link href="styles.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/favicon.ico" />
<link rel="icon" type="image/png" href="/icon.png" />
<link rel="apple-touch-icon" href="/icon.png" />
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
		It is also a prayer calendar generator, downloadable as an <strong>iCalendar</strong>
		file that could be imported into your desktop calendar (Google Calendar, MS Outlook etc.) or published.
		Pray Times ICS can also be used to quickly lookup times for prayer on smart phone
		(iPhone, Android, Blackberry, etc.)
	</p>
	<p>	
		Keywords: Muslim, Islam, Prayer, Salah, Salat, Namaz, iCalendar, vCalendar, ical, ics
	</p>
	<p>
		<iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.facebook.com%2Fpages%2FPray-Times-ICS-A-Muslim-Prayer-Calendar-Generator%2F153929961338506&amp;layout=standard&amp;show_faces=false&amp;width=290&amp;action=like&amp;font&amp;colorscheme=light&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:290px; height:35px;" allowTransparency="true"></iframe>
	</p>
	<h2><address>by <a href="https://profiles.google.com/adnanmukhtar">Adnan Mukhtar</a>, v1.0</address></h2>
	
</body>
</html>
