use strict;
use warnings;
use Test::More;
use lib 't';
use Mock::BasicMySQL;

my ($dsn, $username, $password) = @ENV{map { "SKINNY_MYSQL_${_}" } qw/DSN USER PASS/};

SKIP: {
    skip 'Set $ENV{SKINNY_MYSQL_DSN}, _USER and _PASS to run this test', 1 unless ($dsn && $username);
    my $skinny = Mock::BasicMySQL->new({ dsn => $dsn, username => $username, password => $password });
    $skinny->setup_test_db;

    my @insert_data;
    my $total_record = 15;
    my $counter = 0;
    while ( $counter < $total_record) {
        push @insert_data, +{ name => $counter };
        $counter++;
    }
    $skinny->bulk_insert('mock_basic_mysql', \@insert_data);

    for my $logic_class ( qw(MySQLFoundRows PlusOne Count) ) {
        {
            my $test_name = "$logic_class: normal case";

            my $rs = $skinny->resultset_with_pager($logic_class, {
                page => 1,
                limit => 10,
            });
            isa_ok($rs, "DBIx::Skinny::Pager::Logic::$logic_class");
            $rs->from(['mock_basic_mysql']);
            $rs->select(['name']);
            my ($iter, $pager) = $rs->retrieve;

            if ( $logic_class eq "PlusOne" ) {
                is($pager->total_entries, 10 + 1, "$test_name: total_entries");
            } else {
                is($pager->total_entries, $total_record, "$test_name: total_entries");
            }
            is($pager->current_page, 1, "$test_name: current_page");
            is($pager->entries_per_page, 10, "$test_name: entries_per_page");
            is($iter->count, 10, "$test_name: iterator item count");
            my $last_row;
            while ( my $row = $iter->next ) {
                $last_row = $row;
            }
            is($last_row->name, 10 - 1, "$test_name: last item name");
        }

        {
            my $test_name = "$logic_class: with where";

            my $rs = $skinny->resultset_with_pager($logic_class, {
                page => 4,
                limit => 3,
            });
            isa_ok($rs, "DBIx::Skinny::Pager::Logic::$logic_class");
            $rs->from(['mock_basic_mysql']);
            $rs->add_where(name => { '<' => 10 });
            $rs->select(['name']);
            my ($iter, $pager) = $rs->retrieve;

            if ( $logic_class eq "PlusOne" ) {
                is($pager->total_entries, 3 * (3 + 1) + 0, "$test_name: total_entries");
            } else {
                is($pager->total_entries, 10, "$test_name: total_entries");
            }
            is($pager->current_page, 4, "$test_name: current_page");
            is($pager->entries_per_page, 3, "$test_name: entries_per_page");
            is($iter->count, 1, "$test_name: iterator item count");
            my $last_row;
            while ( my $row = $iter->next ) {
                $last_row = $row;
            }
            is($last_row->name, 9, "$test_name: last item name");
        }
        {
            my $test_name = "$logic_class: with group by";

            my $rs = $skinny->resultset_with_pager($logic_class, {
                page => 1,
                limit => 10,
            });
            isa_ok($rs, "DBIx::Skinny::Pager::Logic::$logic_class");
            $rs->from(['mock_basic_mysql']);
            $rs->group({ column => 'id' });
            $rs->select(['name']);
            my ($iter, $pager) = $rs->retrieve;

            if ( $logic_class eq "PlusOne" ) {
                is($pager->total_entries, 10 + 1, "$test_name: total_entries");
            } else {
                is($pager->total_entries, $total_record, "$test_name: total_entries");
            }
            is($pager->current_page, 1, "$test_name: current_page");
            is($pager->entries_per_page, 10, "$test_name: entries_per_page");
            is($iter->count, 10, "$test_name: iterator item count");
            my $last_row;
            while ( my $row = $iter->next ) {
                $last_row = $row;
            }
            is($last_row->name, 10 - 1, "$test_name: last item name");
        }

    }
    
    if ( $skinny->profiler ) {
        require Data::Dumper;
        warn Data::Dumper::Dumper($skinny->profiler)
    }

    $skinny->cleanup_test_db;
}

done_testing();

