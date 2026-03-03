# Lock Combo Scanner

A mobile web app that scans lock combination cards and sends the data directly to Google Sheets.

## Features

- Camera capture on mobile devices
- OCR scanning using Tesseract.js (runs locally, no API costs)
- Extracts combination (1 => XX, 2 => XX, 3 => XX format) and serial numbers
- Sends directly to Google Sheets
- Works offline for scanning (only needs internet for Google Sheets)

## Quick Start (Local Testing)

1. Open a terminal in this folder
2. Start a local server:
   ```bash
   # Using Python 3
   python3 -m http.server 8080

   # Or using Node.js
   npx serve -p 8080
   ```
3. Open `http://localhost:8080` on your phone (same WiFi network)
   - Find your computer's IP: `ipconfig` (Windows) or `ifconfig` (Mac/Linux)
   - Example: `http://192.168.1.100:8080`

## Google Sheets Setup (Required for saving data)

### Step 1: Create a Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or select existing)
3. Name it something like "Lock Scanner"

### Step 2: Enable the Google Sheets API

1. In your project, go to **APIs & Services** > **Library**
2. Search for "Google Sheets API"
3. Click **Enable**

### Step 3: Create OAuth Credentials

1. Go to **APIs & Services** > **Credentials**
2. Click **Create Credentials** > **OAuth client ID**
3. If prompted, configure the OAuth consent screen:
   - User Type: External
   - App name: Lock Scanner
   - Support email: your email
   - Developer email: your email
   - Click **Save and Continue** through the rest
4. Back in Credentials, create OAuth client ID:
   - Application type: **Web application**
   - Name: Lock Scanner Web
   - Authorized JavaScript origins:
     - `http://localhost:8080` (for testing)
     - Your deployed URL (if hosting somewhere)
   - Click **Create**
5. Copy the **Client ID** (looks like `xxxxx.apps.googleusercontent.com`)

### Step 4: Add Your Client ID

1. Open `index.html`
2. Find this line near the top of the `<script>` section:
   ```javascript
   const GOOGLE_CLIENT_ID = 'YOUR_CLIENT_ID_HERE.apps.googleusercontent.com';
   ```
3. Replace with your actual Client ID

### Step 5: Create Your Google Sheet

1. Create a new Google Sheet
2. Add headers in row 1: `Timestamp | Combination | Serial`
3. Copy the sheet URL

## Usage

1. Open the app on your phone
2. Point camera at the lock combination card
3. Tap **Capture Photo**
4. Tap **Scan Numbers** - the app will extract:
   - Combination from "1 => XX, 2 => XX, 3 => XX" pattern
   - Serial number (the 8-digit number in the rectangle)
5. Review/edit the extracted numbers if needed
6. Sign in with Google (first time only)
7. Paste your Google Sheet URL
8. Tap **Send to Sheet**

## Hosting Options

For HTTPS (required for camera on mobile):

### Option 1: GitHub Pages (Free)
1. Create a GitHub repo
2. Push this folder
3. Enable GitHub Pages in repo settings
4. Add the GitHub Pages URL to your OAuth authorized origins

### Option 2: Netlify (Free)
1. Drag the folder to [Netlify Drop](https://app.netlify.com/drop)
2. Add the Netlify URL to your OAuth authorized origins

### Option 3: Vercel (Free)
1. Install Vercel CLI: `npm i -g vercel`
2. Run `vercel` in this folder
3. Add the Vercel URL to your OAuth authorized origins

## Troubleshooting

### Camera not working
- Make sure you're using HTTPS (required for camera access)
- Check browser permissions for camera

### OCR not finding numbers
- Ensure good lighting
- Hold camera steady
- Make sure the card fills most of the frame
- Numbers should be in focus

### Can't send to Google Sheets
- Check that you're signed in
- Verify you have edit access to the sheet
- Make sure the sheet URL is correct

## Technical Notes

- Uses Tesseract.js v5 for OCR (loaded from CDN)
- Uses Google Identity Services for OAuth
- All processing happens in the browser
- History stored in localStorage (last 10 scans)
