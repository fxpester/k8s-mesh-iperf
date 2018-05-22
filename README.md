# k8s-mesh-iperf tests
Checks network bandwidth on whole k8s cluster with iperf

## usage:
`./k8s-mesh-iperf.sh no`

## example output:
```
daemonset "k8s-mesh-iperf" created
pod k8s-mesh-iperf-9p2tm connecting to pod k8s-mesh-iperf-bgcb8, node k8s-lab-sk-1 to k8s-lab-sk-3
676 Mbits/sec retransmits:322
rtt min/avg/max/mdev = 3.122/3.407/3.864/0.329 ms
pod k8s-mesh-iperf-9p2tm connecting to pod k8s-mesh-iperf-lk6bp, node k8s-lab-sk-1 to k8s-lab-sk-2
647 Mbits/sec retransmits:2
rtt min/avg/max/mdev = 3.063/3.264/3.659/0.282 ms
pod k8s-mesh-iperf-bgcb8 connecting to pod k8s-mesh-iperf-9p2tm, node k8s-lab-sk-3 to k8s-lab-sk-1
745 Mbits/sec retransmits:276
rtt min/avg/max/mdev = 3.113/3.208/3.288/0.085 ms
pod k8s-mesh-iperf-bgcb8 connecting to pod k8s-mesh-iperf-lk6bp, node k8s-lab-sk-3 to k8s-lab-sk-2
767 Mbits/sec retransmits:216
rtt min/avg/max/mdev = 2.991/3.365/3.683/0.289 ms
pod k8s-mesh-iperf-lk6bp connecting to pod k8s-mesh-iperf-9p2tm, node k8s-lab-sk-2 to k8s-lab-sk-1
820 Mbits/sec retransmits:837
rtt min/avg/max/mdev = 2.975/3.046/3.114/0.072 ms
pod k8s-mesh-iperf-lk6bp connecting to pod k8s-mesh-iperf-bgcb8, node k8s-lab-sk-2 to k8s-lab-sk-3
792 Mbits/sec retransmits:30
rtt min/avg/max/mdev = 3.050/3.315/3.686/0.274 ms
daemonset "k8s-mesh-iperf" deleted
starttime is Thu Mar 15 12:10:39 UTC 2018 - endtime is Thu Mar 15 12:13:18 UTC 2018
```
