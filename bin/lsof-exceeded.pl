#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use 5.010000;
use autodie;
use Term::ANSIColor;
use Getopt::Long;
use Time::HiRes qw/sleep/;
use Pod::Usage;
use File::Path;
use Time::Piece;

my $sleep = 0.5;
GetOptions(
    's|sleep=i'  => \$sleep,
    'l|limit=i'  => \my $limit,
);

my $pattern = shift @ARGV or pod2usage;

while (1) {
    my $s = `pgrep -fl '$pattern'`;
    my %procs = map { split / /, $_, 2 } grep /\S/, split /\n/, $s;
    if (%procs) {
        for my $pid (sort keys %procs) {
            my $file_list = `lsof -p $pid`;
            my $n_files = count_lines($file_list);

            say "$pid($procs{$pid}): @{[ colored(['green'], $n_files) ]}";

            if (defined($limit) && $n_files > $limit) {
                print colored(['red'], $pid) . " is opening $n_files files($procs{$pid}).\n";

                my $outfile = localtime->strftime('%Y%m%d-%H%M%S') . "-dump-$pid.txt";
                open my $fh, '>', $outfile or die "cannot open '$outfile': $!";
                print {$fh} $file_list;
                close $fh;
                exit 1;
            }

            sleep($sleep);
        }
    } else {
        print "no procs\n";
    }
}

# count lines
sub count_lines {
    my $s = shift;
    return 0+(split /\n/, $s);
}

__END__

=head1 SYNOPSIS

    $ hoge.pl -s SLEEP -l LIMIT PATTERN

