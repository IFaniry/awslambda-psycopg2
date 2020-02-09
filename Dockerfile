FROM lambci/lambda:build-python3.7

RUN curl -S -o /opt/postgresql-11.6.tar.gz https://ftp.postgresql.org/pub/source/v11.6/postgresql-11.6.tar.gz \
    && curl -S -o /opt/psycopg2-2_8_4.tar.gz https://github.com/psycopg/psycopg2/archive/2_8_4.tar.gz \
    && tar --directory /opt -xvzf /opt/postgresql-11.6.tar.gz \
    && tar --directory /opt -xvzf /opt/psycopg2-2_8_4.tar.gz

WORKDIR /opt/postgresql-11.6
RUN ./configure --prefix=/opt/pgsql --with-python --with-openssl \
    && make \
    && make install

ENV PATH="${PATH}:/opt/pgsql/bin"

WORKDIR /opt/psycopg2-2_8_4
RUN sed -i -e 's#^pg_config=$#pg_config=/opt/pgsql/bin/pg_config#' \
              -e 's#^static_libpq=0$#static_libpq=1#' \
              -e 's#^libraries=$#libraries=ssl crypto#' setup.cfg \
    && python setup.py build \
    && python setup.py install

RUN rm /opt/postgresql-11.6.tar.gz \
    && rm -rf ../postgresql-11.6
    && rm /opt/psycopg2-2_8_4.tar.gz \
    && rm -rf ../psycopg2-2_8_4

WORKDIR /var/task
