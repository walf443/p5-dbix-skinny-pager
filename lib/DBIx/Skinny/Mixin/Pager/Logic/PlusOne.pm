package DBIx::Skinny::Mixin::Pager::Logic::PlusOne;
use strict;
use warnings;
use base 'DBIx::Skinny::Mixin::Pager';
use DBIx::Skinny::Pager::Logic::PlusOne;

sub pager_class { "DBIx::Skinny::Pager::Logic::PlusOne" }

1;
