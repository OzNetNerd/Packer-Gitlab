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

	Note: Gitlab can take a few minutes to spin up. Keep refreshing your browser until the "Change password" page is displayed.

3. Log in with the username `root` and the password you just set.

4. Click "Settings" (the spanner icon), then click "Runners".

5. Find the registration token on this page, then enter the command below:

	```
	make REGISTRATION_TOKEN=<token> register-gitlab-runner
	```

6. Refresh the page to ensure your runner has successfully registered.

# Running "example" code
## CI/CD Pipeline

To run the CI/CD pipeline, do the following:

1. Change to the `example` directory:

	```
	cd example
	```

2. Log into GitLab and create a new repository.

3. Run the "Push an existing folder" commands.

## Build and run the image

If you want to see what the example container does, do the following:

1. Build the image:

	```
	cd example
	docker build -t example-nginx .
	```

2. Run the image:

	```
	docker run --rm -it -p 8080:80 --name example-nginx example-nginx
	```

3. Browse to `http://<public_ip>:8080`

# Recommended Repo Settings

1. Create a repository

2. Settings -> General -> Merge Requests - Enable `Pipelines must succeed`

3. Settings -> CI/CD -> Variables - Add variables and secrets which are consumed by your pipeline