#!/usr/bin/env perl
use strict;
use warnings;

use FindBin;
use File::Spec;
use File::Copy;
use File::Path qw(make_path);

my $dir = File::Spec->basename($FindBin::RealBin);
my $report = File::Spec->catfile($FindBin::RealBin, 'REPORT.md');

# REPORT.md の存在確認
die "missing REPORT.md" unless -e $report;

# 出力先ディレクトリ
my $dest_dir = File::Spec->catdir(
    $ENV{HOME},
    'work',
    'analyzr',
    'ai-security-analysis',
    'sacloud',
    $dir
);

# ディレクトリ作成
make_path($dest_dir) or die "Failed to create directory $dest_dir: $!";

# ファイルコピー
copy($report, $dest_dir) or die "Failed to copy REPORT.md: $!";

print "Copied REPORT.md to $dest_dir\n";
