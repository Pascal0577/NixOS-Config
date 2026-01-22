#!/usr/bin/env bash

set -eu

parse_input() {
    while [ $# -gt 0 ]; do
        case "$1" in
            --steps)
                STEPS="$2"
                shift 2 ;;
            --time)
                TIME="$2"
                shift 2 ;;
            set)
                INPUT="$2"
                shift 2 ;;
            --no-save)
                NOSAVE=true
                shift ;;
            *)
                echo "Invalid input: $1" >&2
                exit 1
        esac
    done
}

set_values() {
    STEPS="${STEPS:-20}"
    TIME="${TIME:-1}"
    NOSAVE="${NOSAVE:-false}"

    if [ "${INPUT%'%'}" != "$INPUT" ]; then
        PERCENT=true
        INPUT="${INPUT%'%'}"
    fi

    TIME_STEP="$(echo "scale=3; $TIME / $STEPS" | bc)"

    BRIGHTNESS_CURRENT="$(brightnessctl g)"
    BRIGHTNESS_MAX="$(brightnessctl m)"

    if "$PERCENT"; then
        TARGET_BRIGHTNESS=$((BRIGHTNESS_MAX * INPUT / 100))
    else
        TARGET_BRIGHTNESS="$INPUT"
    fi

    DELTA="$((BRIGHTNESS_CURRENT - TARGET_BRIGHTNESS))"
    STEP="$((DELTA / STEPS))"
}

set_brightness() {
    # Save so it can be restored later if needed
    "$NOSAVE" || brightnessctl -s set "$BRIGHTNESS_CURRENT"

    for ((i=1; i<=STEPS; i++)); do
        brightnessctl set "$BRIGHTNESS_CURRENT"
        BRIGHTNESS_CURRENT="$((BRIGHTNESS_CURRENT - STEP))"
        sleep "$TIME_STEP" 
    done

    brightnessctl set "$TARGET_BRIGHTNESS"
}

checks() {
    if [ -z "$INPUT" ]; then
        echo "No input defined!" >&2
        exit 1
    fi

    if ! command -v brightnessctl >/dev/null; then
        echo "brightnessctl not installed. Please make sure it is in your PATH" >&2
        exit 1
    fi
}

main() {
    parse_input "$@"
    checks 
    set_values
    set_brightness 
}

main "$@"
