#!/usr/bin/perl
use strict;
use warnings;
use JSON::PP qw/decode_json/;


sub DEBUGGING() { 0 }


my $reversed = 0;
if (@ARGV == 1 && $ARGV[0] eq '-r') {
    $reversed = 1;
}

my $json = `yabai -m query --windows --space`;
my @dat = @{decode_json($json)};
my @sorted = sort {
    $a->{'is-floating'} <=> $b->{'is-floating'}
    || $a->{'frame'}{x} <=> $b->{'frame'}{x}
    || $a->{'frame'}{y} <=> $b->{'frame'}{y}
    || $a->{'frame'}{w} <=> $b->{'frame'}{w}
    || $a->{'frame'}{h} <=> $b->{'frame'}{h}
    || $a->{'id'} <=> $b->{'id'}
} @dat;
my $prev_is_focused = 0;
my @targets = 0..@sorted-1;
if ($reversed) {
    @targets = reverse @targets;
}
for my $i (@targets) {
    if ($prev_is_focused != 0) {
        focus($sorted[$i]->{id});
        exit 0;
    }
    if ($sorted[$i]->{'has-focus'}) {
        print("@{[ $sorted[$i]->{app} ]} has focus\n") if DEBUGGING;
        $prev_is_focused++;
    }
}
focus($sorted[$reversed ? -1 : 0]->{id});
exit 0;

sub focus {
    my $id = shift;
    # print("YABAIi: $id\n");
    system("yabai -m window --focus $id");
}
