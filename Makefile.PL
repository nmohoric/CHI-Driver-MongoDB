use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'CHI::Driver::MongoDB',
    AUTHOR              => q{Nick Mohoric <nick.mohoric@gmail.com>},
    VERSION_FROM        => 'lib/CHI/Driver/MongoDB.pm',
    ABSTRACT_FROM       => 'lib/CHI/Driver/MongoDB.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    BUILD_REQUIRES => {
        'Test::Class' => '0',
        'Test::More' => '0'
    },
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '6.31'
    },
    LICENSE => 'perl',
    PREREQ_PM => {
	'CHI'	     => '0.241',
	'MongoDB'    => '0.42',
    },
    test 		=> { TESTS => 't/*.t' },
);
