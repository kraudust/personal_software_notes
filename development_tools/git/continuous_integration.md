# Overview with Harrison Chen
## CI/CD - What Is It?
- CI (continuous integration): integrating code changes into a shared repository with test running automatically to validate
- CD (continuous delivery): Automate the process of packaging and deploying code
- Benefit: less time with logistics, and more time in development, more robust to changes ensuring that changes don't have unanticipated outcomes against cases you didn't develop for
## CI Terms
- Jobs: series of tasks that make up a pipeline
    - Each can perform different commands but also have different rules, configs, etc.
    - Basically, call a series of shell commands
- Runners:
    - Servers, Jetson devices, etc.
    - ARM and x64 devices ensure hardware coverage
## Job Set Up
- tags: which runners do you want to execute this job?
    - e.g. required data mounted on the jetson-orin01 runner, call that tag to make sure the job runs on that device
    - ![](Pasted%20image%2020250422111223.png)
- rules: define conditions that when met automatically trigger job
    - e.g. only on merge requests, specific branches, etc.
- Pipeline defaults vs. job-specific
## Additional Setup Details
- SSH keys have to be setup by admin to be able to pull relevant repos for server run
- Similarly, container registry is setup to store Docker images
- Can also have artifacts that store specific packages, such as Spinnaker in Gitlab's package registry
## Pipeline Overview
- Build Workflow
    - When changes are made on specific branches, build new docker images
- Bag Testing
    - Test against bag files
## Build workflow
- Conditions to satisfy when triggering Docker build
    - New commit on a relevent target branch, source code has changed
    - Dockerfile modification - dependencies, etc. are changing
- Cone repo + check out current branch
- Run docker build
- PUsh to docker registry
- Manage in assemble repo for more streamlined version control
- Builds in stages specified by gitlab-ci.yaml file
## Manual build example
![](Pasted%20image%2020250422112742.png)
## Bag Testing - Introduction
![](Pasted%20image%2020250422112841.png)
## Bag testing - preparation
![](Pasted%20image%2020250422112855.png)
## Bag testing - analysis
![](Pasted%20image%2020250422113120.png)
## Next Steps
![](Pasted%20image%2020250422113314.png)