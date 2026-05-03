#!/bin/sh

# Log file
LOG_FILE="binary_test.log"
> "$LOG_FILE"  # Clear the log file

# Test folder
BIN_DIR="/opt/bin"
if [ ! -d "$BIN_DIR" ]; then
    echo "ERROR: $BIN_DIR directory not found" | tee "$LOG_FILE"
    exit 1
fi

# Initialize varibles
PASS_COUNT=0
FAIL_COUNT=0

# Loop all binaries in folder
for binary in "$BIN_DIR"/*; do
    [ -e "$binary" ] || continue  # Skip if no files found
    filename=$(basename "$binary")

    # Test if binary is executable
    if [ ! -x "$binary" ]; then
        echo "FAIL: $filename is not executable" | tee -a "$LOG_FILE"
        FAIL_COUNT=$((FAIL_COUNT + 1))
        continue
    fi

    # Special handling for shell binaries
    if echo "$filename" | grep -q '^sh-\|^sh_'; then
        OUTPUT=$(echo "exit" | "$BIN_DIR/$filename" 2>&1)
        STATUS=$?
        if [ $STATUS -eq 0 ] || [ $STATUS -eq 127 ]; then
            echo "PASS: $filename (shell test)" | tee -a "$LOG_FILE"
            PASS_COUNT=$((PASS_COUNT + 1))
        else
            echo "FAIL: $filename - $OUTPUT" | tee -a "$LOG_FILE"
            FAIL_COUNT=$((FAIL_COUNT + 1))
        fi
        continue
    fi

    # Try different version flags
    for flag in --version -V -v -h --help; do
        OUTPUT=$("$BIN_DIR/$filename" "$flag" 2>&1)
        STATUS=$?
        if [ $STATUS -eq 0 ]; then
            echo "PASS: $filename" | tee -a "$LOG_FILE"
            PASS_COUNT=$((PASS_COUNT + 1))
            break
        fi
    done

    # If all flags failed, mark as failed
    if [ $STATUS -ne 0 ]; then
        echo "FAIL: $filename - $OUTPUT" | tee -a "$LOG_FILE"
        FAIL_COUNT=$((FAIL_COUNT + 1))
    fi
done

# Print a simple summary
echo "" | tee -a "$LOG_FILE"
echo "Summary: $PASS_COUNT passed, $FAIL_COUNT failed" | tee -a "$LOG_FILE"

