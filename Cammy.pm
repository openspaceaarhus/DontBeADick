package Cammy;
require Exporter;
@ISA=qw(Exporter);
@EXPORT = qw(init config cfgBoard cfgRAM cfgLocalStorage cfgQuorum);

use strict;
use warnings;
use Data::Dumper;

my $config;
sub init {
    my $configFile = shift;
    die "Error: The config file $config doesn't exist: $config" unless -f $configFile;

    open CF, "<$configFile" or die "Failed to read $configFile $!";
    my $configContent = join '', <CF>;
    close CF;
    $config = eval $configContent;

    for my $k (qw(board ram disk quorum ssss)) {
	die "Missing option: $k in ".Dumper $config unless $config->{$k};
    }
}

sub config() {
    return $config;
}

sub cfgBoard {
    return @{$config->{board}}
}

sub cfgRAM {
    return $config->{ram};
}

sub cfgLocalStorage {
    return $config->{disk};
}

sub cfgQuorum {
    return $config->{quorum}; 
}

1;
