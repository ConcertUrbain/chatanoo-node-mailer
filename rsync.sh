#!/bin/bash
rsync -avz --delete -e ssh . "root@ns368978.ovh.net:/var/www/vhosts/chatanoo.org/core/mailer/prod" --exclude-from 'rsync.exclude'