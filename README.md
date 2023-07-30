# Infrastructure As Code

## Packer

```bash
docker run --rm --privileged -v /dev:/dev -v ${PWD}:/build mkaczanowski/packer-builder-arm:1.0.7 build \
    -var "username=kooka" \
    -var "password=<INSERT PASSWORD>" \
    -var "ssh-public-key=\"$(cat ~/.ssh/id_rsa.pub)\"" \
    packer/raspi
```
