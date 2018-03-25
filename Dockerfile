# wildfly-s2i
FROM fabric8/java-centos-openjdk8-jdk

MAINTAINER Gunnar Hillling <gunnar@hilling.de>
LABEL maintainer="Gunnar Hillling <gunnar@hilling.de>"
# TODO: Put the maintainer name in the image metadata
# LABEL maintainer="Your Name <your@email.com>"

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0
ENV WILDFLY_VERSION=12

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for serving wildfly applications" \
      io.k8s.display-name="Wildfly 12.x" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,wildfly,jee,java"

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y

# TODO (optional): Copy the builder files into /opt/app-root
# COPY ./<builder_folder>/ /opt/app-root/
RUN mkdir /opt/wildfly && chgrp -R 0 /opt/wildfly && chmod -R g=u /opt/wildfly

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# RUN chown -R 1001:1001 /opt/app-root

USER 1001

EXPOSE 8080

WORKDIR /opt/wildfly

CMD ["/usr/libexec/s2i/usage"]
