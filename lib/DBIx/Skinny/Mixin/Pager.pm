package DBIx::Skinny::Mixin::Pager;
use strict;
use warnings;

sub register_method {
    +{
        'resultset_with_pager' => &resultset_with_pager,
    },
}

# see also DBIx::Skinny#resultset
sub resultset_with_pager {
    my ($class, $args) = @_;
    $args->{skinny} = $class;
    $class->pager_class->new($args);
}

sub pager_class { die "please override" }

1;
