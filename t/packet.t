use strict;
use warnings;
use Test::More tests => 17;
use Net::NTP;


eval {
    my $p = Net::NTP::Packet->new(unknown => 1);
};
if ($@) {
    ok 1, "detect unknown fields:" . $@;
} else {
    fail "should have died on unkown field";
}

my $p = Net::NTP::Packet->new(version => 4);
ok $p;
is $p->{version}, 4;

my ($hex_packet, $bin);
$hex_packet = "240106EC000000000000000847505373D8792EC7E60ACE36D8792EC991A82B58D8792EC9576119D8D8792EC957652DD7";
$bin = pack("H*", $hex_packet);
$p = Net::NTP::Packet->decode($bin, time());
is $p->{mode}, 4;
is $p->{version}, 4;
is $p->{stratum}, 1;
is $p->{leap}, 0;
is $p->{poll}, 6;
is $p->{precision}, -20;

$hex_packet = "E40106EC000000000000000847505373D8792EC7E60ACE36D8792EC991A82B58D8792EC9576119D8D8792EC957652DD7";
$bin = pack("H*", $hex_packet);
$p = Net::NTP::Packet->decode($bin, time());
is $p->{mode}, 4;
is $p->{version}, 4;
is $p->{stratum}, 1;
is $p->{leap}, 3;
is $p->{poll}, 6;
is $p->{precision}, -20;
is $p->{org}, 1422831689.56897;

## NOTE: Since encode is so limited right now it doesn't compare to $hex_packet
my $rbin = $p->encode();
my $rhex = join '', map { sprintf("%02X", $_) } unpack "C*", $rbin;
is $rhex, "1B000000000000000000000000000000000000000000000000000000000000000000000000000000D8792EC991C8D414";
