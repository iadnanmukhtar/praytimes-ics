package org.vegastone.praytimes;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
public class ICSServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		PrayTimeConfigBean prayerConfig = new PrayTimeConfigBean(req);
		ArrayList<String> prayerNames = prayerConfig.getTimeNames();

		resp.setContentType("text/calendar");
		resp.addHeader("Content-disposition", "attachment; filename="
				+ prayerConfig.getLocation() + ".ics");
		PrintWriter out = resp.getWriter();
		out.println("BEGIN:VCALENDAR");
		out.println("VERSION:2.0");
		out.println("PRODID:-//vegaSTONE//Pray Times ICS 1.0//EN");
		out.println("CALSCALE:GREGORIAN");
		out.println("METHOD:PUBLISH");

		for (Calendar date : new CalendarIterator()) {
			ArrayList<String> prayerTimes = prayerConfig.getPrayerTimes(date,
					prayerConfig.getX(), prayerConfig.getY(), 0.0);
			int i = 0;
			for (String time : prayerTimes) {
				if (i != 1 && i != 4)
					try {
						out.print(new PrayEvent(prayerConfig, prayerNames
								.get(i), date, time));
					} catch (Exception e) {
						throw new IOException(e);
					}
				i++;
			}
		}

		out.println("END:VCALENDAR");
	}

}
