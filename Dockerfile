FROM lambci/lambda:build-python3.7

ADD https://ftp.postgresql.org/pub/source/v11.6/postgresql-11.6.tar.gz /opt/
ADD https://github.com/psycopg/psycopg2/archive/2_8_4.tar.gz /opt/

WORKDIR /opt/postgresql-11.6
RUN ./configure --prefix=/opt/pgsql --with-python --with-openssl \
    && make \
    && make install \
    && rm -rf ../postgresql-11.6

ENV PATH="${PATH}:/opt/pgsql/bin"

WORKDIR /opt/psycopg2-2_8_4
RUN sed -i -e 's#^pg_config=$#pg_config=/opt/pgsql/bin/pg_config#' \
              -e 's#^static_libpq=0$#static_libpq=1#' \
              -e 's#^libraries=$#libraries=ssl crypto#' setup.cfg \
    && python setup.py build \
    && python setup.py install \
    && rm -rf ../psycopg2-2_8_4

WORKDIR /var/task
