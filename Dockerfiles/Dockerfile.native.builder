FROM container-registry.oracle.com/graalvm/native-image-ee:latest as BUILDER

RUN mkdir -p /home/app
WORKDIR /home/app

COPY . /home/app
RUN ./mvnw package dependency:resolve
