package DBIx::Skinny::Mixin::Pager;
use strict
use warnings;

sub register_method {
    +{
        'resultset_with_pager' => &resultset_with_pager,
    },
}

sub resultset_with_pager {}

1;
