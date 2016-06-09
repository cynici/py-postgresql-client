# PostgreSQL client and Python psycopg2

This repo provides the current release of PostgreSQL client with Python modules [psychopg2](http://initd.org/psycopg/), gevent (and friends) in a small footprint Docker image.

You may ignore the Python bits and use it to run commandline *psql*. Alternatively, add a bit of your own Python code to run a [light-weight and performant](http://www.gevent.org/) production HTTP server using [gevent-pywsgi](http://www.gevent.org/gevent.pywsgi.html)

It includes [gosu](https://github.com/tianon/gosu) so your code need not run as *root* user for better runtime security. To use gosu, simply set [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint) to use wrapper shell script like the example *docker-entrypoint.sh*.
