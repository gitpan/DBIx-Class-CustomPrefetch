package My::Schema::User;
use base 'DBIx::Class';

__PACKAGE__->load_components(qw/CustomPrefetch Core/);
__PACKAGE__->table('users');
__PACKAGE__->add_columns(qw/id name/);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->custom_relation( status => 'My::Schema::Status', { 'foreign.user_id' => 'self.id' }  );

sub add_to_statuses {
    my $self = shift;
    my $args = shift || {};
    $self->result_source->schema->resultset('Status')->create( { user_id => $self->id, %$args } );
}

1;
