package Mock::BasicMySQL::Schema;
use utf8;
use DBIx::Skinny::Schema;

install_table mock_basic_mysql => schema {
    pk 'id';
    columns qw/
        id
        name
    /;
};

1;

