# Infrastructure As Code

## Packer

```bash
docker run --rm --privileged -v /dev:/dev -v ${PWD}:/build mkaczanowski/packer-builder-arm:1.0.7 build \
    -var "username=kooka" \
    -var "password=<INSERT PASSWORD>" \
    -var "ssh-public-key=\"$(cat ~/.ssh/id_rsa.pub)\"" \
    packer/raspi
```

## OctoDNS

```bash
cd dns
python3 -m venv env
source env/bin/activate
pip install octodns octodns-bind octodns-cloudflare
octodns-sync --config-file=./config.yaml --doit
```

## Ansible

```bash
cd ansible
python3 -m venv env
source env/bin/activate
pip install ansible ansible-lint
ansible-galaxy collection install -r requirements.yml
ansible-playbook deploy_rasp.yml --ask-become-pass
```
