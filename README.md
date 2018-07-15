### Resources
- [Docker Hub repository](https://registry.hub.docker.com/u/kalaksi/ca-certificates/)
- [GitHub repository](https://github.com/kalaksi/docker-ca-certificates)

### What is this container for?
Basically, this container installs ```ca-certificates``` package and runs ```update-ca-certificates```.  
It separates the management of OS's CA certificates and allows you to add your own certificates too.  
  
For example, if you need to use LDAPS or connect using HTTPS inside the container, you'll need to have the certificates available for verification,
but it's not sensible to do the management in each container separately.  
  
Also, see [Design Goals](#design-goals) further down.

### Supported tags
See the ```Tags``` tab on Docker Hub for specifics. Basically you have:
- The default ```latest``` tag that always has the latest changes.
- Minor versioned tags (follow Semantic Versioning), e.g. ```1.0``` which would follow branch ```1.0.x``` on GitHub.
- Debian is the default base system, but a separate ```1.0-alpine``` tag is provided for CA certificates from Alpine Linux. Both systems produce the same kind of structure for /etc/ssl/certs that can be used at least with Debian and Alpine.

### Using this container

Mount a volume to ```/etc/ssl/certs```. It will be populated with the certificates and symlinks after running the container.  
Mount the same volume to another container and it will then have usable CA certificates (can be mounted read-only).
  
As usual, check the ```docker-compose.yml``` file to see specifics on how to run this container.

### Development
#### Design Goals
- Never run as root unless necessary.
- Use only official base images.
- Provide an example ```docker-compose.yml``` that also shows what CAPabilities can be dropped.
- Offer versioned tags for stability.
- Try to keep everything in the Dockerfile (if reasonable, considering line count and readability).
- Don't restrict configuration possibilities: provide a way to use native config files for the containerized application.
- Handle signals properly.


#### Contributing
See the repository on <https://github.com/kalaksi/docker-ca-certificates>.
All kinds of contributions are welcome!

### License
View [license information](https://github.com/kalaksi/docker-ca-certificates/blob/master/LICENSE) for the software contained in this image.
As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
