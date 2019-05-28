# About

Creates an image containing Gitlab and a Gitlab runner. 

# Build

1. Set up your AWS credentials in one of the following ways:
	1. Set the `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_DEFAULT_REGION` environment variables.
	2. Create an [AWS Named Profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html). You will need to configure a default profile or set the `AWS_DEFAULT_PROFILE` environment variable.

2. Download Packer:

    ```
    cd /tmp
    wget https://releases.hashicorp.com/packer/1.4.1/packer_1.4.1_linux_amd64.zip
    unzip packer_1.4.1_linux_amd64.zip
    sudo mv packer /usr/bin
    ```        

3. Run the following command:

	```
	make build
	```

# Setting up Gitlab

1. SSH into the instance and start Gitlab: 

	```
	make start-gitlab
	```

2. Browse to the Gitlab server and create password.
3. Log in with the username `root` and the password you just set.
4. Click "Settings" (the spanner icon), then click "Runners".
5. Find the registration token on this page, then enter the command below:

	```
	make REGISTRATION_TOKEN=<token> register-gitlab-runner
	```
