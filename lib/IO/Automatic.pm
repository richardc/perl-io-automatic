use strict;
package Data::Sink;
use Carp qw(croak);
use IO::Scalar;
use IO::File;

sub new {
    my $self = shift;
    my $dest = shift;

    return IO::Scalar->new( $dest ) if ref $dest eq 'SCALAR';
    return $dest if ref $dest eq 'GLOB';
    croak "Don't know what to do with something of type ". ref $dest
      if ref $dest;
    return IO::File->new( $dest );
}

1;
