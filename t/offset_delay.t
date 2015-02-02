use strict;
use warnings;
use Test::More tests => 4;
use Net::NTP;

my $p = Net::NTP::Packet->new(rec => 1, xmt => 10);
is(Net::NTP->offset($p, 0, 11), 0);
is(Net::NTP->delay($p, 0, 11), 2);

is(Net::NTP->offset($p, 1, 11), -0.5);
is(Net::NTP->delay($p, 1, 11), 1);
