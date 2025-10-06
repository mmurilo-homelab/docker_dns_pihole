# docker_dns_pihole
dns with pihole

## Usage

### Bootstrap

```bash
wget -O - https://raw.githubusercontent.com/mmurilo-homelab/docker_dns_pihole/refs/heads/main/boostrap.sh | bash
```


### Pihole Configuration

```ini
FTLCONF_dns_upstreams=<some_upstream>
FTLCONF_webserver_api_password=<some_password>
FTLCONF_dns_domain=mydomain.com
FTLCONF_dns_hosts="
192.168.1.20 service1.mydomain.com
192.168.1.21 service2.mydomain.com
"
FTLCONF_dns_cnameRecords="
nicename.mydomain.com,service1.mydomain.com
nicename2.mydomain.com,service2.mydomain.com
"
```

* DNS hosts format:

`<some_ip> <some_name>`

* CNAME format

`<some_cname>,<some_dns_host>`
