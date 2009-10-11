#
#===============================================================================
#
#         FILE:  01-live.t
#
#  DESCRIPTION:  
#
#        FILES:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Andrey Kostenko (), <andrey@kostenko.name>
#      COMPANY:  Rambler Internet Holding
#      VERSION:  1.0
#      CREATED:  11.10.2009 17:47:48 MSD
#     REVISION:  ---
#===============================================================================

use strict;
use warnings;
use lib 't/lib';
use My::Schema;
use My::Storage;

use Test::More tests => 21;                      # last test to print

my $schema = My::Schema->clone;
$schema->storage(My::Storage->new($schema));
$schema->storage->connect_info( ['DBI:SQLite:dbname=t/sqlite.db', '', ''] );
my $dbh  = $schema->storage->dbh;
my $user_rs = $schema->resultset('User');
my $status_rs = $schema->resultset('Status');
$user_rs->delete;#removing shit from breaked tests
$status_rs->delete;
foreach my $user (1..10) {
    my $row = $user_rs->create( { name => "user$user" }  );
    $row->add_to_statuses( { name => "status$_" } ) foreach (1..10);
}
$dbh->{mock_clear_history} = 1;
my @users = $user_rs->all;
is scalar(@users), 10;
foreach ( @users ) {
    isa_ok $_->{__cr_status}, 'My::Schema::Status';
    is $_->{__cr_status}->user_id, $_->id;
}
$user_rs->delete;#removing shit from breaked tests
$status_rs->delete;#removing shit from breaked tests
