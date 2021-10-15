#!/usr/bin/env bash

DIR="/var/html"

main() {

  local domain_list

  domain_list="$(mktemp)"

  local webserver

  if [[ -e "/etc/centos-release" ]]; then
    webserver="httpd"
  elif [[ -e "/etc/debian_version" ]]; then
    webserver="apache2"
  else
    echo "Unrecognized operating system [RedHat/Debian]"
    exit 1
  fi

  ls -1 $DIR > "$domain_list"
  while read -r domain; do
    if [[ ! -d /etc/letsencrypt/archive/www."$domain" && ! -d /etc/letsencrypt/archive/"$domain" ]]; then
      certbot -n --apache -d "$domain" -d www."$domain"
    fi
    if [[ -e /etc/"$webserver"/sites-available/"$domain"-le-ssl.conf && ! -e /etc/"$webserver"/sites-enabled/"$domain"-le-ssl.conf ]]; then
      ln -s /etc/"$webserver"/sites-available/"$domain"-le-ssl.conf /etc/"$webserver"/sites-enabled/"$domain"-le-ssl.conf
    fi
  done < "$domain_list"
  rm -f "$domain_list"
}
main "${@}"
