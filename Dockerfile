# Copyright (c) 2018 kalaksi@users.noreply.github.com.
# This work is licensed under the terms of the MIT license. For a copy, see <https://opensource.org/licenses/MIT>.

FROM debian:12.10-slim
LABEL maintainer="kalaksi@users.noreply.github.com"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /etc/ssl/certs/* && \
    mkdir /additional_certs

VOLUME /etc/ssl/certs

# Use environment variables CA_CERT_0, CA_CERT_1, ... to add your own certs,
# or mount additional certs to /additional_certs, or do both.
# You can set the filename for e.g. CA_CERT_0 by using environment variable CA_CERT_0_NAME.
# Naming certs like this also helps to identify them later on.
ENTRYPOINT set -eu; \
    cp -a /additional_certs/. /usr/local/share/ca-certificates/; \
    CERT_VARS=$(env | cut -d '=' -f 1 | (egrep '^CA_CERT_[0-9]+$' || true)); \
    for cert_var in $CERT_VARS; do \
        # Indirect variable expansion, same as ${!cert_var} in bash
        cert_contents="$(eval echo \"\$$cert_var\")"; \
        # Check if e.g. CA_CERT_0_NAME variable exists and if not, use "CA_CERT_0" as the filename
        eval "cert_filename=\${${cert_var}_NAME:-$cert_var}"; \
        filename="/usr/local/share/ca-certificates/${cert_filename}.crt"; \
        echo "$cert_contents" > "$filename"; \
    done; \
    # Clean up old certs. Everything should be managed by this container.
    rm -rf /etc/ssl/certs/*; \
    update-ca-certificates; \
    # To make things easier, we replace the symlinks under /etc/ssl/certs that point to /usr/...
    # with actual copies. This way we only need to mount /etc/ssl/certs on other containers and
    # it will be a self-contained system.
    find /etc/ssl/certs/ -type l -exec readlink -z -f {} \; | sort -z | uniq  -z | xargs -0 -r -n1 sh -c ' \
        new_name=$(basename "$0" | sed '\''s/\.crt$/\.pem/'\''); \
        cp --remove-destination -v "$0" "/etc/ssl/certs/$new_name"; \
        '
