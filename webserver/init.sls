{% from "webserver/map.jinja" import apache with context %}

apache_pkgs:
  pkg.installed:
    - names: {{ apache.pkgs }}

apache_services:
  service.running:
    - names: {{ apache.services }}
    - enable: True
    - requrie:
      - pkg: apache_pkgs

/srv/www/htdocs/index.html:
  file.managed:
    - source: salt://webserver/files/index.html
    - template: jinja

/srv/www/htdocs/assets:
  file.recurse:
    - source: salt://webserver/files/assets
    
SuSEfirewall2:
  service.dead:
    - enable: False
