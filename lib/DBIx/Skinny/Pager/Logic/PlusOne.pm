package DBIx::Skinny::Pager::Logic::PlusOne;
use strict;
use warnings;
use base qw(DBIx::Skinny::Pager);

sub as_sql {
    my $self = shift;
    my $original_limit = $self->limit;
    $self->limit($original_limit + 1);
    my $result = $self->SUPER::as_sql;
    $self->limit($original_limit);
    return $result;
}

sub get_total_entries {
    my ($self, $iter) = @_;
    my $has_next;
    # XXX: iterがno cacheの場合はうまくいかないが、
    # ここはPagerで拡張したretrieve以外から呼ばれることは想定されていないので
    # 大丈夫な気もする
    if ( $iter->count > $self->limit ) {
        pop @{$iter->{_rows_cache}};
        # for date2itr
        if ( $iter->{data} ) {
            pop @{$iter->{data}};
        }
        $has_next++;
    }
    return $self->offset + $self->limit + ( $has_next || 0 );
}

1;
__END__

=head1 NAME

DBIx::Skinny::Pager::Logic::PlusOne

=head1 SYNOPSIS

  package Proj::DB;
  use DBIx::Skinny;

  package main;
  use Proj::DB;

  my $rs = Proj::DB->resultset_with_pager('PlusOne');
  # $rs can handle like DBIx::Skinny::SQL.
  $rs->from('some_table');
  $rs->add_where('foo' => 'bar');
  $rs->limit(10);
  $rs->offset(20);
  my ($iter, $pager) = $rs->retrieve;
  # $iter is a DBIx::Skinny::Iterator
  # $pager is a Data::Page

=head1 DESCRIPTION

DBIx::Skinny::Pager::Logic::PlusOne will take limit + 1 record and you can decide next page is exist or not.
This logic is good at performance.
But, you can't know total records.

=head1 AUTHOR

Keiji Yoshimi E<lt>walf443 at gmail dot comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
