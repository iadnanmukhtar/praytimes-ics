package org.vegastone.praytimes;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

import net.fortuna.ical4j.model.Dur;
import net.fortuna.ical4j.model.Recur;
import net.fortuna.ical4j.model.component.VAlarm;
import net.fortuna.ical4j.model.component.VEvent;
import net.fortuna.ical4j.model.property.Action;
import net.fortuna.ical4j.model.property.Clazz;
import net.fortuna.ical4j.model.property.Location;
import net.fortuna.ical4j.model.property.RRule;
import net.fortuna.ical4j.model.property.Transp;
import net.fortuna.ical4j.model.property.XProperty;

public class PrayEvent {

	public static final DateFormat ISO_DATE = new SimpleDateFormat(
			"yyyyMMdd'T'HHmmss'Z'");
	public static final DateFormat DATE = new SimpleDateFormat("MMM d, yyyy");
	public static final DateFormat TIME = new SimpleDateFormat("hh:mm a");

	private String location;
	private String name;
	private Calendar date;
	private String time;
	private Date isoDateStart;
	private Date isoDateEnd;
	private String formattedDate;
	private String formattedTime;
	boolean reminder = true;

	public PrayEvent(PrayTimeConfigBean prayerConfig, String name,
			Calendar date, String time) throws ParseException {
		this.location = prayerConfig.getLocation();
		this.name = name;
		this.date = date;
		this.time = time;

		String[] t = time.split(":");
		String isoDateStartString = String.format(
				"%1$tY%1$tm%1$tdT%2$s%3$s00Z", date, t[0], t[1]);

		isoDateStart = ISO_DATE.parse(isoDateStartString);
		Calendar localDateStart = Calendar.getInstance();
		localDateStart.setTime(isoDateStart);
		localDateStart.add(Calendar.MINUTE, prayerConfig.getZ());
		formattedDate = DATE.format(localDateStart.getTime());
		formattedTime = TIME.format(localDateStart.getTime()).toLowerCase();

		Calendar isoCalEnd = Calendar.getInstance();
		isoCalEnd.setTime(isoDateStart);
		isoCalEnd.add(Calendar.MINUTE, 5);
		isoDateEnd = isoCalEnd.getTime();

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
		return isoDateStart;
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

	public VEvent toEvent() {
		VEvent event = new VEvent(new net.fortuna.ical4j.model.DateTime(
				isoDateStart.getTime()), new net.fortuna.ical4j.model.DateTime(
				isoDateEnd.getTime()), name);
		event.getStartDate().setUtc(true);
		event.getEndDate().setUtc(true);
		event.getProperties().add(new XProperty("UID", UUID.randomUUID().toString()));
		event.getProperties().add(new RRule(new Recur(Recur.YEARLY, 1)));
		event.getProperties().add(new Location(location));
		event.getProperties().add(Clazz.PUBLIC);
		event.getProperties().add(Transp.TRANSPARENT);
		event.getProperties().add(
				new XProperty("X-GOOGLE-CALENDAR-CONTENT-TITLE", name));
		if (reminder) {
			VAlarm alarm = new VAlarm(new Dur(0, 0, 0, 0));
			alarm.getProperties().add(Action.DISPLAY);
			event.getAlarms().add(alarm);
		}
		return event;
	}

}
