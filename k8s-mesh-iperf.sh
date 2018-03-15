#!/bin/sh

if [ $# != 1 ]; then
        echo "Usage: $0 check-hostnetwork(yes|no)  ## check k8s fullmesh connectivity and bw with iperf3"
        exit
fi

starttime=$(date)

cat <<EOF3 | kubectl create -f -
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: k8s-mesh-iperf
spec:
  template:
    metadata:
      labels:
        name: k8s-mesh-iperf
    spec:
      tolerations:
        - key: "node-role.kubernetes.io/master"
          operator: "Exists"
          effect: "NoSchedule"
      containers:
        - image: alpine
          name: alpine
          command: ["/bin/sh"]
          args: ["-c", "apk update && apk add iperf3 && iperf3 -s"]
EOF3

sleep 15


if [ "$1" == "yes" ] ;
then

cat <<EOF2 | kubectl create -f -
apiVersion: extensions/v1beta1
kind: DaemonSet
metadata:
  name: k8s-mesh-iperf-hostnetwork
spec:
  template:
    metadata:
      labels:
        name: k8s-mesh-iperf-hostnetwork
    spec:
      tolerations:
        - key: "node-role.kubernetes.io/master"
          operator: "Exists"
          effect: "NoSchedule"
      hostNetwork: true
      containers:
        - image: alpine
          name: alpine
          command: ["/bin/sh"]
          args: ["-c", "apk update && apk add iperf3 && iperf3 -s"]
          securityContext:
            privileged: true
EOF2



fi

sleep 15





ips=$(kubectl get pod -o wide | grep k8s-mesh-iperf | awk '{print $6}')
pods=$(kubectl get pod -o wide | grep k8s-mesh-iperf | awk '{print $1}')

for pod in $pods

do

 for ip in $ips
 do

 podnode=$(kubectl get pod -o wide | grep -w $pod | awk '{print $7}')
 targetnode=$(kubectl get pod -o wide | grep -w $ip | awk '{print $7}')
 targetpod=$(kubectl get pod -o wide | grep -w $ip | awk '{print $1}')

  if [ $podnode == $targetnode ] ;
  then
  continue
  fi

 echo "pod $pod connecting to pod $targetpod, node $podnode to $targetnode"
 kubectl exec $pod -- iperf3 -f m --connect-timeout 3 -4 -c $ip | grep sender | awk '{print $7 " " $8 " retransmits:" $9}'
 ping 8.8.8.8 -c 3 -n -W 2 | tail -n 1
 done

done




if [ "$1" == "yes" ] ;
then
kubectl delete ds k8s-mesh-iperf-hostnetwork
fi

kubectl delete ds k8s-mesh-iperf

echo starttime is $starttime - endtime is $(date)

