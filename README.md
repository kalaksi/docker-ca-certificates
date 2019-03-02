## Resources
- [Docker Hub repository](https://registry.hub.docker.com/u/kalaksi/ca-certificates/)
- [GitHub repository](https://github.com/kalaksi/docker-ca-certificates)

## What is this container for?
Basically, this container installs Debian's ```ca-certificates``` package and runs ```update-ca-certificates``` while allowing you to add your own certificates to the mix, too.
This way, you can configure and generate the CA certificate structure in a separate container. The result is a certificate directory that can be used inside other containers.
  
This is necessary if you use, for example, LDAPS or HTTPS connections inside a container and therefore need to have the CA certificates available for certificate verification. It is not sensible to install the necessary packages or certificates for each such container separately.

|Requirement              |Status|Details|
|-------------------------|:----:|-------|
|Don't run as root        |✅    | Never run as root unless necessary.|
|Official base image      |✅    | |
|Drop extra CAPabilities  |✅    | See ```docker-compose.yml``` |
|No default passwords     |✅    | No static default passwords. That would make the container insecure by default.|
|Handle signals properly  |✅    | |
|Simple Dockerfile        |✅    | Keep everything in the Dockerfile if reasonable.|
|Versioned tags           |✅    | Offer versioned tags for stability.|

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
- Debian is the default base system, but a separate ```1.0-alpine``` tag should be provided for CA certificates from Alpine Linux. Both systems produce the same kind of structure for /etc/ssl/certs that can be used at least with Debian and Alpine.

### Contributing
See the repository on <https://github.com/kalaksi/docker-ca-certificates>.
All kinds of contributions are welcome!

## License
View [license information](https://github.com/kalaksi/docker-ca-certificates/blob/master/LICENSE) for the software contained in this image.
As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
