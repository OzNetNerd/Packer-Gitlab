# About

Spin up an EC2 instance containing Gitlab, Gitlab runner and a Docker registry.

Note that there are two ways this can be done;

1. Create a [Packer image](https://github.com/OzNetNerd/Packer-Gitlab/tree/master/Packer)
2. Use an EC2 instance with a [`UserData` script](https://github.com/OzNetNerd/Packer-Gitlab/tree/master/CloudFormation)

# Setting up Gitlab

Once you have you GitLab instance up and running, complete the following steps.

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

# Recommended Repo Settings

1. Create a repository

2. Settings -> General -> Merge Requests - Enable `Pipelines must succeed`

3. Settings -> CI/CD -> Variables - Add variables and secrets which are consumed by your pipeline
