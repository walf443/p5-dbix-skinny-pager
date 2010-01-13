package DBIx::Skinny::Mixin::Pager::Logic::MYSQLFoundRows;
use strict;
use warnings;
use base 'DBIx::Skinny::Mixin::Pager';
use DBIx::Skinny::Pager::Logic::MYSQLFoundRows;

sub pager_class { "DBIx::Skinny::Pager::Logic::MYSQLFoundRows" }

1;
