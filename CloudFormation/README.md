# Instructions

1. Download the CloudFormation template:

	```
	wget https://raw.githubusercontent.com/OzNetNerd/Packer-Gitlab/master/CloudFormation/cfn.yml
	```

2. Execute the CloudFormation template.

	**Note**: `AdminIp` is optional. It defaults to `0.0.0.0/0`:

	```
	aws cloudformation create-stack --stack-name GitLab \
	--parameters ParameterKey=AmiId,ParameterValue=<AWS_LINUX2_AMI> \
	 ParameterKey=VpcId,ParameterValue=<VPC_ID> \
	 ParameterKey=AdminIp,ParameterValue=<YOUR_PUBLIC_IP> \
	 ParameterKey=SubnetId,ParameterValue=<SUBNET_ID> \
	 ParameterKey=KeyPair,ParameterValue=<KEY_NAME> \
	 --template-body file://cfn.yml
	```

3. Obtain the EC2 instance hostname:

	```
	aws cloudformation \
	--region <AWS_REGION> describe-stacks \
	--stack-name=GitLab \
	--query 'Stacks[0].Outputs[?OutputKey==`Ec2InstanceHostname`].OutputValue' \
	--output text
	```

4. (Optional) Run the `docker ps` command. If you Receive the following error message:

	```
	Couldn't connect to Docker daemon at http+docker://localhost - is it running?
	``` 
	
	Terminate the SSH session and reconnect.

# Setting Up GitLab

Follow the Setting Up Gitlab instructions on the [main page.](https://github.com/OzNetNerd/Packer-Gitlab)

