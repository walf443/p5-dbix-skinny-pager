package Mock::BasicMySQL;
use DBIx::Skinny setup => +{};
use DBIx::Skinny::Mixin modules => [qw(Pager)];

my $table = 'mock_basic_mysql';
sub setup_test_db {
    my $self = shift;
    $self->do(qq{
        CREATE TABLE IF NOT EXISTS $table (
            id   INT auto_increment,
            name INT NOT NULL,
            PRIMARY KEY  (id)
        ) ENGINE=InnoDB
    });
    $self->delete($table, {});
}

sub cleanup_test_db {
    shift->do(qq{DROP TABLE $table});
}
