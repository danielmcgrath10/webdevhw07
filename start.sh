  #!/bin/bash

export MIX_ENV=prod
export PORT=4793

CFGD=$(readlink -f ~/.config/webdevhw07)

if [ ! -e "$CFGD/base" ]; then
    echo "run deploy first"
    exit 1
fi

DB_PASS=$(cat "$CFGD/db_pass")
export DATABASE_URL=ecto://photos:$DB_PASS@localhost/activity_planner_prod

SECRET_KEY_BASE=$(cat "$CFGD/base")
export SECRET_KEY_BASE

_build/prod/rel/webdevhw07/bin/webdevhw07 start