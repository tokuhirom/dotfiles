#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use 5.010000;
use autodie;

my @s = (
    (map { linegw($_) } (
        # user-stickers
        'batch101.user-stickers.line.xen',
        'dev101.user-stickers.line.xen',
        'batch102.user-stickers.line.xen',
        'dbm201.user-stickers.line',
        'dbs201.user-stickers.line',
        'www101.user-stickers.line.xen',
        'www102.user-stickers.line.xen',
        'www103.user-stickers.line.xen',
        "www104.user-stickers.line.xen",
        'dbm.user-stickers.line.pdns',
        'www101.stats.user-stickers.line.xen',
        'www102.stats.user-stickers.line.xen',
        'dbm101.stats.user-stickers.line',
        'dbs101.stats.user-stickers.line',
        'dbm.stats.user-stickers.line.pdns',
    )),
    (map { ldg($_) } (
        # feedroll
        "dev101.feedroll.xen",
        "batch101.feedroll.xen",
        "dbs101.feedroll",
        "www102.webhook.reader.xen",
        "dev101.loctouch.xen",

        # folkat
        "batch02.loctouch",
        "dev02.loctouch.xen",

        # manga
        "dev101.manga.line.xen",
        "batch101.manga.line.xen",
        "dbs101.manga.line",
        "search101.manga.line.xen",
        "search102.manga.line.xen",

        'dbm201.fortune.line',
        'dbm202.manga.line',

        # reader
        'www102.webhook.reader.xen',
        'www101.favicon.reader.xen',
        )),
    (map { rlogin(@$_) } (
        # schedule(ITSC)
        ['dev101.schedule.line.vm', 'VLSCHAE1501'],
        ['dev101.taxi.line.vm', 'VFTXIAE1501'],
        )),
    ['login1.line.livedoor.net', 'ssh login1.line.livedoor.net'],
    ['kerberos1.linecorp.com', 'ssh kerberos1.linecorp.com'],
);
# ssh -t login1.line.livedoor.net sudo ssh batch101.user-stickers.line.xen

for (@s) {
    print join("\0", @$_) . "\n";
}
exit;

sub linegw {
    my ($host) = @_;
    my $cmd = "ssh -t -l tokuhirom tokuhirom\@kerberos1.linecorp.com ssh -t login1.line.livedoor.net sudo ssh " . $host;
    return [$host, $cmd];
}

sub ldg {
    my ($host) = @_;
    my $cmd = "ssh -t -l tokuhirom kerberos1.linecorp.com ssh -t root\@ldg101.admin.xen.livedoor ssh " . $host;
    return [$host, $cmd];
}

sub rlogin {
    my ($dev3name, $host) = @_;
    # ssh kerberos1.linecorp.com -t 'kinit < .pw && rlogin -l irteamsu VFTXIBE1501'
    my $cmd = qq!ssh -l tokuhirom kerberos1.linecorp.com -t 'kinit < .pw && rlogin -l irteamsu $host'!;
    return [$dev3name, $cmd];
}
