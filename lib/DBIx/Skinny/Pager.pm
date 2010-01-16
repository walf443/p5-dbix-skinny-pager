package DBIx::Skinny::Pager;

use strict;
use warnings;
use base 'DBIx::Skinny::SQL';

our $VERSION = '0.01';

sub page {
    my ($self, $arg) = @_;
    if ( $arg ) {
        $self->{page} = $arg;
    } else {
        $self->{page};
    }
}

sub get_total_entries {
    die "please override";
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
    my $pager = Data::Page->new($total_entries, $self->limit, ( $self->offset / $self->limit) + 1);
    return ( $iter, $pager );
}

1;
__END__

=head1 NAME

DBIx::Skinny::Pager -

=head1 SYNOPSIS

  package Proj::DB;
  use DBIx::Skinny;
  use DBIx::Skinny::Mixin modules => ['Pager::Logic::MySQLFoundRows'];

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
