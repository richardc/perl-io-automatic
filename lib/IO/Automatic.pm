use strict;
package IO::Automatic;
use Carp qw(croak);
use IO::Scalar;
use IO::File;
our $VERSION = '0.01';

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

Several types of automatic conversion are supplied.

=head2 Scalar references

Scalar references are translated into IO::Scalar objects.

=head2 Glob references

Globs are returned untouched as it is assumed they will already be
suitable for use as IO handles.

=head2 Plain scalar

A plain scalar is assumed to be a filename and so is transformed into
an IO::File object.

=head1 AUTHOR

Richard Clamp <richardc@unixbeard.net>

=head1 COPYRIGHT

Copyright (C) 2003 Richard Clamp.  All Rights Reserved.

This module is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

IO::File, IO::Scalar

=cut

