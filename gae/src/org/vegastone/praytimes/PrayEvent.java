package org.vegastone.praytimes;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class PrayEvent {

	public static final DateFormat ISO_DATE = new SimpleDateFormat(
			"yyyyMMdd'T'HHmmss'Z'");
	public static final DateFormat DATE = new SimpleDateFormat("MMM d, yyyy");
	public static final DateFormat TIME = new SimpleDateFormat("hh:mm a");

	private String location;
	private String name;
	private Calendar date;
	private String time;
	private Date isoDate;
	private String formattedDate;
	private String formattedTime;
	boolean reminder = true;

	public PrayEvent(PrayTimeConfigBean prayerConfig, String name, Calendar date, String time)
			throws ParseException {
		this.location = prayerConfig.getLocation();
		this.name = name;
		this.date = date;
		this.time = time;
		String[] t = time.split(":");
		String _isoDate = String.format("%1$tY%1$tm%1$tdT%2$s%3$s00Z", date,
				t[0], t[1]);
		isoDate = ISO_DATE.parse(_isoDate);
		Calendar localDate = Calendar.getInstance();
		localDate.setTime(isoDate);
		localDate.add(Calendar.MINUTE, prayerConfig.getZ());
		formattedDate = DATE.format(localDate.getTime());
		formattedTime = TIME.format(localDate.getTime()).toLowerCase();
	}

	public String getLocation() {
		return location;
	}

	public String getName() {
		return name;
	}

	public Calendar getDate() {
		return date;
	}

	public String getTime() {
		return time;
	}

	public Date getISODate() {
		return isoDate;
	}

	public String getFormattedDate() {
		return formattedDate;
	}

	public String getFormattedTime() {
		return formattedTime;
	}

	public void setReminder(boolean reminder) {
		this.reminder = reminder;
	}

	@Override
	public String toString() {
		StringBuilder s = new StringBuilder();
		s.append(attr("BEGIN", "VEVENT"));
		s.append(attr("SUMMARY", name));
		s.append(attr("DTSTART", ISO_DATE.format(isoDate)));
		s.append(attr("DURATION", "PT5M"));
		s.append(attr("RRULE", "FREQ=YEARLY"));
		s.append(attr("LOCATION", location));
		s.append(attr("CLASS", "PUBLIC"));
		s.append(attr("TRANSP", "TRANSPARENT"));
		s.append(attr("X-GOOGLE-CALENDAR-CONTENT-TITLE", name));
		// s.append(attr("X-GOOGLE-CALENDAR-CONTENT-ICON", ""));
		// s.append(attr("X-GOOGLE-CALENDAR-CONTENT-URL", ""));
		// s.append(attr("X-GOOGLE-CALENDAR-CONTENT-TYPE", "image/gif"));
		// s.append(attr("X-GOOGLE-CALENDAR-CONTENT-WIDTH", ""));
		// s.append(attr("X-GOOGLE-CALENDAR-CONTENT-HEIGHT", ""));
		if (reminder) {
			s.append(attr("BEGIN", "VALARM"));
			s.append(attr("TRIGGER", "-PT0M"));
			s.append(attr("ACTION", "DISPLAY"));
			s.append(attr("DESCRIPTION", "Reminder"));
			s.append(attr("END", "VALARM"));
		}
		s.append(attr("END", "VEVENT"));
		return s.toString();
	}

	private String attr(String name, String value) {
		return new StringBuilder(name).append(':').append(value).append('\n')
				.toString();
	}

}
