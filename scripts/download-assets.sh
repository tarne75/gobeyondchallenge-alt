#!/usr/bin/env bash
# ============================================================
# Go Beyond Challenge — Image Asset Downloader
# Run this script once from the repo root to download all
# images from the original CDN to the local img/ directory.
#
# Usage:
#   cd /path/to/gobeyondchallenge
#   bash scripts/download-assets.sh
#
# Requirements: curl (pre-installed on macOS)
# ============================================================

set -e
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
IMG_DIR="$REPO_ROOT/img"
mkdir -p "$IMG_DIR"

BASE="https://www.gobeyondchallenge.com/wp-content/uploads"
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36"
REF="https://www.gobeyondchallenge.com/"

downloaded=0
skipped=0
failed=0

fetch() {
  local url="$1"
  local out="$IMG_DIR/$2"
  if [ -f "$out" ]; then
    echo "  ✓ Already exists: $2"
    ((skipped++)) || true
    return
  fi
  echo "  ↓ Downloading: $2"
  if curl -s -L --max-time 30 \
       -H "User-Agent: $UA" \
       -H "Referer: $REF" \
       -H "Accept: image/avif,image/webp,image/apng,image/*,*/*;q=0.8" \
       -o "$out" "$url"; then
    local size
    size=$(wc -c < "$out")
    if [ "$size" -gt 100 ]; then
      echo "    ✓ Saved ($size bytes)"
      ((downloaded++)) || true
    else
      echo "    ✗ File too small, removing"
      rm -f "$out"
      ((failed++)) || true
    fi
  else
    echo "    ✗ Failed"
    ((failed++)) || true
  fi
}

echo "============================================"
echo " Go Beyond Challenge — Asset Downloader"
echo "============================================"
echo "Saving to: $IMG_DIR"
echo ""

echo "--- Logos & Branding ---"
fetch "$BASE/2020/11/REWORKED-LOGO-2020-11-13.png"           "REWORKED-LOGO-2020-11-13.png"
fetch "$BASE/2020/11/LOGO-WHITE-TRANSPARENT-2.png"            "LOGO-WHITE-TRANSPARENT-2.png"
fetch "$BASE/2020/11/REWORKED-2020-11-13-transparent-01-1-300x96.png" "REWORKED-2020-11-13-transparent-01-1-300x96.png"
fetch "$BASE/2020/11/facebook-e1606494101989.png"             "facebook-e1606494101989.png"

echo ""
echo "--- Event Thumbnails (345×198) ---"
fetch "$BASE/2020/11/dirtrun-01-345x198.png"                  "dirtrun-01-345x198.png"
fetch "$BASE/2020/11/rosep1-01-345x198.png"                   "rosep1-01-345x198.png"
fetch "$BASE/2020/11/shires-01-1-345x198.png"                 "shires-01-1-345x198.png"
fetch "$BASE/2021/02/cyclosportive-345x198.jpg"               "cyclosportive-345x198.jpg"
fetch "$BASE/2020/12/bedfordthumb-01-345x198.png"             "bedfordthumb-01-345x198.png"
fetch "$BASE/2023/10/beatthesunset-345x198.jpg"               "beatthesunset-345x198.jpg"
fetch "$BASE/2023/10/half24-345x198.jpg"                      "half24-345x198.jpg"
fetch "$BASE/2023/11/tt2023-0215-345x198.jpg"                 "tt2023-0215-345x198.jpg"
fetch "$BASE/2025/11/IMG_5992-345x198.jpeg"                   "IMG_5992-345x198.jpeg"

echo ""
echo "--- Hero & Feature Images ---"
fetch "$BASE/2022/03/p1montage2022low.jpg"                    "p1montage2022low.jpg"
fetch "$BASE/2020/11/countrytocapital-01.png"                 "countrytocapital-01.png"
fetch "$BASE/2019/11/h1-contact-01.png"                       "h1-contact-01.png"
fetch "$BASE/2022/07/marshalteam.jpg"                         "marshalteam.jpg"
fetch "$BASE/2020/11/montage.png"                             "montage.png"
fetch "$BASE/2020/11/videograb2-01.png"                       "videograb2-01.png"

echo ""
echo "--- Badges & Partners ---"
fetch "$BASE/2022/07/Bronze-banner-300x90.jpg"                "Bronze-banner-300x90.jpg"
fetch "$BASE/2022/02/Veteran-Owned-Logo-300x149.jpeg"         "Veteran-Owned-Logo-300x149.jpeg"
fetch "$BASE/2022/11/sheraces-1024x1024.png"                  "sheraces-1024x1024.png"
fetch "$BASE/2022/06/Jogon-logo-3-300x92.webp"                "Jogon-logo-3-300x92.webp"
fetch "$BASE/2024/11/national-Trust.png"                      "national-Trust.png"
fetch "$BASE/2024/11/forestry-england-logo_square.jpg"        "forestry-england-logo_square.jpg"
fetch "$BASE/2023/02/Bog-Dog-Running-Gear-1400x483.jpeg"      "Bog-Dog-Running-Gear-1400x483.jpeg"

echo ""
echo "============================================"
echo " Done!"
echo "  Downloaded : $downloaded"
echo "  Skipped    : $skipped (already existed)"
echo "  Failed     : $failed"
echo "============================================"
echo ""
echo "Next steps:"
echo "  git add img/"
echo "  git commit -m 'Add image assets'"
echo "  git push"
