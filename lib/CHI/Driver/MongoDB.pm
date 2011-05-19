package CHI::Driver::MongoDB;

use strict;
use warnings;

use Moose;
use Carp qw(croak);

our $VERSION = '0.01';

extends 'CHI::Driver';

has 'conn'    => ( is => 'ro', isa => 'MongoDB::Connection' );
has 'db'      => ( is => 'ro', isa => 'MongoDB::Database' );
has 'db_name' => ( is => 'ro', isa => 'Str', default => 'chi' );

__PACKAGE__->meta->make_immutable();

sub BUILD {
    my ( $self, $args ) = @_;

    return if $self->{db};

    if ( $self->{conn} && $self->{db_name} ) {
        $self->{db} = $self->{conn}->get_database( $self->{db_name} );
    }
    else {
        croak 'No Database Set';
    }

    return;
}

sub _collection {
    my ($self) = @_;
    return $self->db->get_collection( $self->namespace() );
}

sub fetch {
    my ( $self, $key ) = @_;
    my $results =
      $self->_collection->find_one( { _id => $key }, { data => 1 } );
    return ($results) ? $results->{data} : undef;
}

sub store {
    my ( $self, $key, $data ) = @_;
    $self->_collection->save( { _id => $key, data => $data }, { safe => 1 } );
    return;
}

sub remove {
    my ( $self, $key ) = @_;
    $self->_collection->remove( { _id => $key }, { safe => 1 } );
    return;
}

sub clear {
    shift->_collection->drop;
    return;
}

sub get_keys {
    return map { $_->{_id} } shift->_collection->find( {}, { _id => 1 } )->all;
}

sub get_namespaces {
    return shift->db->collection_names( { safe => 1 } );
}

1;

=pod

=head1 NAME

CHI::Driver::MongoDB - Use MongoDB for cache storage

=head1 VERSION

version 0.01 

=head1 SYNOPSIS

    use CHI;
    
    # Supply a MongoDB database handle
    #
    my $cache = CHI->new( driver => 'MongoDB', 
			  db => MongoDB::Connection->new->get_database('db_name') );
    
    # Or supply a MongoDB Connection handla and database name
    #
    my $cache = CHI->new( driver => 'MongoDB', 
			  conn => MongoDB::Connection->new, 
			  db_name => 'db_name' );
=head1 DESCRIPTION

This driver uses a MongoDB table to store the cache. 

=for readme stop

=head1 CONSTRUCTOR PARAMETERS

=over

=item namespace

The namespace you pass in will be as the collection name. That 
means that if you don't specify a namespace the cache will be 
stored in a collection called C<chi_Default>.

=item db

The MongoDB::Database handle used to communicate with the db. 

=item conn

Optional MongoDB::Connection handle to use instead of the db

=item db_name

Option database name to use in conjunction with the conn

=back

=for readme continue

=head1 AUTHORS

Nick Mohoric <nick.mohoric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Nick Mohoric.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__END__

