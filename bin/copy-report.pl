#!/usr/bin/env perl
use strict;
use warnings;

use File::Spec;
use File::Copy;
use File::Path qw(make_path);
use File::Basename;

my $cwd = File::Spec->rel2abs(File::Spec->curdir());
my $dir = basename($cwd);
my $report = File::Spec->catfile($cwd, 'REPORT.md');

# REPORT.md の存在確認
die "missing $report" unless -e $report;

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
make_path($dest_dir) unless -d $dest_dir;
die "Failed to create directory $dest_dir" unless -d $dest_dir;

# ファイルコピー
copy($report, $dest_dir) or die "Failed to copy REPORT.md: $!";

print "Copied REPORT.md to $dest_dir\n";
