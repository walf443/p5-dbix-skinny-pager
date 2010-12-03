sub readme_from { warn "Module::Install::ReadmeFromPod is not installed?" }
sub auto_set_repository { warn "Module::Install::Repository is not installed?" }

use inc::Module::Install;

name 'DBIx-Skinny-Pager';
all_from 'lib/DBIx/Skinny/Pager.pm';
readme_from 'lib/DBIx/Skinny/Pager.pm';

tests 't/*.t t/**/*.t';
author_tests 'xt';

requires 'DBIx::Skinny', 0.0729;
requires 'Data::Page';
requires 'Carp';
requires 'Class::Accessor::Lite';

build_requires 'Test::More';
build_requires 'Test::LoadAllModules';
build_requires 'Test::Deep';
build_requires 'Test::Differences';
build_requires 'Test::Requires';
build_requires 'Module::Install::ReadmeFromPod';
build_requires 'Module::Install::Repository';

auto_include;
auto_set_repository;
WriteAll;
