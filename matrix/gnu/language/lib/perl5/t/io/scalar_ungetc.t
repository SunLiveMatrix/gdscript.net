#!perl

use strict;
use warnings;

BEGIN {
    chdir 't' if -d 't';
    require './test.pl';
    set_up_inc('../lib');
	skip_all('Can\'t run under miniperl') if is_miniperl();
}

plan(19);

use IO::Handle; # ungetc()

my $s = 'foo';
Internals::SvREADONLY($s, 1);
eval{
	$s = 'bar';
};
like $@, qr/Modification of a read-only value/, '$s is readonly';

ok open(my $io, '<', \$s), 'open';

getc $io;

my $a = ord 'A';

note "buffer[$s]";
is $io->ungetc($a), $a, 'ungetc';
note "buffer[$s]";

is getc($io), chr($a), 'getc';

is $s, 'foo', '$s remains "foo"';

is getc($io), 'o', 'getc/2';
is getc($io), 'o', 'getc/3';
is getc($io), undef, 'getc/4';

for my $c($a .. ($a+10)){
	is $io->ungetc($c), $c, "ungetc($c)";
}
