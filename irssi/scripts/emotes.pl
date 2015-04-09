use strict;
use vars qw($VERSION %IRSSI);

use Irssi;
$VERSION = "0.1";
%IRSSI = (
    authors     => 'mibbio',
    contact     => 'contact@mibbiodev.de',
    name        => 'emotes',
    description => 'Replaces emotes with equivalent unicode char',
    license     => 'Public Domain',
);

my %emo = (
	':)'	=> '\xE2\x98\xBA',
	';)'	=> '\xF0\x9F\x98\x89',
	':D'	=> '\xF0\x9F\x98\x83',
	'D:'	=> '\xF0\x9F\x98\xA6',
	':$'	=> '\xF0\x9F\x98\x96',
	':S'	=> '\xF0\x9F\x98\x96',
	':P'	=> '\xF0\x9F\x98\x9B',
	';P'	=> '\xF0\x9F\x98\x9C',
	'B:'	=> '\xF0\x9F\x98\x8E',
	':('	=> '\xF0\x9F\x98\x9F',
	'>('	=> '',
	':/'	=> '\xF0\x9F\x98\x95',
	':\\'	=> '\xF0\x9F\x98\x95',
	':O'	=> '\xF0\x9F\x98\xAE',
	'<3'	=> '\xE2\x99\xA5',
	'^^'	=> '\xF0\x9F\x98\x8A',
	'o.O'	=> '\xF0\x9F\x98\xB2',
	'-.-'	=> '\xF0\x9F\x98\x91'
)

sub replace {
	my ( $server, $message, $nick, $address, $target ) =@_;

	Irssi::signal_continue( $server, $message, $nick, $address, $target );
}

Irssi::signal_add_first("message public", "replace");
Irssi::signal_add_first("message private", "replace");
