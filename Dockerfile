FROM golang:1.22-alpine as builder

## The RUN command is used to run commands as you would in a shell.
RUN mkdir /app

## Here, you are copying the whole content of your current directory (your Go code) to the /app directory.
COPY . /app

# This changes the working directory for any subsequent COPY, CMD, ENTRYPOINT, or RUN instructions
WORKDIR /app

# This runs the go build command which compiles your Go code into a single, statically linked binary
# called small-app.
RUN go build -o small-ecs-app .

RUN chmod +x /app/small-ecs-app
FROM alpine:latest

RUN mkdir /app

# Here, you're copying the compiled binary file small-app from the "builder" stage to the /app directory in the current stage.
COPY --from=builder /app/small-ecs-app /app

# This provides the command to be executed when Docker runs your image.
CMD [ "/app/small-ecs-app" ]