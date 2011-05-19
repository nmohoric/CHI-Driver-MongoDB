#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'CHI::Driver::MongoDB' ) || print "Bail out!\n";
}

diag( "Testing CHI::Driver::MongoDB $CHI::Driver::MongoDB::VERSION, Perl $], $^X" );
