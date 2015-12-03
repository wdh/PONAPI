package PONAPI::DAO::Request::RetrieveByRelationship;

use Moose;

extends 'PONAPI::DAO::Request';

with 'PONAPI::DAO::Request::Role::HasFields',
     'PONAPI::DAO::Request::Role::HasFilter',
     'PONAPI::DAO::Request::Role::HasInclude',
     'PONAPI::DAO::Request::Role::HasPage',
     'PONAPI::DAO::Request::Role::HasSort';

sub BUILD {
    my $self = shift;

    $self->check_has_id;
    $self->check_has_rel_type;
    $self->check_no_body;
}

sub execute {
    my $self = shift;

    if ( $self->is_valid ) {
        local $@;
        eval {
            $self->repository->retrieve_by_relationship( %{ $self } );
            1;
        } or do {
            my $e = $@;
            $self->_handle_error($e);
        };
    }

    return $self->response();
}


__PACKAGE__->meta->make_immutable;
no Moose; 1;