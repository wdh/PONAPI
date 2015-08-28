package PONAPI::Resource::Builder;
# ABSTRACT: A Perl implementation of the JASON-API (http://jsonapi.org/format) spec - Resource

use strict;
use warnings;
use Moose;

has id => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has type => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has links => (
    is        => 'ro',
    isa       => 'PONAPI::Links',
    predicate => 'has_links',
);

has relationships => (
    is        => 'ro',
    isa       => 'PONAPI::Relationships',
    predicate => 'has_relationships',
);

has _attributes => (
    init_arg => undef,
    traits   => [ 'Hash' ],
    is       => 'ro',
    isa      => 'HashRef',
    default  => sub { +{} },
    handles => {
        has_attributes => 'count',
        add_attribute  => 'set',
        get_attribute  => 'get',
    }
);

has _meta => (
    init_arg => undef,
    traits   => [ 'Hash' ],
    is       => 'ro',
    isa      => 'HashRef',
    default  => sub { +{} },
    handles => {
        has_meta => 'count',
        add_meta => 'set',
        get_meta => 'get',
    }
);


sub build {
    my $self = shift;

    my %ret = (
        type => $self->type,
        id   => $self->id,
    );

    $self->has_attributes    and $ret{attributes}    = $self->_attributes;
    $self->has_meta          and $ret{meta}          = $self->_meta;
    $self->has_relationships and $ret{relationships} = $self->relationships;
    $self->has_links         and $ret{links}         = $self->links;

    return \%ret;
}


__PACKAGE__->meta->make_immutable;
1;

__END__

=head1 SYNOPSIS



=head1 DESCRIPTION



=head1 ATTRIBUTES

=head2 id



=head2 type



=head2 attributes



=head2 relationships



=head2 links



=head2 meta
