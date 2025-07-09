#!/bin/bash

# Setup environment
PROFILE_DIR="/etc/profile.d"

if [ -z "$EPX_HOME" ]; then
  EPX_HOME="/usr/local/epx"
fi

# Add EPX_HOME and source epx.sh to the profile.d script
EPX_BIN="$PROFILE_DIR/00-epx.sh"
if [[ ! -f "$EPX_BIN" ]]; then
  echo "Creating $EPX_BIN"
  echo "export EPX_HOME=\"/usr/local/epx\"" | sudo tee "$EPX_BIN" >/dev/null
  echo "source \"\$EPX_HOME/aliases.sh\"" | sudo tee -a "$EPX_BIN" >/dev/null
  echo "source \"\$EPX_HOME/autocomplete.sh\"" | sudo tee -a "$EPX_BIN" >/dev/null
else
  echo "$EPX_BIN already exists, skipping creation."
fi

source "$EPX_BIN"

# Setup crontab for epx self-update
CRON_FILE="/etc/cron.daily/epx-self-update"
if ! grep -qF "$CRON_JOB" "$CRON_FILE"; then
  echo "Adding self-update cron job to $CRON_FILE"
  echo "#!/bin/bash" | sudo tee "$CRON_FILE" >/dev/null
  echo "source $EPX_BIN" | sudo tee -a "$CRON_FILE" >/dev/null
  echo "epx self-update" | sudo tee -a "$CRON_FILE" >/dev/null
else
  echo "Self-update cron job already exists in $CRON_FILE, skipping addition."
fi

# Run linking script if it exists
if [ -f "$EPX_HOME/link.sh" ]; then
  echo "Running linking script..."
  "$EPX_HOME/link.sh"
else
  echo "Linking script not found, skipping."
fi
