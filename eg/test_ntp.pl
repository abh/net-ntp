#!/usr/bin/perl -w

use strict;
use Net::NTP;
use Time::HiRes;

print "$Net::NTP::VERSION\n";
$Net::NTP::TIMEOUT = 20;

#my $time_then = $Net::NTP::CLIENT_TIME_SEND;
my $time_then = sprintf("%0.5f", Time::HiRes::time);
$Net::NTP::CLIENT_TIME_SEND = $time_then;
my %pkt = get_ntp_response(shift);
my $time_now = sprintf("%0.5f", Time::HiRes::time);
#my $time_now = time();
#my $time_now = $Net::NTP::CLIENT_TIME_RECEIVE;

while(my($k,$v) = each %pkt){
    printf "%s = %s\n", $k, $v;
    print scalar localtime($v),"\n" if $k =~ /Timestamp$/;
}

print "then: $time_then\tnow: $time_now\n";

my $dest_org = sprintf "%0.5f", ( ($time_now - $time_then)  );
my $recv_trans = sprintf "%0.5f", ( $pkt{'Receive Timestamp'} - $pkt{'Transmit Timestamp'} );
my $delay = sprintf "%0.5f", ($dest_org + $recv_trans);

my $recv_org = sprintf "%0.5f", ( $pkt{'Receive Timestamp'} - $time_now );
my $trans_dest = sprintf "%0.5f", ( $pkt{'Transmit Timestamp'} - $time_then );
my $offset = sprintf "%0.5f", (($recv_org + $trans_dest) / 2);

print "Delay: $delay\n";
printf "Offset: %0.5f\n", $offset;
printf "Mode: %s\n", $Net::NTP::MODE{$pkt{'Mode'}};
printf "Stratum: %s\n", $Net::NTP::STRATUM{$pkt{'Stratum'}};
printf "Stratum One Text: %s\n", 
    $Net::NTP::STRATUM_ONE_TEXT{$pkt{'Reference Clock Identifier'}}
    if($pkt{'Stratum'} == 1);
printf "Leap Indicator: %s\n", $Net::NTP::LEAP_INDICATOR{$pkt{'Leap Indicator'}};
