#!/usr/bin/env bash
set -e

# Usage: ./manage-links.sh
# 
# This script manages the symbolic links for shared agent resources (skills, workflows, etc.)
# It links directories from ~/dotfiles/agent/ into the stow packages for various AI tools.

# Get the absolute path of the directory containing this script (should be ~/dotfiles/agent)
AGENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_ROOT="$(dirname "$AGENT_DIR")"
STOW_DIR="$DOTFILES_ROOT/stow"

# Configuration
# -----------------------------------------------------------------------------

# Standard Mappings
# Format: "stow_package:relative_config_path"
# These will link ALL found resources into the target directory.
STANDARD_TARGETS=(
    "agent:.agent"
    "agent:.codex"
    "agent:.gemini"
    "agent:.claude"
)

# Custom Mappings (Specific Resource Rename)
# Format: "stow_package:relative_config_path:source_resource_name:target_link_name"
CUSTOM_MAPPINGS=(
    "agent:.gemini/antigravity:skills:global_skills"
)

echo "🔍 Scanning for resources in $AGENT_DIR..."

# Find all subdirectories in the agent folder to link (excluding hidden ones)
RESOURCES=()
for dir in "$AGENT_DIR"/*/; do
    dir=${dir%*/}      # remove trailing slash
    basename="${dir##*/}" # get dirname
    if [[ "$basename" != ".*" && -d "$dir" ]]; then
        RESOURCES+=("$basename")
    fi
done

if [ ${#RESOURCES[@]} -eq 0 ]; then
    echo "⚠️  No resources found to link."
    exit 0
fi

echo "📦 Found resources: ${RESOURCES[*]}"

# Mark directories we have touched so we can clean up others if needed (optional advanced feature)
# For now, we clean up orphans within the target directories we processing.
# But user asked to remove a link like ".claude" if removed from the list.
# To do that, we should iterate over ALL directories in stow/agent/.xxx and check if they are in our config list.

# Defined config paths (standard + custom)
DECLARED_CONFIG_PATHS=()
for item in "${STANDARD_TARGETS[@]}"; do
    DECLARED_CONFIG_PATHS+=("${item#*:}")
done
for item in "${CUSTOM_MAPPINGS[@]}"; do
    IFS=':' read -r tool config_dir _ _ <<< "$item"
    DECLARED_CONFIG_PATHS+=("$config_dir")
done

# Unique paths (compatible with bash < 4)
eval "DECLARED_CONFIG_PATHS=($(printf "%q\n" "${DECLARED_CONFIG_PATHS[@]}" | sort -u))"

echo "🧹 Checking for orphaned config directories in stow/agent/..."
# Assuming all we manage is under stow/agent/ (as configured in the arrays)
# Iterate stow/agent/* and stow/agent/.*
for path in "$STOW_DIR/agent"/* "$STOW_DIR/agent"/.*; do
    [ -e "$path" ] || continue
    fname=$(basename "$path")
    # Skip . and ..
    [[ "$fname" == "." || "$fname" == ".." ]] && continue
    
    # Check if this directory is in our declared list
    # The declared path might be nested e.g. .gemini/antigravity.
    # We only check top-level for now or precise match?
    # Actually, simpler: check if "$fname" (e.g. .claude) matches the start of any declared path.
    
    # If the user removes "agent:.claude" from list, we want to remove "$STOW_DIR/agent/.claude".
    # Note: .agent/skills is managed. .gemini/antigravity is managed.
    
    found=0
    for declared in "${DECLARED_CONFIG_PATHS[@]}"; do
        # declared could be ".agent", ".claude", ".gemini/antigravity"
        # If fname is ".claude", it matches declared ".claude".
        # If fname is ".gemini", it matches start of ".gemini/antigravity".
        
        # Check standard root match
        root_dir=$(echo "$declared" | cut -d/ -f1)
        if [[ "$fname" == "$root_dir" ]]; then
            found=1
            break
        fi
    done
    
    if [[ $found -eq 0 ]]; then
        echo "   🗑️  Removing orphaned directory: stow/agent/$fname"
        rm -rf "$path"
    fi
done

create_link() {
    local tool="$1"
    local config_path="$2"
    local source_res="$3"
    local target_name="$4"
    
    local target_dir="$STOW_DIR/$tool/$config_path"
    local rel_path_to_agent="../../../"
    
    # Calculate how many levels up we need to go based on config_path depth
    # Count slashes in config_path
    local depth=$(grep -o "/" <<< "$config_path" | wc -l)

    local full_target_path="$target_dir"
    local full_source_path="$AGENT_DIR/$source_res"
    
    # Use python for reliable relative path generation on macOS/Linux
    local rel_link
    rel_link=$(python3 -c "import os.path; print(os.path.relpath('$full_source_path', '$full_target_path'))")
    
    # echo "   🔗 Linking $target_name -> $rel_link"
    
    mkdir -p "$target_dir"
    (
        cd "$target_dir"
        rm -rf "$target_name"
        ln -s "$rel_link" "$target_name"
    )
}

# 1. Process Standard Targets
for item in "${STANDARD_TARGETS[@]}"; do
    tool="${item%%:*}"
    config_dir="${item#*:}"
    echo "🛠️  Processing Standard: $tool ($config_dir)..."
    for res in "${RESOURCES[@]}"; do
        create_link "$tool" "$config_dir" "$res" "$res"
    done
done

# 2. Process Custom Mappings
for item in "${CUSTOM_MAPPINGS[@]}"; do
    IFS=':' read -r tool config_dir source_res target_name <<< "$item"
    echo "🛠️  Processing Custom: $tool ($config_dir) [$source_res -> $target_name]..."
    create_link "$tool" "$config_dir" "$source_res" "$target_name"
done

echo "✨ All links updated successfully!"
