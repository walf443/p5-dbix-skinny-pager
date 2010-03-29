package DBIx::Skinny::Pager::Page;
use strict;
use warnings;
use base qw(Data::Page);

sub to_hash {
    my $self = $_[0];
    return +{
        total_entries    => $self->total_entries,
        entries_per_page => $self->entries_per_page,
        previous_page    => $self->previous_page,
        current_page  => $self->current_page,
        next_page        => $self->next_page,
    };
}

1;

__END__
