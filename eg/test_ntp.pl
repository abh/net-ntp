#!/usr/bin/perl -w

use strict;
use Net::NTP;
use Time::HiRes;

print "$Net::NTP::VERSION\n";
$Net::NTP::TIMEOUT = 4;

my %pkt = get_ntp_response(shift);

while(my($k,$v) = each %pkt){
    printf "%s = %s\n", $k, $v;
    print scalar localtime($v),"\n" if $k =~ /Timestamp$/;
}

printf "Mode: %s\n", $Net::NTP::MODE{$pkt{'Mode'}};
printf "Stratum: %s\n", $Net::NTP::STRATUM{$pkt{'Stratum'}};
printf "Stratum One Text: %s\n", 
    $Net::NTP::STRATUM_ONE_TEXT{$pkt{'Reference Clock Identifier'}}
    if($pkt{'Stratum'} == 1);
printf "Leap Indicator: %s\n", $Net::NTP::LEAP_INDICATOR{$pkt{'Leap Indicator'}};
