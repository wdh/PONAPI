package PONAPI::DAO::Request::RetrieveAll;

use Moose;

extends 'PONAPI::DAO::Request';

with 'PONAPI::DAO::Request::Role::HasFields',
     'PONAPI::DAO::Request::Role::HasFilter',
     'PONAPI::DAO::Request::Role::HasInclude',
     'PONAPI::DAO::Request::Role::HasPage',
     'PONAPI::DAO::Request::Role::HasSort';

sub BUILD {
    my $self = shift;

    $self->check_no_id;
    $self->check_no_body;
}

sub execute {
    my $self = shift;
    my $doc = $self->document;

    if ( $self->is_valid ) {
        $doc->convert_to_collection;
        local $@;
        eval {
            $self->repository->retrieve_all( %{ $self } );
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
