#### Install
```shell
wget -O - https://raw.github.com/Ant0wan/conf/master/init.sh | bash
```

```shell
sh -c "$(wget https://raw.github.com/Ant0wan/conf/master/init.sh -O -)"
```

```shell
sh -c "$(curl -fsSL https://raw.github.com/Ant0wan/conf/master/init.sh)"
```


#### FDN (French Data Network) - an Open Recursive DNS to avoid Internet censorship
```shell
    ns0.fdn.fr : 80.67.169.12 or 2001:910:800::12 (DNSSEC validation)
    ns1.fdn.fr : 80.67.169.40 or 2001:910:800::40 (DNSSEC validation)
    DoT : ns0.fdn.fr and ns1.fdn.fr on port TCP/853
    DoH : https://ns0.fdn.fr/dns-query and https://ns1.fdn.fr/dns-query
```
 <sup>source: [fdn/actions/dns](https://www.fdn.fr/actions/dns/)


#### La Contre Voie - DoH Service
```shell
    DoH : https://doh.lacontrevoie.fr/dns-query
```
<sup>source: [lacontrevoie/technique/services/doh](https://docs.lacontrevoie.fr/technique/services/doh/)
