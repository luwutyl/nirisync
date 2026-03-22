#!/usr/bin/env bash

################################################################################
# niri scratchpad with slide animation
################################################################################

SCRATCH_WORKSPACE_NAME=

SEARCH_METHOD_FLAG=$1
SCRATCH_WIN_NAME=$2
SPAWN_FLAG=$3
PROCESS_NAME=$4

ANIM_OFFSET=-800
ANIM_XSET=468
ANIM_DELAY=0.12

showHelp() {
  echo "[niri-scratchpad]"
  echo ""
  echo "Open scratchpad app by app-id:"
  echo "  niri-scratchpad spotify"
  echo "  niri-scratchpad --app spotify"
  echo ""
  echo "Open scratchpad by title:"
  echo "  niri-scratchpad --title Telegram"
  echo ""
  echo "Spawn process if not running:"
  echo "  niri-scratchpad --app spotify --spawn spotify"
}

windows=$(niri msg -j windows)

case $SEARCH_METHOD_FLAG in
"--app")
  app_window=$(echo "$windows" | jq ".[] | select(.app_id == \"$SCRATCH_WIN_NAME\")")
  ;;
"--title")
  app_window=$(echo "$windows" | jq ".[] | select(.title == \"$SCRATCH_WIN_NAME\")")
  ;;
"--help")
  showHelp
  exit 0
  ;;
*)
  SCRATCH_WIN_NAME=$1
  app_window=$(echo "$windows" | jq ".[] | select(.app_id == \"$SCRATCH_WIN_NAME\")")
  ;;
esac

win_id=$(echo "$app_window" | jq .id)

################################################################################
# spawn if window doesn't exist
################################################################################

if [[ -z $win_id ]]; then
  if [[ $SPAWN_FLAG == "--spawn" ]]; then
    niri msg action spawn -- $PROCESS_NAME
    exit 0
  else
    showHelp
    exit 1
  fi
fi

################################################################################
# animation: hide window
################################################################################

moveWindowToScratchpad() {

  niri msg action move-window-to-floating --id "$win_id"

  # slide window up
  niri msg action move-floating-window --id "$win_id" -x $ANIM_XSET -y $ANIM_OFFSET

  sleep $ANIM_DELAY

  # move to scratch workspace
  niri msg action move-window-to-workspace \
    --window-id "$win_id" "$SCRATCH_WORKSPACE_NAME" \
    --focus=false
}

################################################################################
# animation: show window
################################################################################

bringScratchpadWindowToFocus() {

  niri msg action move-window-to-monitor --id "$win_id" "$output_id"
  niri msg action move-window-to-workspace --window-id "$win_id" "$work_idx"

  niri msg action move-window-to-floating --id "$win_id"

  # place window above screen
  niri msg action move-floating-window --id "$win_id" -x $ANIM_XSET -y 50

  sleep 0.05

  # move to center
  #  niri msg action center-window --id "$win_id"

  niri msg action focus-window --id "$win_id"
}

################################################################################
# main logic
################################################################################

if [[ $(echo "$app_window" | jq .is_focused) == "false" ]]; then

  focused_workspace=$(niri msg -j workspaces | jq '.[] | select(.is_focused == true)')

  work_id=$(echo "$focused_workspace" | jq .id)
  work_idx=$(echo "$focused_workspace" | jq .idx)
  output_id=$(echo "$focused_workspace" | jq -r .output)

  win_work_id=$(echo "$app_window" | jq .workspace_id)
  win_output=$(echo "$app_window" | jq .output)

  win_work_id_global=$(niri msg -j workspaces |
    jq ".[] | select(.idx == $win_work_id and .output==$win_output)" |
    jq .id)

  if [[ "$win_work_id_global" == "$work_id" ]]; then
    moveWindowToScratchpad
  else
    bringScratchpadWindowToFocus
  fi

else
  moveWindowToScratchpad
fi
