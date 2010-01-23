package DBIx::Skinny::Pager;

use strict;
use warnings;
use base 'DBIx::Skinny::SQL';
use DBIx::Skinny::Pager::Page;

our $VERSION = '0.01';

__PACKAGE__->mk_accessors(qw(page));

sub get_total_entries {
    die "please override";
}

sub pager_class {
    "DBIx::Skinny::Pager::Page";
}

sub retrieve {
    my $self = shift;
    Carp::croak("limit not found") unless defined($self->limit);
    unless ( defined($self->offset) ) {
        Carp::croak("limit or page not found") unless defined($self->page);
        $self->offset($self->limit * ( $self->page - 1) );
    }

    my $iter = $self->SUPER::retrieve(@_);
    my $total_entries = $self->get_total_entries($iter);
    my $pager = $self->pager_class->new($total_entries, $self->limit, ( $self->offset / $self->limit) + 1);
    return ( $iter, $pager );
}

1;
__END__

=head1 NAME

DBIx::Skinny::Pager -

=head1 SYNOPSIS

  package Proj::DB;
  use DBIx::Skinny;
  use DBIx::Skinny::Mixin modules => ['Pager'];

  package main;
  use Proj::DB;

  my $rs = Proj::DB->resultset_with_pager('MySQLFoundRows');
  # $rs can handle like DBIx::Skinny::SQL.
  $rs->from(['some_table']);
  $rs->add_where('foo' => 'bar');
  $rs->limit(10);
  $rs->offset(20);
  $rs->select([qw(foo bar baz)]);
  my ($iter, $pager) = $rs->retrieve;
  # $iter is a DBIx::Skinny::Iterator
  # $pager is a Data::Page

  # or you can set page
  my $rs2 = Proj::DB->resultset_with_pager;
  $rs2->from(['some_table']);
  $rs2->add_where('foo' => 'bar');
  $rs2->limit(10);
  $rs2->page(2); # offset is 10 * ( 2 - 1) = 10.
  $rs2->select([qw(foo bar baz)]);
  my ($iter, $pager) = $rs2->retrieve;

=head1 DESCRIPTION

DBIx::Skinny::Pager is resultset pager interface for DBIx::Skinny.
This module is not support for search_by_sql or search_named.

and This modele is not support Oracle connection.

XXX: THIS PROJECT IS EARLY DEVELOPMENT. API may change in future.

=head1 AUTHOR

Keiji Yoshimi E<lt>walf443 at gmail dot comE<gt>

=head1 SEE ALSO

+<DBIx::Skinny>, +<DBIx::Skinny::SQL>, +<DBIx::Skinny::Mixin>, +<Data::Page>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
