package SortKey::Num::pattern_count;

use 5.010001;
use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub meta {
    return +{
        v => 1,
        args => {
            pattern => {
                schema => 're_from_str*',
                req => 1,
            },
            string => {
                schema => ['str*', min_len=>1],
                req => 1,
            },
        },
        args_rels => {
            'req_one' => [qw/regexp/],
        },
    };
}

sub gen_keygen {
    my %args = @_;

    my $re = $args{pattern} ? $args{pattern} : qr/\Q$args{string}\E/;

    sub {
        my $str = shift;
        my $count = 0;
        $count++ while $str =~ /$re/g;
        $count;
    };
}

1;
# ABSTRACT: Number of occurrences of string/regexp pattern as sort key

=for Pod::Coverage ^(meta|gen_keygen)$

=head1 SYNOPSIS

 use Sort::Key qw(nkeysort);
 use SortKey::Num::pattern_count;

 my $by_pattern_count = SortKey::Num::length::gen_keygen(string => 'fo');
 my @sorted = &nkeysort($by_pattern_count, "fofood", "foolish", "fofofo");
 # => ("foolish", "fofood", "fofofo")


=head1 DESCRIPTION


=head1 SEE ALSO

Old incarnation: L<Sort::Sub::by_count>

=cut
