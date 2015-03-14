# Pray Times ICS #

Pray Times ICS is a project aims at creating a Muslim five daily prayer time annual calendar in an iCalendar/ICS format for a given geographical location.

The calendar feeds from Pray Times ICS can be imported into or subscribed to from web or desktop calendars, such as Google Calendar, MS Outlook, Apple iCal etc., or be published.

Pray Times ICS is also a smart phone friendly web application that can be used to quickly lookup times for prayer on an iPhone, iPad, Android, Blackberry, or any HTML5 compliant browser.

Prayer time calculation code from [PrayTime.org](http://www.praytimes.org) is used within the application.

## Smart Phone Friendly Web Application ##

  * From your smart phone, go to http://praytimes-ics.appspot.com
  * Click on "Get Location" to update the latitude and longitude of your current location (desktop, laptop, or mobile phone).
  * Click "Done" to save settings and go back to the Main Screen.
  * Add a bookmark within your browser or add it to your home screen as an app shortcut.

## Links ##

  * **Web App:** http://praytimes-ics.appspot.com
  * **Facebook Page:** https://www.facebook.com/praytimesics
  * **Issues:** http://code.google.com/p/praytimes-ics/issues/list
  * [Some City Calendars](CityCalendars.md)

## iCalendar Feed URL ##
> http://praytimes-ics.appspot.com/location.ics?x=0.000&y=0.000&z=0&s=0&j=0

> where:
  * _location_ is the name of your location. Could be any name of your choosing.
  * _x_ is latitude
  * _y_ is longitude
  * _z_ is the UTC time zone offset in minutes. For example US Eastern Standard is -4 hours or -240 minutes.
  * _s_ is a pre-defined setting (0 through 6) for Fajr/Isha angles. For example 2 is for ISNA (Islamic Society of North America). See app website for other options.
  * _j_ is a pre-defined setting (0 or 1) for Asr calculation method. 0 is for Standard (Shafi'ee, Hanbali, Maliki). 1 is for Hanafi.

> Example: http://praytimes-ics.appspot.com/Buford%2C%20GA.ics?x=34.126&y=-84.004&z=-240&s=2&j=0

## Google Calendar Publishing ##
  * [Subscribe to calendars in Google Calendar](http://www.google.com/support/calendar/bin/answer.py?answer=37100)
  * [Import events from iCalendar or CSV files](http://www.google.com/support/calendar/bin/answer.py?answer=37118)
  * [Share your calendar with the world](http://www.google.com/support/calendar/bin/answer.py?answer=37083)