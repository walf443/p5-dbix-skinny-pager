package DBIx::Skinny::Pager;

use strict;
use warnings;
use base 'DBIx::Skinny::SQL';

our $VERSION = '0.01';

1;
__END__

=head1 NAME

DBIx::Skinny::Pager -

=head1 SYNOPSIS

  package Proj::DB;
  use DBIx::Skinny;
  use DBIx::Skinny::Mixin modules => ['Pager::MySQL'];

  package main;
  use Proj::DB;

  my $rs = Proj::DB->resultset_with_pager;
  # $rs can handle like DBIx::Skinny::SQL.
  $rs->from('some_table');
  $rs->add_where('foo' => 'bar');
  $rs->limit(10);
  $rs->offset(20);
  my ($iter, $pager) = $rs->retrieve;
  # $iter is a DBIx::Skinny::Iterator
  # $pager is a Data::Page

=head1 DESCRIPTION

DBIx::Skinny::Pager is resultset pager interface for DBIx::Skinny.
This module is not support for search_by_sql or search_named.

XXX: THIS PROJECT IS EARLY DEVELOPMENT. API may change in future.

=head1 AUTHOR

Keiji Yoshimi E<lt>walf443 at gmail dot comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
