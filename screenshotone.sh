#!/usr/bin/env bash
# Take a screenshot of a website with ScreenshotOne API
#

set -euo pipefail

set -a
source .env
set +a

generate_api_url() {
  local base_url="https://api.screenshotone.com/take"
  local target_url="$1"
  local viewport_width="$2"
  local viewport_height="$3"
  local device_scale_factor="1"
  local block_cookie_banners=true
  local block_chats=true
  local block_ads=true
  local block_trackers=true
  local cache=true
  local access_key="$ACCESS_KEY"

  echo -n "${base_url}?"
  echo -n "url=${target_url}&"
  echo -n "viewport_width=${viewport_width}&"
  echo -n "viewport_height=${viewport_height}&"
  echo -n "device_scale_factor=${device_scale_factor}&"
  echo -n "block_cookie_banners=${block_cookie_banners}&"
  echo -n "block_chats=${block_chats}&"
  echo -n "block_ads=${block_ads}&"
  echo -n "block_trackers=${block_trackers}&"
  echo -n "cache=${cache}&"
  echo "access_key=${access_key}"
}

fetch_screenshot() {
  local api_url="$1"
  local output_filename="screenshot.jpg"
  curl -o "$output_filename" "$api_url"
}

main() {
  if [ $# -eq 0 ]; then
    echo "Usage: $0 <target_url>"
    exit 1
  fi

  local target_url="$1"
  local viewport_width="1300"
  local viewport_height="730"

  local api_url
  api_url="$(generate_api_url \
      "$target_url" \
      "$viewport_width" \
      "$viewport_height")"
  fetch_screenshot "$api_url"
}

main "$@"
