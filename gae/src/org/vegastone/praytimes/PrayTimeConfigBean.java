package org.vegastone.praytimes;

import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;

public class PrayTimeConfigBean extends PrayTime {

	private String location;
	private double x;
	private double y;
	private int z;
	private int offset;
	private boolean hasCookie = false;

	public PrayTimeConfigBean(String location, double x, double y, int z,
			int offset, int s, int j) {
		construct(location, x, y, z, offset, s, j);
	}

	public PrayTimeConfigBean(HttpServletRequest request) {
		int s = 0;
		int j = 0;
		if (StringUtils.isNotBlank(request.getQueryString())
				|| request.getMethod().toUpperCase().equals("POST")) {
			location = getParameter(request, "l", "");
			if (StringUtils.endsWith(request.getServletPath(), ".ics")) {
				location = request.getServletPath();
				location = StringUtils.substring(location, 1,
						location.length() - 4);
			}
			x = new Double(getParameter(request, "x", "0"));
			y = new Double(getParameter(request, "y", "0"));
			z = new Integer(getParameter(request, "z", "0"));
			offset = new Integer(getParameter(request, "o", "0"));
			s = new Integer(getParameter(request, "s", "2"));
			j = new Integer(getParameter(request, "j", "0"));
		} else {
			Cookie[] cookies = request.getCookies();
			if (!ArrayUtils.isEmpty(cookies)) {
				for (Cookie cookie : cookies) {
					if (cookie.getName().equals("CONFIG")) {
						try {
							String[] pairs = cookie.getValue().split("#");
							for (String pair : pairs) {
								String[] tokens = pair.split(":");
								if (tokens[0].equals("l"))
									location = tokens[1];
								else if (tokens[0].equals("x"))
									x = new Double(tokens[1]);
								else if (tokens[0].equals("y"))
									y = new Double(tokens[1]);
								else if (tokens[0].equals("z"))
									z = new Integer(tokens[1]);
								else if (tokens[0].equals("s"))
									s = new Integer(tokens[1]);
								else if (tokens[0].equals("j"))
									j = new Integer(tokens[1]);
							}
							hasCookie = true;
						} catch (Exception e) {
							e.printStackTrace();
						}
					}
				}
			}
		}
		construct(location, x, y, z, offset, s, j);
	}

	private void construct(String location, double x, double y, int z,
			int offset, int s, int j) {
		this.location = location;
		this.x = x;
		this.y = y;
		this.z = z;
		this.offset = offset;
		setFajrIshaMethod(s);
		setAsrMethod(j);
		setTimeFormat(0);
		int[] offsets = { 0, 0, 0, 0, 0, 0, 0 };
		tune(offsets);
	}

	public boolean hasCookie() {
		return hasCookie;
	}

	public String getLocation() {
		if (location != null
				&& (location.equals("null") || location.trim().equals("")))
			location = null;
		return location;
	}

	public void setLocation(String name) {
		this.location = name;
	}

	public double getX() {
		return x;
	}

	public void setX(double x) {
		this.x = x;
	}

	public double getY() {
		return y;
	}

	public void setY(double y) {
		this.y = y;
	}

	public int getZ() {
		return z;
	}

	public void setZ(int z) {
		this.z = z;
	}

	public int getOffset() {
		return offset;
	}

	public int getFajrIshaMethod() {
		return getCalcMethod();
	}

	public void setFajrIshaMethod(int fajrIshaMethod) {
		setCalcMethod(fajrIshaMethod);
	}

	public int getAsrMethod() {
		return getAsrJuristic();
	}

	public void setAsrMethod(int asrMethod) {
		setAsrJuristic(asrMethod);
	}

	public String getCalendarFeed() throws Exception {
		String l = getLocation();
		if (l == null)
			l = "";
		l = URLEncoder.encode(l, "UTF-8");
		l = StringUtils.replace(l, "+", "%20");
		return new StringBuilder("/").append(l).append(".ics?").append("x=")
				.append(getX()).append("&y=").append(getY()).append("&z=")
				.append(getZ()).append("&s=").append(getFajrIshaMethod())
				.append("&j=").append(getAsrMethod()).toString();
	}

	public void addCookie(HttpServletResponse response) {
		StringBuilder cookieValue = new StringBuilder();
		cookieValue.append("l:").append(location).append('#');
		cookieValue.append("x:").append(x).append('#');
		cookieValue.append("y:").append(y).append('#');
		cookieValue.append("z:").append(z).append('#');
		cookieValue.append("s:").append(getFajrIshaMethod()).append('#');
		cookieValue.append("j:").append(getAsrMethod());
		Cookie cookie = new Cookie("CONFIG", cookieValue.toString());
		cookie.setMaxAge(6 * 30 * 24 * 60 * 60);
		response.addCookie(cookie);
	}

	private String getParameter(HttpServletRequest request, String name,
			String defaultValue) {
		String value = request.getParameter(name);
		if (StringUtils.isBlank(value))
			value = defaultValue;
		return value;
	}

}
