# JATS->PDF

A review of the current state of automated JATS XML to PDF conversion tools.

## goals

* evaluate suitable *open source* tools
* test ~10 representative articles
* state a recommendation
* state why others should not be recommended

## dimensions

* speed - average speed from XML->PDF
* complexity - number of technologies involved
* extensibility - modifying the technologies to alter the PDF appearance
* robustness - how well the stack handles errors and a variety of inputs
* support - likelihood of finding answers to difficult questions

## targets

* pandoc
* cassius
* official jats-xslt-stylesheets

## results

See [results](results.md)

## installation

Requirements

* Docker is used to describe the environments each candidate is run in
* public eLife article data

## running all transformations

Article data can be downloaded with:

    ./download-articles.sh
    
The initial environment can be built with:

    ./run.sh

This will build the Docker images and create a file `built.flag` that prevents the containers from being built by `./run.sh` again.

Use `./run.sh` again to start the testing process.

Generated pdf files are copied to the directory `./pdf/` as `transformer--article-id.pdf`.

stdout and stderr are written to `./log/` as `transformer--article-id.log`

## running individual transformations

Each candidate has it's own `build.sh`, `run.sh`, `shell.sh` and `transform.sh` scripts.

* `./build.sh` will tell Docker to build the current Dockerfile
* `./run.sh` accepts an input xml file or article directory and an output pdf filename
* `./transform.sh` is copied into the container during the build and executed during the run`
* `./shell.sh` will drop you into a shell within the Docker container for debugging

For example:

    cd pandoc
    ./build.sh
    ./run.sh /path/to/article.xml article.pdf

The artifacts of a transformation live in the `./mnt` directory. This directory is shared with the Docker container and
is available within the container as `/mnt` (note the missing leading `.`).

