## Resources
- [GitLab repository](https://gitlab.com/kalaksi-containers/ca-certificates/) (image: `registry.gitlab.com/kalaksi-containers/ca-certificates`)
- [Docker Hub repository](https://hub.docker.com/r/kalaksi/ca-certificates/) (image: `docker.io/kalaksi/ca-certificates`)
- [GitHub repository](https://github.com/kalaksi/docker-ca-certificates)

## What is this container for?
Basically, this container installs Debian's ```ca-certificates``` package and runs ```update-ca-certificates``` while allowing you to add your own certificates to the mix, too.
This way, you can configure and generate the CA certificate structure in a separate container. The result is a certificate directory that can be used inside other containers.
  
This is necessary if you use, for example, LDAPS or HTTPS connections inside a container and therefore need to have the CA certificates available for certificate verification. It is not sensible to install the necessary packages or certificates for each such container separately.

|Requirement                   |Status|Details|
|------------------------------|:----:|-------|
|Don't run container as root   |❌    | ```update-ca-certificates``` is naturally run as root. No effort has been made to run it as non-root (that would be ideal, though). This container contains only core components of the OS.|
|Transparent build process     |✅    | For verifying that the container matches the code. See GitLab CI. |
|Official base image           |✅    | |
|Drop extra CAPabilities       |✅    | See ```docker-compose.yml``` |
|No default passwords          |✅    | No static default passwords. That would make the container insecure by default. |
|Support secrets-files         |✅    | Support providing e.g. passwords via files instead of environment variables. |
|Handle signals properly       |✅    | |
|Simple Dockerfile             |✅    | No overextending the container's responsibilities. And keep everything in the Dockerfile if reasonable. |
|Versioned tags                |✅    | Offer versioned tags for stability.|

## Supported tags
See the ```Tags``` tab on Docker Hub for specifics. Basically you have:
- The default ```latest``` tag that always has the latest changes.
- Minor versioned tags (follow Semantic Versioning), e.g. ```1.0``` which would follow branch ```1.0.x``` on GitHub.

## Using this container

Mount a volume to ```/etc/ssl/certs```. It will be populated with the certificates and symlinks after running the container.  
Mount the same volume to another container and it will then have usable CA certificates (can be mounted read-only).

Use environment variables ```CA_CERT_0```, ```CA_CERT_1```, ... to add your own certificates, or mount additional certs to ```/additional_certs```, or do both.  
You can set the filename for e.g. ```CA_CERT_0``` by using environment variable ```CA_CERT_0_NAME```. Naming certs like this also helps to identify them later on.  
  
As usual, check the ```docker-compose.yml``` file to see specifics on how to run this container.

## Development
### TODO
- Run as non-root?

### Contributing
See the repository on <https://github.com/kalaksi/docker-ca-certificates>.
All kinds of contributions are welcome!

## License
Copyright (c) 2018 kalaksi@users.noreply.github.com. See [LICENSE](https://github.com/kalaksi/docker-ca-certificates/blob/master/LICENSE) for license information.  

As with all Docker images, the built image likely also contains other software which may be under other licenses (such as software from the base distribution, along with any direct or indirect dependencies of the primary software being contained).  
  
As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
