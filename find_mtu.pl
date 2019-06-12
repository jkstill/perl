!#/usr/bin/perl

use strict;
use warnings;
use IO::Socket;
sub ping_hpux($$);
sub ping_port($$);

#netstat -i
#netstat -r

my $max = 10_000;
my $min = 0;
my $address = 'avail.pythian.com';
my $timeout = 4;
my $port = 80;

sub ping_linux($$);

print "Address: $address\n";
print "Timeout: $timeout\n";

if ($^O eq 'hpux') {
    my $mtu;
    print "Finding MTU by ping:\n";
    $mtu = ping_hpux($min, $max);
    print "MTU: $mtu\n";
}
if ($^O eq 'linux') {
    my $mtu;
    #print "Finding MTU by ping:\n";
    #$mtu = ping_linux($min, $max);
    #print "MTU: $mtu\n";
}
else {
    print "OS not supported\n";
    exit;
}
my $mtu;
print "Finding MTU by TCP:\n";
$mtu = ping_port($min, $max);
print "MTU: $mtu\n";

sub ping_hpux($$) {
    my ($lower, $upper) = @_;
    if ($lower == $upper) {
        return $lower;
    }

    my $test_size = int(($upper-$lower)/2 + $lower);
    if ($test_size == $lower) {
        $test_size = $upper;
    }

    print "Test [$lower - $upper]: $test_size\n";

    $SIG{ALRM} = sub {
        print "Timed out.\n";
        return ping_hpux($lower, $test_size);
    };
    alarm($timeout + 3);
    my $out = `ping $address $test_size -n 1 -m $timeout`;
    alarm(0);
    if ($out =~ /not found/m) {
        print "Error: $out\n";
        exit;
    }
    elsif ($out =~ /ping: illegal packet size/m) {
        print "Illegal size.\n";
        return ping_hpux($lower, $test_size);
    }
    elsif ($out =~ /100% packet loss/m) {
        print "Failed.\n";
        return ping_hpux($lower, int(($upper-$lower)/2 + $lower));
    }
    else {
        if ($test_size == $upper) {
            print "Increasing max.\n";
            return ping_hpux($upper, int($upper * 1.5));
        }
        else {
            print "OK.\n";
            return ping_hpux($test_size, $upper);
        }
    }
}

sub ping_linux($$) {
    my ($lower, $upper) = @_;
    if ($lower == $upper) {
        return $lower;
    }

    my $test_size = int(($upper-$lower)/2 + $lower);
    if ($test_size == $lower) {
        $test_size = $upper;
    }

    print "Test [$lower - $upper]: $test_size\n";

    $SIG{ALRM} = sub {
        print "Timed out.\n";
        return ping_linux($lower, $test_size);
    };
    alarm($timeout + 3);
    my $out = `ping -s $test_size -c 1 -w $timeout $address`;
    alarm(0);
    if ($out =~ /not found/m) {
        print "Error: $out\n";
        exit;
    }
    elsif ($out =~ /Error: packet size/m) {
        print "Illegal size.\n";
        return ping_linux($lower, $test_size);
    }
    elsif ($out =~ /100% packet loss/m) {
        print "Failed.\n";
        return ping_linux($lower, int(($upper-$lower)/2 + $lower));
    }
    else {
        if ($test_size == $upper) {
            print "Increasing max.\n";
            return ping_linux($upper, int($upper * 1.5));
        }
        else {
            print "OK.\n";
            return ping_linux($test_size, $upper);
        }
    }
}

sub ping_port($$) {
    my ($lower, $upper) = @_;
    if ($lower == $upper) {
        print "Found...\n";
        return $lower;
    }

    my $test_size = int(($upper-$lower)/2 + $lower);
    if ($test_size == $lower) {
        $test_size = $upper;
    }

    print "Test [$lower - $upper]: $test_size\n";


    #alarm(0);
    my $t_o_fail = 0;
    #eval {
        #local $SIG{ALRM} = sub { die "ALM Timed Out" };
        local $SIG{ALRM} = sub { $t_o_fail = 1 };
        alarm $timeout;
        my $sock = IO::Socket::INET->new(
            PeerAddr => $address,
            PeerPort => $port,
            Proto    => 'tcp',
            Timeout  => $timeout
        );
        if (! $sock) {
            print "No webserver connection.\n";
            exit;
        }
        $sock->autoflush();
        my $content = '#' x ($test_size);
        my $clen = $test_size+5;
        my $submit = <<"END_POST";
POST /filedist/test_mtu.pl HTTP/1.0
Host: $address
User-Agent: NONE/0.0
Content-type:application/x-www-form-urlencoded
Content-length:$clen

data=$content
END_POST

        print $sock $submit;

        my $response = join('',<$sock>);
        my $len = length($response);
        print "response ($len)\n"; # $response\n";
        if ($len < $clen) {
            print "Fail.\n";
            return ping_port($lower, $test_size-1);
        }
        if ($response =~ /Request-URI Too Large/) {
            return ping_port($lower, $test_size);
        }
        alarm 0;
    #};
    if ($t_o_fail) {
        #if ($@ =~ /ALM Timed Out/) {
            print "Fail.\n";
            return ping_port($lower, $test_size);
        #}
        #print "MSG: $@\n";
    }

    if ($test_size == $upper) {
        print "Increasing max.\n";
        return ping_port($upper, int($upper * 1.5));
    }
    else {
        print "OK.\n";
        return ping_port($test_size, $upper);
    }
}


