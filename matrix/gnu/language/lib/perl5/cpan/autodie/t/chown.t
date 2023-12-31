#!/usr/bin/perl -w
use strict;
use Test::More;
use constant NO_SUCH_FILE => "this_file_had_better_not_exist";
use autodie;
use File::Temp qw(tempfile);

if ($^O eq 'MSWin32') {
    plan skip_all => 'chown() seems to always succeed on Windows';
}

plan tests => 4;

eval {
    chown(1234, 1234, NO_SUCH_FILE);
};

isa_ok($@, 'autodie::exception', 'exception thrown for chown');

# Chown returns the number of files that we chowned. So really we
# should die if the return value is not equal to the number of arguments
# minus two.

my ($fh, $filename) = tempfile;

eval { chown($<, -1, $filename); };
ok(! $@, "Can chown a file we own just fine.");

eval { chown($<, -1, $filename, NO_SUCH_FILE); };
isa_ok($@, 'autodie::exception', "Exception if ANY file changemode fails");
is($@->return, 1, "Confirm we're dying on a 'true' chown failure.");
