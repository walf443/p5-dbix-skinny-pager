use inc::Module::Install;
use Module::Install::ReadmeFromPod;

name 'DBIx-Skinny-Pager';
all_from 'lib/DBIx/Skinny/Pager.pm';
readme_from 'lib/DBIx/Skinny/Pager.pm';

# requires '';

tests 't/*.t t/**/*.t';
author_tests 'xt';

requires 'DBIx::Skinny';
requires 'Data::Page';
requires 'Carp';

build_requires 'Test::LoadAllModules';
build_requires 'Module::Install::ReadmeFromPod';
use_test_base;
auto_include;
WriteAll;
