FROM lambci/lambda:build-python3.7

# comment

# WORKDIR /opt
# RUN curl -S -o postgresql-11.6.tar.gz -L https://ftp.postgresql.org/pub/source/v11.6/postgresql-11.6.tar.gz \
#     && curl -S -o psycopg2-2_8_4.tar.gz -L https://github.com/psycopg/psycopg2/archive/2_8_4.tar.gz \
#     && tar -xzvf postgresql-11.6.tar.gz \
#     && tar -xzvf psycopg2-2_8_4.tar.gz

# WORKDIR /opt/postgresql-11.6
# RUN ./configure --prefix=/opt/pgsql --with-python --with-openssl \
#     && make \
#     && make install

# ENV PATH="${PATH}:/opt/pgsql/bin"

# WORKDIR /opt/psycopg2-2_8_4
# RUN sed -i -e 's#^pg_config=$#pg_config=/opt/pgsql/bin/pg_config#' \
#               -e 's#^static_libpq=0$#static_libpq=1#' \
#               -e 's#^libraries=$#libraries=ssl crypto#' setup.cfg \
#     && python setup.py build \
#     && python setup.py install

# WORKDIR /opt
# RUN rm postgresql-11.6.tar.gz \
#     && rm -rf postgresql-11.6 \
#     && rm psycopg2-2_8_4.tar.gz \
#     && rm -rf psycopg2-2_8_4

# WORKDIR /var/task
RUN python -m pip install Django==3.0.2 django-storages==1.8 psycopg2-binary==2.8.4 werkzeug==0.16.0 --upgrade -t /opt/python
