package DBIx::Skinny::Pager;

use strict;
use warnings;
use base 'DBIx::Skinny::SQL';
use Data::Page;
use Carp ();

our $VERSION = '0.01';

sub as_sql {
    my $self = shift;
    my $result = $self->SUPER::as_sql;
    # TODO: 正規表現もいいかげんなのでもうちょいちゃんとやりたい
    # as_sqlの中身をいじるのは本家への追従を考えると難しそう
    $result =~ s/SELECT /SELECT SQL_CALC_FOUND_ROWS/; # mysql support only
}

sub retrieve {
    my $self = shift;
    Carp::croak("limit not found") unless defined($self->limit);
    Carp::croak("offset not found") unless defined($self->offset);

    my $iter = $self->SUPER::retrieve(@_);
    my $rows = $self->skinny->search_by_sql(q{SELECT FOUND_ROWS() AS row})->first;
    my $pager = Data::Page->new($rows->row, $self->limit, ( $self->offset / $self->limit) + 1);
    return ( $iter, $pager );
}


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
