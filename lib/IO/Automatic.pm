use strict;
package IO::Automatic;
our $VERSION = '0.02';

sub new {
    my $class = shift;
    my $dest  = shift;

    if (ref $dest eq 'SCALAR') {
        require IO::Scalar;
        return IO::Scalar->new( $dest );
    }
    return $dest if ref $dest eq 'GLOB';

    $! = "Don't know what to do with something of type ". ref $dest;
    return if ref $dest;

    if ( $dest =~ /\.(?:gz|Z)$/ ) {
        require IO::Zlib;
        return IO::Zlib->new( $dest );
    }
    require IO::File;
    return IO::File->new( $dest );
}

1;

=head1 NAME

IO::Automatic - automatically choose a suitable IO::* module

=head1 SYNOPSIS

  use IO::Automatic;

  # scalar
  my $scalar;
  my $io = IO::Automatic->new( \$scalar );
  print $io "Hello World\n";

=head1 DESCRIPTION

IO::Automatic provides a simple factory for creating new output
handles.

Several types of automatic conversion are supplied.  If no conversion
can be done, we return false.

=head2 Scalar references

Scalar references are translated into IO::Scalar objects.

=head2 Glob references

Globs are returned untouched as it is assumed they will already be
suitable for use as IO handles.

=head2 Plain scalar

A plain scalar is assumed to be a filename and so is transformed into
an IO::Zlib or IO::File object as appropriate.

=head1 AUTHOR

Richard Clamp <richardc@unixbeard.net>

=head1 COPYRIGHT

Copyright (C) 2003,2004 Richard Clamp.  All Rights Reserved.

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

L<IO::File>, L<IO::Scalar>, L<IO::Zlib>

=cut

