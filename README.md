# Jupyter Multi Kernel Notebook [Python, JavaScript, Golang]

This repository provides Docker configurations for running Jupyter Notebook environments with support for multiple programming languages (Python, JavaScript, Golang).

**base images:**
- https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
- https://github.com/jupyter/docker-stacks

## Running with Docker Compose

Alternatively, you can use the included `docker-compose.yml` file for easier setup. This file allows you to configure and run the images using a single command.

1. Clone the repository:

```bash
git clone <repository_url>
cd <repository_folder>
```

2. Modify the `docker-compose.yml` file if needed to adjust port mappings or volume paths.

3. Run the services:

```bash
docker-compose up
```

This will start the Jupyter Notebook environment, accessible at `http://localhost:8888`.

## Included Files

- **Dockerfile**: Used to build the Docker images from scratch.
- **docker-compose.yml**: Used to define and run multi-container Docker applications.

## Accessing Jupyter

Once the container is running, you can access the Jupyter Notebook interface by opening a web browser and navigating to `http://localhost:<host_port>`. You will be prompted to enter a token, which can be found in the container logs.
