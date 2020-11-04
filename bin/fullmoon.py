#!/usr/bin/python3
# -*- encoding: utf-8 -*-

# apt install python3-keyring python3-keyrings.alt openconnect
# pacman -S python-keyring python-keyrings-alt

import os
import os.path
from getpass import getpass
from configparser import SafeConfigParser
from os.path import expanduser
import logging
import urllib
import http.cookiejar as cookiejar
from html.parser import HTMLParser


class FormParser(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.form = {}
        self.field = {}

    def handle_starttag(self, tag, attrs):
        if tag == 'form':
            self.form = dict(attrs)
        if tag == 'input':
            attrs = dict(attrs)
            self.field[attrs['name']] = attrs


class Fullmoon:
    def __init__(self, duo=False):
        self.duo = duo
        self.logger = logging.getLogger(self.__class__.__name__)
        self.configfile = expanduser("~/.fullmoon.ini")
        self.config = SafeConfigParser()
        self.config.read(self.configfile)

        self.headers = {
            'User-Agent': 'User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux i686 on x86_64; rv:32.0) Gecko/20100101 Firefox/32.0',
        }
        self.cookiejar = cookiejar.LWPCookieJar()
        self.http_handler = urllib.request.HTTPCookieProcessor(self.cookiejar)
        self.urlopen = urllib.request.build_opener(self.http_handler)

        # bypass determination of browser step
        self.set_cookie('DSCheckBrowser', 'none')
        self.set_cookie('lastRealm', 'FullMoon_Realm')
        self.set_cookie('DSSIGNIN', 'url_1')
        self.set_cookie('DSSignInURL', '/fullmoon')

    def run(self):
        # self.top()

        (username, password) = self.username_and_password()
        self.login(username, password)

        otp = input('OTP Number: ')
        dsid = self.send_otp(otp)

        args = ["sudo", "/usr/bin/openconnect",
                "--protocol=nc",
                "-C", "DSID=%s" % (dsid),
                "nsa.navercorp.com"]

        self.logger.debug('will execute %s', args)

        os.execvp("sudo", args)

    def top(self):
        url = 'https://nsa.navercorp.com/fullmoon'
        req = urllib.request.Request(url, headers=self.headers)
        res = self.urlopen.open(req)
        self.headers['Referer'] = res.geturl()

    def login(self, username, password):
        self.logger.info('login start')
        form = {
            'username': username,
            'password': password,
            'realm':    'FullMoon_Realm'      # TODO: retrieve from <form>
        }
        # TODO: construct url from action of <form> and last url
        url = 'https://nsa.navercorp.com/dana-na/auth/url_1/login.cgi'
        req = urllib.request.Request(url,
                              data=urllib.parse.urlencode(form).encode('utf-8'),
                              headers=self.headers)
        self.logger.debug('will %s %s', req.get_method(), req.get_full_url())
        res = self.urlopen.open(req)
        self.headers['Referer'] = res.geturl()
        self.logger.debug('=> %s', res.geturl())

        parser = FormParser()
        parser.feed(res.read().decode('utf-8'))

        if 'key' not in parser.field:
            raise StandardError('wrong password (or user name)')

        self.key = parser.field['key']['value']
        self.username = parser.field['username']['value']
        self.logger.debug('key = %s', self.key)
        self.logger.debug('username = %s', self.username)

    def send_otp(self, otp):
        self.logger.info('send_otp start')
        form = {
            'username': self.username,
            'key':      self.key,
            'password': otp,
        }
        # TODO: construct url from action of <form> and last url
        url = 'https://nsa.navercorp.com/dana-na/auth/url_1/login.cgi'
        req = urllib.request.Request(url,
                              data=urllib.parse.urlencode(form).encode('utf-8'),
                              headers=self.headers)

        for i in range(1, 3):
            self.logger.debug('#%d: will %s %s', i,
                              req.get_method(), req.get_full_url())
            res = self.urlopen.open(req)
            self.headers['Referer'] = res.geturl()
            self.after_otp_url = res.geturl()

            res.read()

            dsid_cookie = self.find_cookie('DSID')
            if dsid_cookie is not None:
                self.dsid = dsid_cookie.value
                self.logger.debug('DSID = %s', self.dsid)
                return self.dsid

            # retry with DSPREAUTH
            req = urllib.request.Request(res.geturl(), headers=self.headers)

        self.logger.warn('Could not retrieve DSID. Gave up!')
        raise StandardError('Could not retrieve DSID')

    def username_and_password(self):
        username = self.get_username()
        password = self.get_password(username)
        return (username, password)

    def get_username(self):
        if self.config.has_option('DEFAULT', 'user'):
            user = self.config.get('DEFAULT', 'user')
            res = input('User name (default: %s): ' % user)
            if res:
                user = res
        else:
            user = input('User name: ')
        self.config.set('DEFAULT', 'user', user)
        with open(self.configfile, 'w') as configfile:
            self.config.write(configfile)

        return user

    def get_password(self, user):
        password = self.password_from_keyring(
            user) or self.password_from_getpass(user)
        return password

    def password_from_getpass(self, username):
        return getpass('Password: ')

    def password_from_keyring(self, username):
        try:
            import keyring
        except ImportError:
            return None

        password = keyring.get_password('fullmoon', username)
        if password:
            res = getpass('Password (empty for using keyring): ')
            if res:
                password = res
                keyring.set_password('fullmoon', username, password)
        else:
            password = getpass('Password: ')
            keyring.set_password('fullmoon', username, password)

        return password

    def set_cookie(self, name, value):
        c = cookiejar.Cookie(name=name, value=value,
                             domain='nsa.navercorp.com',
                             domain_specified=True,
                             domain_initial_dot=False,
                             port=None, port_specified=False,
                             path='/', path_specified=True,
                             secure=False, expires=None, discard=False,
                             comment=None, comment_url=None,
                             version=0, rest={})
        self.http_handler.cookiejar.set_cookie(c)

    def find_cookie(self, name):
        for index, cookie in enumerate(self.http_handler.cookiejar):
            if cookie.name == name:
                return cookie
        return None


if __name__ == '__main__':
    logging.basicConfig(level=logging.DEBUG)
    Fullmoon(duo=True).run()
