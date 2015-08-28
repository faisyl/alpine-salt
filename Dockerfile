FROM faisyl/alpine-runit:edge

RUN  apk --update add python py-msgpack py-yaml py-jinja2 py-pip\
     py-requests py-zmq py-crypto py-m2crypto docker && \
     pip install apache-libcloud && rm -rf /var/cache/apk/*
     
ADD salt-minion.runit /etc/service/salt-minion/run
RUN chmod a+x /etc/service/salt-minion/run

RUN curl -o /tmp/salt-2015.8.0rc2.tar.gz https://pypi.python.org/packages/source/s/salt/salt-2015.8.0rc2.tar.gz && \
        tar -C /tmp -zxf /tmp/salt-2015.8.0rc2.tar.gz && \
	cd /tmp/salt-2015.8.0rc2 && python setup.py install
	
CMD ["/sbin/my_init"]

