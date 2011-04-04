package org.vegastone.praytimes;

import java.util.Calendar;
import java.util.Iterator;

public class CalendarIterator implements Iterator<Calendar>, Iterable<Calendar> {

	private Calendar cal;
	private int year;

	public CalendarIterator() {
		cal = Calendar.getInstance();
		year = cal.get(Calendar.YEAR);
		cal.set(year, 0, 1, 0, 0, 0);
		cal.add(Calendar.DAY_OF_MONTH, -1);
	}

	public Calendar getCalendar() {
		return cal;
	}

	@Override
	public boolean hasNext() {
		return (cal.get(Calendar.YEAR) <= year);
	}

	@Override
	public Calendar next() {
		cal.add(Calendar.DAY_OF_MONTH, 1);
		return cal;
	}

	@Override
	public void remove() {
	}

	@Override
	public Iterator<Calendar> iterator() {
		return this;
	}

}
