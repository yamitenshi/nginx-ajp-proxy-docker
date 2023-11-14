# AJP proxy using Nginx, in docker

Ever seen an exposed AJP port and wanted to exploit it? Can't be arsed to compile Nginx from source or rebuild a docker container for every target? I gotchu.

**WARNING: NOT FOR PRODUCTION USAGE, POTENTIALLY UNSAFE, THIS IS A PENTESTING TOOL**

## How to build

```bash
$ docker build . -t nginx-ajp-proxy
```

## How to use

The container has two environment variables to use:

- `TARGET_IP` is the IP address of the target machine (required)
- `TARGET_PORT` is the port on which AJP is exposed on the target machine (optional, defaults to 8009)

Nginx is running on port 80 within the container

Run the container:

```bash
$ docker run -e TARGET_IP=1.2.3.4 -e TARGET_PORT=1234 -p 80:80 nginx-ajp-proxy
```

This opens up port 80 on your machine and lets you access AJP running on port 1234 on the machine at 1.2.3.4.
Just point your browser to `http://localhost/` and you should see whatever it's serving!
