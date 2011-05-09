package org.vegastone.praytimes;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.fortuna.ical4j.model.property.CalScale;
import net.fortuna.ical4j.model.property.Method;
import net.fortuna.ical4j.model.property.ProdId;
import net.fortuna.ical4j.model.property.Version;
import net.fortuna.ical4j.model.property.XProperty;

@SuppressWarnings("serial")
public class ICSServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {

		PrayTimeConfigBean prayerConfig = new PrayTimeConfigBean(req);
		ArrayList<String> prayerNames = prayerConfig.getTimeNames();

		net.fortuna.ical4j.model.Calendar ics = new net.fortuna.ical4j.model.Calendar();
		ics.getProperties().add(
				new ProdId("-//vegaSTONE//Pray Times ICS 1.0//EN"));
		ics.getProperties().add(Version.VERSION_2_0);
		ics.getProperties().add(CalScale.GREGORIAN);
		ics.getProperties().add(Method.PUBLISH);
		StringBuilder s = new StringBuilder("Prayer Times for "
				+ prayerConfig.getLocation());
		ics.getProperties().add(new XProperty("X-WR-CALNAME", s.toString()));
		s.append("; Fajr/Isha Method: ");
		switch (prayerConfig.getFajrIshaMethod()) {
		case 0:
			s.append("Ithna Ashari");
			break;
		case 1:
			s.append("University of Islamic Sciences, Karachi");
			break;
		case 2:
			s.append("Islamic Society of North America (ISNA)");
			break;
		case 3:
			s.append("Muslim World League (MWL)");
			break;
		case 4:
			s.append("Umm al-Qura, Makkah");
			break;
		case 5:
			s.append("Egyptian General Authority of Survey");
			break;
		case 6:
			s.append("Institute of Geophysics, University of Tehran");
			break;
		case 7:
			s.append("Custom");
			break;
		default:
			s.append("Unknown");
			break;
		}
		s.append('\n');
		ics.getProperties().add(new XProperty("X-WR-CALDESC", s.toString()));

		for (Calendar date : new CalendarIterator()) {
			ArrayList<String> prayerTimes = prayerConfig.getPrayerTimes(date,
					prayerConfig.getX(), prayerConfig.getY(), 0.0);
			int i = 0;
			for (String time : prayerTimes) {
				if (i != 1 && i != 4)
					try {
						ics.getComponents().add(
								(new PrayEvent(prayerConfig,
										prayerNames.get(i), date, time)
										.toEvent()));
					} catch (Exception e) {
						throw new IOException(e);
					}
				i++;
			}
		}

		resp.setContentType("text/calendar; charset=UTF-8");
		PrintWriter out = resp.getWriter();
		out.write(ics.toString());
	}
}
