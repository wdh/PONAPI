#!perl

use strict;
use warnings;

use Test::More;
use Test::Moose;

use JSON::XS qw( encode_json );

BEGIN {
    use_ok('PONAPI::Client::Request::Update');
}

=pod

TODO:

=cut

my %TEST_DATA = (
    type => 'articles',
    id   => 3,
    data => {
        body    => "The 3rd shortest article. Ever.",
        created => "2015-07-22T14:56:29.000Z",
        status  => "ok",
        title   => "a third one",
        updated => "2015-09-22T14:56:28.000Z",
    },
);

subtest '... testing object' => sub {

    my $req = PONAPI::Client::Request::Update->new( %TEST_DATA );

    isa_ok( $req, 'PONAPI::Client::Request::Update');
    does_ok($req, 'PONAPI::Client::Request');
    does_ok($req, 'PONAPI::Client::Request::Role::IsPATCH');
    does_ok($req, 'PONAPI::Client::Request::Role::HasType');
    does_ok($req, 'PONAPI::Client::Request::Role::HasId');
    does_ok($req, 'PONAPI::Client::Request::Role::HasData');

    can_ok( $req, 'method' );
    can_ok( $req, 'path' );
    can_ok( $req, 'request_params' );

};

subtest '... testing request parameters' => sub {

    my $req = PONAPI::Client::Request::Update->new( %TEST_DATA );

    my $EXPECTED = +{
        method       => 'PATCH',
        path         => '/articles/3',
        body         => encode_json({ data => $TEST_DATA{data} }),
    };

    my $GOT = +{ $req->request_params };

    is_deeply( $GOT, $EXPECTED, 'checked request parametes' );

};

done_testing;
