# CRAN

## INTRODUCTION
A rake task that indexes CRAN packages with a basic web interface and cron scheduler for running the task periodically.

## DONT KNOW CRAN?
CRAN is a network of ftp and web servers around the world that store identical, up-to-date, versions of code and documentation for R. The use these CRAN Servers to store the R packages.

A CRAN [server](http://cran.r-project.org/src/contrib/) is just a simple Apache Dir with a bunch of `tar.gz` files.

Every CRAN server contains a plain file listing all packages in that server.

A package can be accessed via

```
http://cran.rproject.org/src/contrib/[PACKAGE_NAME]_[PACKAGE_VERSION].tar.gz
```

A package contains a description file, that contains info about the package.

## WHAT DOES THIS INDEXER DO?

* Extract useful info from the `PACKAGES` file of the CRAN server.
* Extract certain info from the `DESCRIPTION` file of each package.
* On every run of the `task`, for the first 50 packages, store info about each package, author(s) and maintainers(s).
* Prevents duplicate indexes of a version of same package.
* I used [Whenever](https://github.com/javan/whenever/) for scheduling the task. If you use Heroku, Heroku scheduler should do just fine.


## RUN IT MANUALLY
```
rails packages:index
```


## SPECS
```
bundle exec rspec
```

## IMPROVEMENTS?
* Pagination for listing packages.
* I currently use [DCF](https://github.com/bmaland/treetop-dcf) for converting the content of the PACKAGES & DESCRIPTION file to hashes. Maybe I could use a faster library but this does the job as well :)
* More, more and more

