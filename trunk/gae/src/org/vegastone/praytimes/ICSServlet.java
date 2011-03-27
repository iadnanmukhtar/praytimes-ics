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
		String location = req.getParameter("l");
		double x = new Double(req.getParameter("x"));
		double y = new Double(req.getParameter("y"));

		PrayTime prayerConfig = new PrayTime();
		ArrayList<String> prayerNames = prayerConfig.getTimeNames();
		prayerConfig.setCalcMethod(new Integer(req.getParameter("s")));
		prayerConfig.setAsrJuristic(new Integer(req.getParameter("j")));
		prayerConfig.setTimeFormat(0);
		int[] offsets = { 0, 0, 0, 0, 0, 0, 0 };
		prayerConfig.tune(offsets);

		resp.setContentType("text/calendar");
		resp.addHeader("Content-disposition", "attachment; filename=" + location + ".ics");
		PrintWriter out = resp.getWriter();
		out.println("BEGIN:VCALENDAR");
		out.println("VERSION:2.0");

		Calendar cal = Calendar.getInstance();
		final int year = cal.get(Calendar.YEAR);
		cal.set(year, 0, 1, 0, 0, 0);
		while (cal.get(Calendar.YEAR) == year) {
			ArrayList<String> prayerTimes = prayerConfig.getPrayerTimes(cal, x,
					y, 0.0);
			int i = 0;
			for (String time : prayerTimes) {
				if (i != 1 && i != 4)
					printEvent(out, location, prayerNames.get(i), cal, time);
				i++;
			}
			cal.add(Calendar.DAY_OF_MONTH, 1);
			break;
		}

		out.println("END:VCALENDAR");
	}

	private void printEvent(PrintWriter out, final String location,
			final String prayerName, final Calendar cal, final String prayerTime) {
		String[] t = prayerTime.split(":");
		String dt = String.format("%1$tY%1$tm%1$tdT%2$s%3$s00Z", cal, t[0],
				t[1]);
		out.println("BEGIN:VEVENT");
		out.println("SUMMARY:" + prayerName);
		out.println("DTSTART:" + dt);
		out.println("DURATION:PT5M");
		out.println("RRULE:FREQ=YEARLY;INTERVAL=1");
		out.println("LOCATION:" + location);
		out.println("CLASS:PUBLIC");
		out.println("TRANSP:TRANSPARENT");
		out.println("BEGIN:VALARM");
		out.println("TRIGGER:-PT0M");
		out.println("ACTION:DISPLAY");
		out.println("DESCRIPTION:Reminder");
		out.println("END:VALARM");
		out.println("END:VEVENT");
	}

}
