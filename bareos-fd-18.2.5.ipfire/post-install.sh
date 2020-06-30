#!/bin/bash

/bin/mkdir -p /var/lib/bareos
/sbin/ldconfig
/etc/init.d/bareos-fd start
