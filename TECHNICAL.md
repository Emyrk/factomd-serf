# Technical Stuff

So you want to know what the hell is going on? Awesome!

## The problem

Factomd currently needs some mechanism to reboot the network. The problem can be abstracted into 2 parts. Obviously there are some details in each, but for now, let's handle the happy case.

- How to tell the network is stalled?
- How to coordinate a reboot?

Let's aim to solve these 2 problems in a decentralized way

# Why Serf?

## Decentralized

Serf is described as "Decentralized Cluster Membership, Orchestration, and Failure Detection". In many orchestration systems, a central manager will make decisions for the group of nodes it controls. Docker swarm has managers, Kubernettes has Controller Manager, Consul has Raft style leaders, etc. These projects, although impressive, are inheritly centralized in nature. Serf is not, there is no leaders in Serf. A Serf network will exist until the last node decides to leave. _Serf is a decentralized control plane_.

But without "leadership", anyone could use the control plane. That's where we can leverage Factomd's digitial identities, blockchain, and authority set. 

This means Serf can mantain a cluster where members are free to join and listen, and we can restrict who can speak (effectively) with signatures, for simplicity we will say a majority of the authority set can "speak" in the network.

## Orchestration

The stalling problem is still an orchestration problem, and this is where the 2nd part of Serf comes into play. To more easily explain how this part works, remember that we can control who can effectively send messages in the network by ensureing messages comes from standing parties determined by Factom. 

A `serf agent` is the serf daemon that can listen for messages. These messages come of 2 types; `events` and `queries`.
- Event's are "fire and forget", sending out an event has no responde
- Queries are event's, but have a response that gets returned to the node that sent the message

All events and queries trigger scripts that you can see in [`factomd-handlers`](/factomd-handlers) directory in this repo.

## Preventing Abuse

So it's possible for a factomd to join the decentralized orchestration platform, and the Authority set to vote on restarts. How can we do automation and prevent a federated server from spamming reboots? 

From a node's point of view, if the blockchain has not moved for 30+ minutes, it's safe to say you are stuck. When a authoirty server decides to coordinate a reboot, any node in this "sick" state, will Vote 'Yes'. Any node that is healthy can just abstain.  The vote will have an expiry time, and if the vote doesn't gather enough support before it expires, there is no reboot.

# Extra features

Stop/Start is great, but some reboots take a little more. Serf can adapt to do various things, such as adding a block to the top of a database to get leaders in sync (properly signed of course), or other advanced controls, all automatically.

This repo has the ability to auto update, meaning if a new stall condition is hit, a new event can be created, this serf repo can update itself, then execute the new feature. Once a good set of events is created, the auto-updating nature would have to be removed for security reasons, but it allows for a pretty adaptive start.



# Technical Notes

## Events > Queries

Be careful when using queries, as old queries are not guarenteed to be delivered. Possibly use an event to trigger the restart, then use a query to check on the status.

https://github.com/hashicorp/serf/blob/master/website/source/intro/getting-started/queries.html.markdown#limitations
