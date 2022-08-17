# SciOps CICD Pipeline

## Flow

#### Rough Explanation
- Trigger: SciOps Workflow repo make push/PR/tag
- Codebook image
    - Build Codebook image
    - Publish Codebook image(only with repo tag push)
- Worker images
    - Build CPU based worker images
    - Publish worker images(only with repo tag push)
    - GPU based worker image requires manually building and publishing on a dev GPU EC2 instance


#### Detailed Flow Diagram
![Image missing](./sciops_cicd.drawio.png)

## Setup and Usage
- Enable your personal fork pipeline
- Add Github Actions Secrets to your personal fork settings
    - BOT_SSH_KEY: sciops devops deploy key
    - REGISTRY_USERNAME: private registry username
    - REGISTRY_PASSWORD: private registry password
- Enable the main fork pipeline
- Add the same secrets to the main fork settings
- Do your development
- Push commits to your personal fork
    - This will trigger your personal fork's pipeline to run, and it will only run through the image building part of the pipeline as a test before you make a pull request
- Make a pull request to the main fork
    - This will trigger the main fork's pipeline to run, only run through the image building part as well to ensure the test before the pull request been merged
- Merge a pull request
    - This will trigger the main fork's pipeline, but actually redundant
- Push a tag to the main fork
    - This will trigger the main fork's pipeline and publish all the images to the private registry
- Update worker terraform image tag input
    - Check instruction [here](https://github.com/yambottle/dj-gitops/tree/main/infrastructures/tf/sciops_workers)

