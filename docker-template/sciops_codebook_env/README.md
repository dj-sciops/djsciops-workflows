# SciOps Codebook Profile Image

File tree: 
```
/djsciops-cicd
    /docker-template
        /codebook_env
            /dist
            example.env
```

## Local Build and Test
- Add a `.env` file following the same template of `example.env`
- Add a `dj-sciops-devops-bot.pem` key file (On LastPass) if you want to build and test the main fork workflow or add your own github ssh key if you want to build and test your own fork workflow
- Make the file tree like this:
```
/djsciops-cicd
    /docker-template
        /codebook_env
            /dist
            example.env
            .env
            dj-sciops-devops-bot.pem
```
- Then you can run
```
cd ./docker-template/codebook_env
set -a
source .env
docker-compose -f dist/debian/docker-compose-codebook_env.yaml build
```

## Update Workflow Installation On Codebook Environment
- Open a terminal
- Install vim `echo "vim" >> /tmp/apt_requirements.txt && /entrypoint.sh echo "Installed"`
- Add your own github private key to codebook `/home/your_user/.ssh/id_<rsa | ed25519>`
- Then you can clone your own workflow fork, dev/test and push on codebook
