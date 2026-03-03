#!/bin/bash

# Get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

# Get local IP for mobile access
IP=$(ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null || echo "localhost")

echo "============================================"
echo "  Lock Combo Scanner"
echo "============================================"
echo ""
echo "Starting server..."
echo ""
echo "Open in browser:"
echo "  Local:   http://localhost:8080"
echo "  Mobile:  http://$IP:8080"
echo ""
echo "Press Ctrl+C to stop"
echo "============================================"
echo ""

# Start Python server
python3 -m http.server 8080
