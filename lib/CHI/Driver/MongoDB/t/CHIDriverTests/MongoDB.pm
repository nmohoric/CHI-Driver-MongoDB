package CHI::Driver::MongoDB::t::CHIDriverTests::MongoDB;

use MongoDB;
use Module::Load::Conditional qw(can_load);
use Test::More;
use strict;
use warnings;
use base qw(CHI::t::Driver);

sub testing_driver_class    { 'CHI::Driver::MongoDB' }
sub supports_get_namespaces { 1 }

sub SKIP_CLASS {
    my $class = shift;

    if ( not $class->db() ) {
        return "Unable to get database connection.";
    }

    return 0;
}

sub db {
    eval {
        return MongoDB::Connection->new()->get_database('t_chi_driver_mongodb');
    };
}

sub test_with_database : Tests(1) {
    return "MongoDB::Database not installed"
      unless can_load( modules => { "MongoDB::Database" => undef } );

    my $self = shift;
    my $cache = CHI->new(
        driver => "MongoDB",
        db     => $self->db
    );

    my $t = time;
    $cache->set( "test", $t );
    is( $cache->get("test"), $t );
}

sub test_with_connection : Tests(1) {
    return "MongoDB::Connection not installed"
      unless can_load( modules => { "MongoDB::Connection" => undef } );

    my $self = shift;
    my $cache = CHI->new(
        driver  => "MongoDB",
        conn    => MongoDB::Connection->new,
        db_name => 't_chi_driver_mongodb',
    );

    my $t = time;
    $cache->set( "test", $t );
    is( $cache->get("test"), $t );
}

sub cleanup : Tests( shutdown ) {
    my $self = shift;

    my $cache = $self->db->drop;
}

1;
