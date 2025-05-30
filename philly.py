#!/usr/bin/python2
# -*- coding: utf-8 -*-
#----------------------------------------------------------------------------
#
#      Purpose: Philly weather data
#
#----------------------------------------------------------------------------
#
#	City info
#
#----------------------------------------------------------------------------
lat = "39.96"
lon = "-75.16"
city = "philly"
bcity = "Philly"
shour = 13
rstring = 'T13:00:00-04:00'
#----------------------------------------------------------------------------
#
#	Libraries
#
#----------------------------------------------------------------------------
import datetime
import urllib2
#----------------------------------------------------------------------------
#
#	Variables
#
#----------------------------------------------------------------------------
hiflag = 0      #Heat index flag
dates = []	#Days
humiditys = []	#Humidity
temps = []	#Temperature
heats = []	#Heat index
precips = []	#Chance of precipitation
peaks = []	#Peak temperature
ptimes = []	#Peak hour
#----------------------------------------------------------------------------
#
#	Web info
#
#----------------------------------------------------------------------------
url = 'http://forecast.weather.gov/MapClick.php?lat=' + lat + '&lon=' + lon + '&FcstType=digitalDWML'
webpage = './' + city + '.html'
#----------------------------------------------------------------------------
#
#	Start time
#
#----------------------------------------------------------------------------
d = datetime.datetime.now()
start = d.strftime("%Y-%m-%d") + rstring
#----------------------------------------------------------------------------
#
#	Get Peak function
#
#----------------------------------------------------------------------------
def get_peak(temps):
	ptime = shour
	peak = temps[s]
	if temps[s + 1] > peak:
		peak = temps[s + 1]
		ptime = ptime + 1
	if temps[s + 2] > peak:
		peak = temps[s + 2]
		ptime = ptime + 1
	if temps[s + 3] > peak:
		peak = temps[s + 3]
		ptime = ptime + 1
	if temps[s + 4] > peak:
		peak = temps[s + 4]
		ptime = ptime + 1
	if temps[s + 5] > peak:
		peak = temps[s + 5]
		ptime = ptime + 1
	if temps[s + 6] > peak:
		peak = temps[s + 6]
		ptime = ptime + 1
	peaks.append(peak)
	ptimes.append(str(ptime))
#----------------------------------------------------------------------------
#
#	Header
#
#----------------------------------------------------------------------------
web = open(webpage, 'w')
web.write("<html>\n<head>\n<META HTTP-EQUIV=refresh CONTENT=15>\n<title>Hourly Weather Forecast</title>\n</head>\n<body bgcolor=#ffffff>\n <center>\n")
web.write("<h1>" + bcity + ":" + lat + " " + lon + " Hourly Forecast</h1>\n<table border=1 cellpadding=4>\n")
#----------------------------------------------------------------------------
#
#	Get data
#
#----------------------------------------------------------------------------
response = urllib2.urlopen(url)
#response = urlopen(url)
weather = response.readlines()
for line in weather:
	line = " ".join(line.split())
	if 'start-valid-time' in line:
		adata = line.split(">")
		bdata = adata[1].split("<")
		dates.append(bdata[0])
	if 'humidity' in line:
		adata = []
		adata = line.split(">")
		for i in range(1,168):
			j = 2 * i
			temp = adata[j].replace('</value','')
			humiditys.append(temp)
	if 'temperature' in line and 'hourly' in line:
		adata = []
		adata = line.split(">")
		for i in range(1,168):
			j = 2 * i
			temp = adata[j].replace('</value','')
			temps.append(temp)
#----------------------------------------------------------------------------
#
#	If there's no heat index info
#
#----------------------------------------------------------------------------
if not hiflag:
	for i in range(0,167):
		heats.append('<br>')
#----------------------------------------------------------------------------
#
#	Find start time
#	's' is variable
#	'k' is static
#
#----------------------------------------------------------------------------
for i in range(0,24):
	if dates[i] == start:
		s = i
		k = i
#----------------------------------------------------------------------------
#
#	Print data - day 1
#
#----------------------------------------------------------------------------
web.write("<tr><td bgcolor=cccccc>" + dates[s].replace(rstring,'') + "</td><td>" + str(shour) + ":00</td><td>" + str(shour + 1) + ":00</td><td>" + str(shour + 2) + ":00</td><td>" + str(shour + 3) + ":00</td><td>" + str(shour + 4) + ":00</td><td>" + str(shour + 5) + ":00</td><td>" + str(shour + 6) + ":00</td></tr>")
web.write("<tr><td>Temperature</td><td>" + temps[s] + "</td><td>" + temps[s + 1] + "</td><td>" + temps[s + 2] + "</td><td>" + temps[s + 3] + "</td><td>" + temps[s + 4] + "</td><td>" + temps[s + 5] + "</td><td>" + temps[s + 6] + "</td></tr>")
web.write("<tr><td>Humidity</td><td>" + humiditys[s] + "</td><td>" + humiditys[s + 1] + "</td><td>" + humiditys[s + 2] + "</td><td>" + humiditys[s + 3] + "</td><td>" + humiditys[s + 4] + "</td><td>" + humiditys[s + 5] + "</td><td>" + humiditys[s + 6] + "</td></tr>")
get_peak(temps)
#----------------------------------------------------------------------------
#
#	Print data - day 2
#
#----------------------------------------------------------------------------
s = s + 24
web.write("<tr><td bgcolor=cccccc>" + dates[s].replace(rstring,'') + "</td><td>" + str(shour) + ":00</td><td>" + str(shour + 1) + ":00</td><td>" + str(shour + 2) + ":00</td><td>" + str(shour + 3) + ":00</td><td>" + str(shour + 4) + ":00</td><td>" + str(shour + 5) + ":00</td><td>" + str(shour + 6) + ":00</td></tr>")
web.write("<tr><td>Temperature</td><td>" + temps[s] + "</td><td>" + temps[s + 1] + "</td><td>" + temps[s + 2] + "</td><td>" + temps[s + 3] + "</td><td>" + temps[s + 4] + "</td><td>" + temps[s + 5] + "</td><td>" + temps[s + 6] + "</td></tr>")
web.write("<tr><td>Humidity</td><td>" + humiditys[s] + "</td><td>" + humiditys[s + 1] + "</td><td>" + humiditys[s + 2] + "</td><td>" + humiditys[s + 3] + "</td><td>" + humiditys[s + 4] + "</td><td>" + humiditys[s + 5] + "</td><td>" + humiditys[s + 6] + "</td></tr>")
get_peak(temps)
#----------------------------------------------------------------------------
#
#	Print data - day 3
#
#----------------------------------------------------------------------------
s = s + 24
web.write("<tr><td bgcolor=cccccc>" + dates[s].replace(rstring,'') + "</td><td>" + str(shour) + ":00</td><td>" + str(shour + 1) + ":00</td><td>" + str(shour + 2) + ":00</td><td>" + str(shour + 3) + ":00</td><td>" + str(shour + 4) + ":00</td><td>" + str(shour + 5) + ":00</td><td>" + str(shour + 6) + ":00</td></tr>")
web.write("<tr><td>Temperature</td><td>" + temps[s] + "</td><td>" + temps[s + 1] + "</td><td>" + temps[s + 2] + "</td><td>" + temps[s + 3] + "</td><td>" + temps[s + 4] + "</td><td>" + temps[s + 5] + "</td><td>" + temps[s + 6] + "</td></tr>")
web.write("<tr><td>Humidity</td><td>" + humiditys[s] + "</td><td>" + humiditys[s + 1] + "</td><td>" + humiditys[s + 2] + "</td><td>" + humiditys[s + 3] + "</td><td>" + humiditys[s + 4] + "</td><td>" + humiditys[s + 5] + "</td><td>" + humiditys[s + 6] + "</td></tr>")
get_peak(temps)
#----------------------------------------------------------------------------
#
#	Print data - day 4
#
#----------------------------------------------------------------------------
s = s + 24
web.write("<tr><td bgcolor=cccccc>" + dates[s].replace(rstring,'') + "</td><td>" + str(shour) + ":00</td><td>" + str(shour + 1) + ":00</td><td>" + str(shour + 2) + ":00</td><td>" + str(shour + 3) + ":00</td><td>" + str(shour + 4) + ":00</td><td>" + str(shour + 5) + ":00</td><td>" + str(shour + 6) + ":00</td></tr>")
web.write("<tr><td>Temperature</td><td>" + temps[s] + "</td><td>" + temps[s + 1] + "</td><td>" + temps[s + 2] + "</td><td>" + temps[s + 3] + "</td><td>" + temps[s + 4] + "</td><td>" + temps[s + 5] + "</td><td>" + temps[s + 6] + "</td></tr>")
web.write("<tr><td>Humidity</td><td>" + humiditys[s] + "</td><td>" + humiditys[s + 1] + "</td><td>" + humiditys[s + 2] + "</td><td>" + humiditys[s + 3] + "</td><td>" + humiditys[s + 4] + "</td><td>" + humiditys[s + 5] + "</td><td>" + humiditys[s + 6] + "</td></tr>")
get_peak(temps)
#----------------------------------------------------------------------------
#
#	Print data - day 5
#
#----------------------------------------------------------------------------
s = s + 24
web.write("<tr><td bgcolor=cccccc>" + dates[s].replace(rstring,'') + "</td><td>" + str(shour) + ":00</td><td>" + str(shour + 1) + ":00</td><td>" + str(shour + 2) + ":00</td><td>" + str(shour + 3) + ":00</td><td>" + str(shour + 4) + ":00</td><td>" + str(shour + 5) + ":00</td><td>" + str(shour + 6) + ":00</td></tr>")
web.write("<tr><td>Temperature</td><td>" + temps[s] + "</td><td>" + temps[s + 1] + "</td><td>" + temps[s + 2] + "</td><td>" + temps[s + 3] + "</td><td>" + temps[s + 4] + "</td><td>" + temps[s + 5] + "</td><td>" + temps[s + 6] + "</td></tr>")
web.write("<tr><td>Humidity</td><td>" + humiditys[s] + "</td><td>" + humiditys[s + 1] + "</td><td>" + humiditys[s + 2] + "</td><td>" + humiditys[s + 3] + "</td><td>" + humiditys[s + 4] + "</td><td>" + humiditys[s + 5] + "</td><td>" + humiditys[s + 6] + "</td></tr>")
get_peak(temps)
#----------------------------------------------------------------------------
#
#	Print data - day 6
#
#----------------------------------------------------------------------------
s = s + 24
web.write("<tr><td bgcolor=cccccc>" + dates[s].replace(rstring,'') + "</td><td>" + str(shour) + ":00</td><td>" + str(shour + 1) + ":00</td><td>" + str(shour + 2) + ":00</td><td>" + str(shour + 3) + ":00</td><td>" + str(shour + 4) + ":00</td><td>" + str(shour + 5) + ":00</td><td>" + str(shour + 6) + ":00</td></tr>")
web.write("<tr><td>Temperature</td><td>" + temps[s] + "</td><td>" + temps[s + 1] + "</td><td>" + temps[s + 2] + "</td><td>" + temps[s + 3] + "</td><td>" + temps[s + 4] + "</td><td>" + temps[s + 5] + "</td><td>" + temps[s + 6] + "</td></tr>")
web.write("<tr><td>Humidity</td><td>" + humiditys[s] + "</td><td>" + humiditys[s + 1] + "</td><td>" + humiditys[s + 2] + "</td><td>" + humiditys[s + 3] + "</td><td>" + humiditys[s + 4] + "</td><td>" + humiditys[s + 5] + "</td><td>" + humiditys[s + 6] + "</td></tr>")
get_peak(temps)
#----------------------------------------------------------------------------
#
#	Print data - day 7
#
#----------------------------------------------------------------------------
s = s + 24
web.write("<tr><td bgcolor=cccccc>" + dates[s].replace(rstring,'') + "</td><td>" + str(shour) + ":00</td><td>" + str(shour + 1) + ":00</td><td>" + str(shour + 2) + ":00</td><td>" + str(shour + 3) + ":00</td><td>" + str(shour + 4) + ":00</td><td>" + str(shour + 5) + ":00</td><td>" + str(shour + 6) + ":00</td></tr>")
web.write("<tr><td>Temperature</td><td>" + temps[s] + "</td><td>" + temps[s + 1] + "</td><td>" + temps[s + 2] + "</td><td>" + temps[s + 3] + "</td><td>" + temps[s + 4] + "</td><td>" + temps[s + 5] + "</td><td>" + temps[s + 6] + "</td></tr>")
web.write("<tr><td>Humidity</td><td>" + humiditys[s] + "</td><td>" + humiditys[s + 1] + "</td><td>" + humiditys[s + 2] + "</td><td>" + humiditys[s + 3] + "</td><td>" + humiditys[s + 4] + "</td><td>" + humiditys[s + 5] + "</td><td>" + humiditys[s + 6] + "</td></tr>")
get_peak(temps)
#----------------------------------------------------------------------------
#
#	Today's Temperatures
#
#----------------------------------------------------------------------------
web.write("</table>\n")
web.write("<h1>" + bcity + " Temperature Forecast</h1>\n<h1>for " + dates[k].replace(rstring,'') + "</h1>\n")
web.write("<table border=1 cellpadding=4>\n")
web.write("<tr><td>HE" + str(shour) + "</td><td>" + temps[k] + "</td></tr>\n<tr><td>HE" + str(shour + 1) + "</td><td>" + temps[k + 1] + "</td></tr>\n<tr><td>HE" + str(shour + 2) + "</td><td>" + temps[k + 2] + "</td></tr>\n<tr><td>HE" + str(shour + 3) + "</td><td>" + temps[k + 3] + "</td></tr>\n<tr><td>HE" + str(shour + 4) + "</td><td>" + temps[k + 4] + "</td></tr>\n<tr><td>HE" + str(shour + 5) + "</td><td>" + temps[k + 5] + "</td></tr>\n<tr><td>HE"+ str(shour + 6) + "</td><td>" + temps[k + 6] + "</td></tr>\n</table>")
#----------------------------------------------------------------------------
#
#	Week's Peak Temperatures
#
#----------------------------------------------------------------------------
web.write("<h1>" + bcity + " Peak Temperatures</h1>\n<table border=1 cellpadding=4")
web.write("<tr><td>" + dates[k].replace(rstring,'') + "</td><td>HE" + ptimes[0] + "</td><td>" + peaks[0] + "</td></tr>\n")
web.write("<tr><td>" + dates[k + 24].replace(rstring,'') + "</td><td>HE" + ptimes[1] + "</td><td>" + peaks[1] + "</td></tr>\n")
web.write("<tr><td>" + dates[k + 48].replace(rstring,'') + "</td><td>HE" + ptimes[2] + "</td><td>" + peaks[2] + "</td></tr>\n")
web.write("<tr><td>" + dates[k + 72].replace(rstring,'') + "</td><td>HE" + ptimes[3] + "</td><td>" + peaks[3] + "</td></tr>\n")
web.write("<tr><td>" + dates[k + 96].replace(rstring,'') + "</td><td>HE" + ptimes[4] + "</td><td>" + peaks[4] + "</td></tr>\n")
web.write("<tr><td>" + dates[k + 120].replace(rstring,'') + "</td><td>HE" + ptimes[5] + "</td><td>" + peaks[5] + "</td></tr>\n")
web.write("<tr><td>" + dates[k + 144].replace(rstring,'') + "</td><td>HE" + ptimes[6] + "</td><td>" + peaks[6] + "</td></tr>\n")
#----------------------------------------------------------------------------
#
#	Footer
#
#----------------------------------------------------------------------------
web.write("</table><br><br>\n</center>\n</body>\n</html>\n")
web.close

