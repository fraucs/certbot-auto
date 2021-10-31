# certbot-auto

This tool allows you to automate the installation of SSL certificates.

## Requirements

You need certbot as only requirement.
### Debian 
`apt install certbot -y`
### RedHat
`yum install certbot -y` or `dnf install certbot -y`

## Installation 
Installation of **certbot-auto** is so easy, just clone it with `git clone`.

After that move into /usr/bin (so you can use as command) `mv certbot-auto.sh /usr/bin/certbot-auto`.

Then verify that it is executable `chmod +x /usr/bin/certbot-auto.sh`.

So automate it! Install a crontab as this: `0 3 * * * /usr/bin/certbot-auto`.
