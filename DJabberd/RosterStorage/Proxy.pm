package DJabberd::RosterStorage::Proxy;
#NEED TO BE CHANGED, COPIED FROM "In mem only" Roster Storage
use strict;
use warnings;
use base 'DJabberd::RosterStorage';

use DJabberd::Log;
use DJabberd::RosterItem;
our $logger = DJabberd::Log->get_logger();
our $client = DJabberd::Client::Client::get_client();


sub finalize {
#    my $self = shift;
	
#    $self->{rosters} = {};
#    # 'user@local' => {
#    #   'contact@remote' => { rosteritem attribs },
#    #   ...
#    # }
	
#    return $self;
}

sub blocking { 0 }

sub get_roster {
    my ($self, $cb, $jid) = @_;
    my $jidstr = $jid->as_bare_string;

    $logger->debug("Getting roster for '$jid'");
    
    $client->RosterRequest();

    #Sending presence to tell world that we are logged in
    $client->PresenceSend();
    $client->Process(5);

    #Getting Roster to tell server to send presence info
    $client->RosterGet();
    $client->Process(5);  

    
    my @jids  = $client->RosterDBJIDs();



    my $roster = DJabberd::Roster->new; 
    foreach my $jid (@jids) 
    {
	#TODO fix subscriptiion
        my $subscription = DJabberd::Subscription->from_bitmask(12);
	my $item = {};
	$item->{jid} = $jid->GetJID();
	print $item->{jid} . "\n";
	$item->{name} = "";
	$item->{groups} = [];
	$item->{remove} = "";
	$item->{subscription} = 12;
	$roster->add(DJabberd::RosterItem->new(%$item, subscription => $subscription));
    }

    $logger->debug("  ... got groups, calling set_roster..");

    $cb->set_roster($roster);
}

sub set_roster_item {
#    my ($self, $cb, $jid, $ritem) = @_;
#    my $jidstr = $jid->as_bare_string;
#    my $rjidstr = $ritem->jid->as_bare_string;
	#
#    $self->{rosters}->{$jidstr}->{$rjidstr} = {
#        jid          => $rjidstr,
#        name         => $ritem->name,
#        groups       => [$ritem->groups],
#        subscription => $ritem->subscription->as_bitmask,
#    };
#        
#    $logger->debug("Set roster item");
#    $cb->done($ritem);
}

sub addupdate_roster_item {
    my ($self, $cb, $jid, $ritem) = @_;
#    my $jidstr = $jid->as_bare_string;
#    my $rjidstr = $ritem->jid->as_bare_string;
#	
#    my $olditem = $self->{rosters}->{$jidstr}->{$rjidstr};
#	
#    my $newitem = $self->{rosters}->{$jidstr}->{$rjidstr} = {
#        jid          => $rjidstr,
#        name         => $ritem->name,
#        groups       => [$ritem->groups],
#    };

#    if (defined $olditem) {
#        $ritem->set_subscription(DJabberd::Subscription->from_bitmask($olditem->{subscription}));
#        $newitem->{subscription} = $olditem->{subscription};
#    }
#    else {
#        $newitem->{subscription} = $ritem->subscription->as_bitmask;
#    }
#    
    $cb->done($ritem);
}

sub delete_roster_item {
    my ($self, $cb, $jid, $ritem) = @_;
#    $logger->debug("delete roster item!");
#	
#    my $jidstr = $jid->as_bare_string;
#    my $rjidstr = $ritem->jid->as_bare_string;
#    
#    delete $self->{rosters}->{$jidstr}->{$rjidstr};
	
    $cb->done;
}

sub load_roster_item {
    my ($self, $jid, $contact_jid, $cb) = @_;
#
##    my $jidstr = $jid->as_bare_string;
#    my $cjidstr = $contact_jid->as_bare_string;
#    
#    my $options = $self->{rosters}->{$jidstr}->{$cjidstr};
#	
#    unless (defined $options) {
#        $cb->set(undef);
#        return;
#    }
#	
#    my $subscription = DJabberd::Subscription->from_bitmask($options->{subscription});
	#
#    my $item = DJabberd::RosterItem->new(%$options, subscription => $subscription);
#	
#    $cb->set($item);
    return;
}

sub wipe_roster {
    my ($self, $cb, $jid) = @_;
	
#    my $jidstr = $jid->as_bare_string;
	
#    delete $self->{rosters}->{$jidstr};

    $cb->done;
}

1;
