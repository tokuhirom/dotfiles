#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import datetime
import caldav
from caldav.elements import dav, cdav
from caldav.lib.namespace import ns
import sys
import os
import re
import requests
import pytz
import json
import subprocess

# security add-generic-password -s ncsical -a JP11283 -w '<ICAL_URL>'

class CaldavNotifier:
    def __init__(self, url):
        self.url = url

    def notify(self, date_start, date_end, calendar_prefix):
        client = caldav.DAVClient(url)
        principal = client.principal()

        calendars = principal.calendars()
        # First calendar is primary calendar(maybe).
        if calendar_prefix:
            calendars = [calendar
                        for calendar in calendars
                        if calendar.get_properties([dav.DisplayName(),])['{DAV:}displayname'].startswith(calendar_prefix) ]

        for calendar in calendars:
            # print("Processing calendar: %s" % calendar.get_properties([dav.DisplayName(),]))
            # print("%s - %s" % (date_start, date_end))
            events = calendar.date_search(date_start, date_end)
            events.sort(key=lambda x: x.instance.vevent.dtstart.value)

            for event in events:
                if self.should_skip(event):
                    continue

                title, time, message = self.format(event)
                print("%s\t%s\0%s" % (time, title, json.dumps(message)))

    def should_skip(self, event):
        if event.instance.vevent.summary.value=='予定有り':
            return True
        return False

    def format(self, event):
        # print("DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD")
        # print(event.instance)
        # print("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM")
        # 繰り返し予定の場合、日付がずれて表示されることがあるが、時間帯はあってるのでよしとする
        title = event.instance.vevent.summary.value
        time = self.truncate_date(event.instance.vevent.dtstart.value) + "~" + self.truncate_date(event.instance.vevent.dtend.value)
        
        result = ""

        if hasattr(event.instance.vevent, 'organizer') and hasattr(event.instance.vevent.organizer.params, 'CN') and event.instance.vevent.organizer.value != '':
            result += "Organized by " + event.instance.vevent.organizer.params['CN'][0]

        attendees = ', '.join([x.params['CN'][0] for x in event.instance.vevent.getChildren() if x.name == 'ATTENDEE' and hasattr(x.params, 'CN')])
        if attendees != '':
            result += ' with ' + attendees
        if hasattr(event.instance.vevent, 'location') and event.instance.vevent.location.value != '':
            result += ' at ' + event.instance.vevent.location.value
        if hasattr(event.instance.vevent, 'description') and event.instance.vevent.description.value != '':
            result += "\n\n"
            result += event.instance.vevent.description.value + "\n"
        return (title, time, result)

    def truncate_date(self, date):
        if isinstance(date, datetime.datetime):
            return date.strftime("%m-%d %H:%M")
        else:
            return date

if __name__ == '__main__':
    url = subprocess.check_output('security find-generic-password -gs ncsical -w', shell=True).decode('utf-8').replace("\n", '')

    if len(sys.argv) != 2:
        print("Usage: python ical2howm.py calendar_prefix")
        sys.exit(1)

    calendar_prefix = sys.argv[1]

    notifier = CaldavNotifier(url)
    since = datetime.datetime.now() - datetime.timedelta(days=1)
    until = since + datetime.timedelta(days=1)
    notifier.notify(since, until, calendar_prefix)

