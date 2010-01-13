use inc::Module::Install;
name 'DBIx-Skinny-Pager';
all_from 'lib/DBIx/Skinny/Pager.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
