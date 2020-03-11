#!/usr/bin/env perl
# STDIN から読んで、howm 形式のファイルとして書いて、emacsclient 起動する。
use strict;
use warnings;
use utf8;
use 5.010000;
use autodie;
use Time::Piece;
use File::Path qw/make_path/;
use File::Basename qw/dirname/;
use Getopt::Long;
use JSON::PP;

GetOptions(
    'json' => \my $json,
);

my $in = join '', <STDIN>;
die "Missing input" unless $in;
if ($json) {
    $in = JSON::PP->new->allow_nonref(1)->decode($in);
}

my $fname = localtime->strftime("$ENV{HOME}/howm/%Y/%m/%Y-%m-%d-%H%M%S.md");
make_path(dirname($fname));

open my $fh, '>:utf8', $fname;
print {$fh} $in;
close $fh;

exec 'code', '-r', "$ENV{HOME}/howm/", $fname;

