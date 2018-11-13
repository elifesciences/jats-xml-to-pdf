# JATS->PDF

A review of the current state of automated JATS XML to PDF conversion tools.

## goals

* evaluate suitable *open source* tools
* test ~10 representative articles
* state a recommendation
* state why others should not be recommended

## dimensions

1. ease. how convenient is it to style the PDF?
2. precision. how closely can we affect the PDF?
3. speed. how fast was the transformation?
4. stability. how often is the technology stack changing?

## targets

* pandoc
* cassius
* official jats-xslt-stylesheets
* peerj XML->HTML conversion

## results

See [results](report.md) ([pdf](report.pdf))

## installation

Requirements

* Docker. Used to describe each candidate's environment
* public eLife article data

## running all transformations

Article data can be downloaded with:

    ./download-articles.sh
    
The initial environment can be built with:

    ./run.sh

This will build the Docker images and create a file `built.flag` that prevents the containers from being built again by `./run.sh`.

Use `./run.sh` again to start the generation/testing process.

Generated pdf files are copied to the directory `./pdf/` as `<transformer>--<article-id>.pdf`.

stdout and stderr are written to `./log/` as `<transformer>--<article-id>.log`

## running individual transformations

Each candidate has it's own `build.sh`, `run.sh`, `shell.sh` and `transform.sh` scripts.

* `./build.sh` tells Docker to build the current Dockerfile
* `./run.sh` accepts an input xml file or article directory and an output pdf filename
* `./transform.sh` is copied into the container during the build and executed during the run`
* `./shell.sh` will drop you into a shell within the Docker container for debugging

For example:

    cd pandoc
    ./build.sh
    ./run.sh /path/to/article.xml article.pdf

or

    ./run.sh /path/to/article article.pdf
    
If the directory syntax is used, then the expected XML filename must look like `elife-<article-id>-v1.xml`.

The artifacts of a transformation live in the `./mnt` directory. This directory is shared with the Docker container and 
is available within the container as `/mnt` (note the missing leading `.`). This directory is also purged before each 
run, so any adhoc output will be lost.

## printcss.rocks examples

The [print-css.rocks](https://print-css.rocks) website is an advocacy site for HTML+CSS Paged Media and it's github page 
has a number of 'lessons' demonstrating Paged Media techniques.

These examples can be built using the script `./build-print-css-rocks-example.sh`.

The [current results](./paged-media-pdf) using `wkhtmltopdf` are probably mostly broken.

