#! /bin/bash

rm -qf /var/db/.applesetupdone || true
(find / -type f -iname ".DS_Store" -print0 2>/dev/null | xargs -0 -L1 -I{} rm -qf "{}" 2>/dev/null ) || true

exit 0