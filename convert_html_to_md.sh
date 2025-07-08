#!/bin/bash

# Configuration
INPUT_DIR="scraped_html"
OUTPUT_DIR="scraped_md"
CONVERTER="/home/spiffytech/bin/html2markdown"

# Initialize counters
TOTAL_FILES=0
SUCCESS_COUNT=0
FAIL_COUNT=0

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Find and process HTML files
echo "Starting HTML to Markdown conversion..."
while IFS= read -r -d $'\0' html_file; do
    ((TOTAL_FILES++))
    
    # Get filename without path or extension
    filename=$(basename "$html_file" .html)
    output_file="$OUTPUT_DIR/${filename}.md"
    
    echo -n "Processing $filename.html..."
    
    # Run conversion using standard input/output piping
    if cat "$html_file" | "$CONVERTER" > "$output_file" 2>>conversion_errors.log; then
        ((SUCCESS_COUNT++))
        echo "✅ Success"
    else
        ((FAIL_COUNT++))
        echo "❌ Failed (check conversion_errors.log)"
        rm -f "$output_file"
    fi
done < <(find "$INPUT_DIR" -type f -name "*.html" -print0)

# Print summary
echo ""
echo "Conversion complete!"
echo "===================="
echo "Total files processed: $TOTAL_FILES"
echo "Successful conversions: $SUCCESS_COUNT"
echo "Failed conversions: $FAIL_COUNT"