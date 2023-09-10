## Import the Elasticsearch GPG Key edit

We sign all of our packages with the Elasticsearch Signing Key (PGP key D88E42B4, available from https://pgp.mit.edu) with fingerprint:

 **Download and install the public signing key:**
```bash
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
```

**Installing from the RPM repository**

<p>
Create a file called elasticsearch.repo in the /etc/yum.repos.d/ directory for RedHat based distributions, or in the /etc/zypp/repos.d/ directory for OpenSuSE based distributions, containing:
</p>

```bash
[elasticsearch]
name=Elasticsearch repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=0
autorefresh=1
type=rpm-md
```

And your repository is ready for use. You can now install Elasticsearch with one of the following commands:

``` bash
sudo yum install --enablerepo=elasticsearch elasticsearch
```


**Download and install the RPM manually**

```bash



wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.9.2-x86_64.rpm
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.9.2-x86_64.rpm.sha512
shasum -a 512 -c elasticsearch-8.9.2-x86_64.rpm.sha512 
sudo rpm --install elasticsearch-8.9.2-x86_64.rpm
```

**Running Elasticsearch with `systemd`**
To configure Elasticsearch to start automatically when the system boots up, run the following commands:

```bash
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
```

Elasticsearch can be started and stopped as follows:

```bash
sudo systemctl start elasticsearch.service
sudo systemctl stop elasticsearch.service
```





Ensure that you use https in your call, or the request will fail.

`--cacert`
    Path to the generated `http_ca.crt` certificate for the HTTP layer. 

The call returns a response like this:
```json


{
  "name" : "Cp8oag6",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "AT69_T_DTp-1qgIJlatQqA",
  "version" : {
    "number" : "8.9.2",
    "build_type" : "tar",
    "build_hash" : "f27399d",
    "build_flavor" : "default",
    "build_date" : "2016-03-30T09:51:41.449Z",
    "build_snapshot" : false,
    "lucene_version" : "9.7.0",
    "minimum_wire_compatibility_version" : "1.2.3",
    "minimum_index_compatibility_version" : "1.2.3"
  },
  "tagline" : "You Know, for Search"
}
```


**Update default password for elasticsearch**

```  /usr/share/elasticsearch/bin/elasticsearch-reset-password -i -u elastic```

-  it will promt to password 


**Check that Elasticsearch is running**

You can test that your Elasticsearch node is running by sending an `HTTPS` request to port `9200` on localhost:

```bash
curl --cacert /etc/elasticsearch/certs/http_ca.crt -u elastic:$ELASTIC_PASSWORD https://localhost:9200 
```


# Update elasticsearch configurations:

```bash 

nano /etc/elasticsearch/elasticsearch.yml
```

Enable below:
- node.name: my-node-name
- network.host: private-ip
- http:port: 9200
