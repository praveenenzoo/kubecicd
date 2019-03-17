#!/bin/bash
#fetching latest update from github
git pull 

##getting latest commit tag

get_commit=`git log | head -5 | tail -1 | cut -d" " -f5`
echo $get_commit

# now create docker image by using the upper tag

docker build -t 192.168.10.160:5000/$get_commit .

#now push image to docker private registery 
docker push 192.168.10.160:5000/$get_commit

# setting some time out

echo "please wait image is being pushed to docker Registry..>>" sleep 5

# now updating kuberbities deployment image

echo "updating your deployment image ---@@@@"
echo "please wait for we are about to list your all deployments:-->> "
sleep 2
# command to get deployment
kubectl get deployment | cut -d" " -f1 
echo "please enter your deployment name: "
read get_dep; 

echo "thanks for choosing deployment:--- $get_dep"

##finally updating deployment

kubectl set image deployment/$get_dep nginx=192.168.10.160:5000/$get_commit

