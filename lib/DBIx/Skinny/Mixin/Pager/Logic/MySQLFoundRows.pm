package DBIx::Skinny::Mixin::Pager::Logic::MySQLFoundRows;
use strict;
use warnings;
use base 'DBIx::Skinny::Mixin::Pager';
use DBIx::Skinny::Pager::Logic::MySQLFoundRows;

sub pager_class { "DBIx::Skinny::Pager::Logic::MySQLFoundRows" }

1;
