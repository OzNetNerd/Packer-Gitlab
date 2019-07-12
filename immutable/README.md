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

# Setting Up GitLab

Follow the Setting Up Gitlab instructions on the [main page.](https://github.com/OzNetNerd/Packer-Gitlab)

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