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
<title>
		<%
			if (prayerConfig.getLocation() == null) {
		%>
		Pray Times ICS - Muslim Prayer Times iCalendar Generator
		<%
			} else {
		%>
		Prayer Times for <%=prayerConfig.getLocation()%>
		<%
			}
		%>
</title>
<meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta name="keywords" content="Muslim, Islam, Prayer, Salah, Salat, Namaz, iCalendar, vCalendar, ical, ics" />
<meta name="google-site-verification" content="rSRF7_6WUBm-QH_4GDGq44L_mhDjJ0VxvZKBJM4VXHM" />
<link href="styles.css" rel="stylesheet" type="text/css" />
<link rel="shortcut icon" href="/favicon.ico" />
<link rel="icon" type="image/png" href="/icon.png" />
<link rel="apple-touch-icon" href="/icon.png" />
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
	<p class="center feed">
		<a href="<%=prayerConfig.getCalendarFeed()%>">iCalendar Feed</a><br />
	</p>
	<p class="center feed">
		<a href="webcal://<%=request.getServerName()%><%=prayerConfig.getCalendarFeed()%>">iCal/webcal Feed</a><br />
	</p>
	<p>
		Use <strong>Pray Times ICS</strong> to calculate the five daily Muslim prayer times.
		It is also a prayer calendar generator that can be downloaded or subscribed to as an <strong>iCalendar</strong>
		feed. It could also be imported into your desktop calendar (Google Calendar, MS Outlook, Apple iCal etc.) or published.
		Pray Times ICS can also be used to quickly lookup times for prayer on smart phone
		(iPhone, iPad, Android, Blackberry, etc.)
	</p>
	<p>	
		Keywords: Muslim, Islam, Prayer, Salah, Salat, Namaz, iCalendar, vCalendar, ical, webcal, ics
	</p>
	<p>
		<iframe src="http://www.facebook.com/plugins/like.php?href=http%3A%2F%2Fwww.facebook.com%2Fpages%2FPray-Times-ICS-A-Muslim-Prayer-Calendar-Generator%2F153929961338506&amp;layout=button_count&amp;show_faces=false&amp;width=250&amp;action=like&amp;font&amp;colorscheme=light&amp;height=21" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:250px; height:21px;" allowTransparency="true"></iframe>
	</p>
	<p>
		<a href="http://www.facebook.com/pages/Pray-Times-ICS-A-Muslim-Prayer-Calendar-Generator/153929961338506">Facebook Page</a><br />
		<a href="http://code.google.com/p/praytimes-ics/">Project Page</a><br />
		<a href="http://code.google.com/p/praytimes-ics/issues/list">Issues?</a><br />
	</p>
	<p>
		by <a href="https://profiles.google.com/adnanmukhtar">Adnan Mukhtar</a>, v1.0<br />
		Credit: <a href="http://www.praytimes.org">PrayTimes.org</a> 
	</p>
	<p>
		<script type="text/javascript"><!--
		window.googleAfmcRequest = {
		  client: 'ca-mb-pub-1199080602686133',
		  ad_type: 'text_image',
		  output: 'html',
		  channel: '4662651407',
		  format: '320x50_mb',
		  oe: 'utf8',
		  color_border: '336699',
		  color_bg: 'FFFFFF',
		  color_link: '0000FF',
		  color_text: '000000',
		  color_url: '008000',
		};
		//--></script>
		<script type="text/javascript" 
		   src="http://pagead2.googlesyndication.com/pagead/show_afmc_ads.js"></script>
	</p>
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
</body>
</html>
