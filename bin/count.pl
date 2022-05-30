#!/usr/bin/env perl
use strict;
use warnings;

use autodie;
use File::Zglob qw/zglob/;

for my $ext (qw/kt java/) {
    my $lines = 0;
    for my $file (zglob("**/src/main/**/*.${ext}")) {
        open my $fh, '<', $file;
        $lines++ while <$fh>;
        close $fh;
    }
    print "$ext\t$lines\n";
}
