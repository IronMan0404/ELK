# Install Kibana with RPM

## Import the Elastic PGP key

We sign all of our packages with the Elastic Signing Key (PGP key D88E42B4, available from https://pgp.mit.edu) with fingerprint:


Download and install the public signing key:

`rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch`


## Installing from the RPM repository
Create a file called kibana.repo in the `/etc/yum.repos.d/` directory for RedHat based distributions, or in the `/etc/zypp/repos.d/` directory for OpenSuSE based distributions, containing:


```bash
[kibana-8.x]
name=Kibana repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```

And your repository is ready for use. You can now install Kibana with one of the following commands:

`sudo yum install kibana`



**Run Kibana with `systemd`**

```bash
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
```

Kibana can be started and stopped as follows:

```bash
sudo systemctl start kibana.service
sudo systemctl stop kibana.service
```

**Update Kibana configuration file**
- server.port:5601
- server.host: private-ip 
- elasticsearch.hosts: ["https://Ip-address:9200"]
- elasticsearch.username: "kibana_system"
- elasticsearch.password: "pass"
- elasticsearch.ssl.certificateAuthorities: [ give your ssl certificates path here]  # "/etc/kibana/certs/http_ca.crt

-- Note: Please copy the same certificate from the elasticsearch and copy in Kibana certs folder 

before copy the certs from the elasticsearch create an directory in Kibana
**Secure Copy using SCP**:

```bash
scp /etc/elasticsearch/certs/https_ca.crt  root@ip-address:/etc/kibana/certs
```
