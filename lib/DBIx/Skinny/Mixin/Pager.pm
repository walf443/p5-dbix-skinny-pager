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
__END__

=head1 NAME

DBIx::Skinny::Mixin::Pager

=head1 SYNOPSIS

  package Proj::DB;
  use DBIx::Skinny;
  use DBIx::Skinny::Mixin modules => ['Pager::Logic::MySQLFoundRows'];

  package main;
  use Proj::DB;

  my $rs = Proj::DB->resultset_with_pager;
  # $rs is DBIx::Skinny::Pager::Logic::MySQLFoundRows

=head1 DESCRIPTION

DBIx::Skinny::Mixin::Pager is a interface for mixin resultset_with_pager method to DBIx::Skinny.
resultset_with_pager return DBIx::Skinny::Pager object.

If you mixin "DBIx::Skinny::Mixin::Pager::Logic::MySQLFoundRows" to DBIx::Skinny, 
resultset_with_pager return DBIx::Skinny::Pager::Logic::MySQLFoundRows object.

=head1 AUTHOR

Keiji Yoshimi E<lt>walf443 at gmail dot comE<gt>

=head1 SEE ALSO

+<DBIx::Skinny::Pager>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
