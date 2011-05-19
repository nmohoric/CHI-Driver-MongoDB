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
    PREREQ_PM => {
        'Test::More' => 0,
	'CHI'	     => '0.241',
	'MongoDB'    => '0.42',
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'CHI-Driver-MongoDB-*' },
    test 		=> { TESTS => 't/*.t' },
);
