# Code Maat unofficial Docker image

A Docker container to run the Code Maat tool provided by Adam Tornhill et al.  

[https://github.com/adamtornhill/code-maat](https://github.com/adamtornhill/code-maat)

Using this Docker image you don't need to follow all the steps to get a runnable version of Code Maat and when you are done just put this image into your trash bin.

## Usage 👇

### Pre-requisite  

To build the Docker image you need of course to set up Docker Engine on your local machine.
See [Installing Docker](https://docs.docker.com/engine/installation/)

On the Docker site you find information on how to manage and run Docker containers.

### Pull the Docker image

To leverage on a continuously prebuilt Docker image, simply pull it from Docker Hub:

```sh
docker pull mcmoe/code-maat
```

### Build the Docker image

To build a Code Maat image run  

```sh
docker build -t mcmoe/code-maat https://github.com/mcmoe/code-maat.git
```

The Docker image that is created downloads the code-maat Clojure repository and builds and exposes the code-maat jar file as an ENTRYPOINT in the image.

After the build is completed verify that it works by running

```sh
docker run --rm mcmoe/code-maat
```

and verify that the output is the help information on how to use Code Maat

```sh
This is Code Maat, a program used to collect statistics from a VCS.
Version: 1.0-SNAPSHOT

Usage: program-name -l log-file [options]

Options:
  -l, --log LOG                             Log file with input data
  -c, --version-control VCS                 Input vcs module type: supports svn, git, git2, hg, p4, or tfs
  ...
  -h, --help
Please refer to the manual page for more information.
```

### Generate input data

Code Maat analysis different version control systems (Git, Mercurial, Subversion and Perforce). You need to provide a log file to Code Maat to analyse and this is described under [Generating input data](https://github.com/adamtornhill/code-maat#generating-input-data)

For example to extract data from a Git project since 2015 

```sh
git log --pretty=format:'[%h] %aN %ad %s' --date=short --numstat --after=2015-01-01 > mygit.log
```

### Run Code Maat Docker image

To understand how to use code-maat with the different command line option see [Running Code Maat](https://github.com/adamtornhill/code-maat#running-code-maat)

For example to analyse the code age of your files

```sh
docker run --rm -v /Users/Jude/Documents/code-maat:/codemaat code-maat -l /codemaat/mygit.log -c git -a age
```

The log file `mygit.log` that you created earlier resides on the local system. To allow Code Maat to access you need to mount the local folder to the container using Docker's `-v` option.  
In the example above the `mygit.log` is located in `/Users/Jude/Documents/code-maat`. This is linked to the container directory `/codemaat` which is used when the log file is specified for Code Maat with `-l /codemaat/mygit.log`. You can specify any directory for the container when you mount as long as you use the same path for the `-l` option.

`--rm` is used to remove the Docker container after the analysis is done

### Contributions

To compile the Code Maat Clojure code, we leveraged on [Murphy McMahon's](https://github.com/pandeiro) work using [Leiningen](http://leiningen.org) in his [docker-lein](https://github.com/pandeiro/) repo.

[mcmoe/code-maat](https://github.com/mcmoe/code-maat) is a fork of the [code-maat](https://github.com/peternorrhall/code-maat) project by [Peter Norrhall](https://github.com/peternorrhall). It has been inactive since 2016, and has stopped building since at least 2019 - hence the fork.  

### License

Copyright © 2020 Morgan Kobeissi

Distributed under the Eclipse Public License either version 1.0 or (at
your option) any later version.
