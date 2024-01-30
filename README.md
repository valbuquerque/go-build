# go-build
Basic example to build a go docker image, with image optimization. 

Here I made a simple multistage build for a "hello-world" GO app. 

The basic process was: 
- Find a Hello-world app written in GO;
- Find a official golang image on Docker Hub;
- Create a Dockerfile with two stages, one for build and other for create de final image;
- Run de docker build process;
- Send image to my Docker Hub.

### This is what I did: 
```
#build stage
FROM golang:1.21 AS build

WORKDIR /app

COPY full.go .

RUN go build full.go

#final image stage
FROM scratch

WORKDIR /app

COPY --from=build /app/full .

CMD ["./full"]
```

What I call 'build stage', is the basic process of:
- Download the golang:1.21 from Docker Hub and set a nickname for this stage, what I choose to call build;
- Defined a work directory, where I'd copy the GO source-code, called 'full.go';
- I ran the 'go build' command on the current work directory, the dot (.) in the end is part of the command;
- And... 

In the same Dockerfile I've configured what I called 'final image stage':
- Made use of 'scratch' docker image, it's a special image for build containers;
- Set a work directory, like on the first stage;
- Copy everything from the first stage, using the '--from=' option 
- The last and most important, set the command to run de app. 

### Running the app from docker hub

Just download the Docker image from: 
https://hub.docker.com/r/victorfba/fullcycle 

You can use the following command to download the docker image:
```
docker pull victorfba/fullcycle:1.0
```

And run it with: 
```
docker run victorfba/fullcycle:1.0
```

This was a exercise from Full Cycle, all the code was created by me, so... hope it helps :) 

cya. 