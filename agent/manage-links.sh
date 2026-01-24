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
    "agent:.codex"
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
    # Add base depth (stow/tool/config) = 3 levels usually?
    # Actually, let's just use absolute path? No, stow prefers relative.
    # The script used `../../../agent/$resource`.
    # default: stow/tool/config/link -> ../../../agent/resource
    # If config is .gemini/antigravity (2 levels), we need ../../../../agent
    
    # Construct relative path dynamically
    local back_path=""
    # We are in stow/$tool/$config_path
    # We need to go up: (depth + 1 (config base) + 2 (stow/tool)) ?
    # Let's count path segments. 
    # $tool is 1 dir.
    # $config_path can be "foo" (1) or "foo/bar" (2).
    # We are in $DOTFILES_ROOT/stow/$tool/$config_path
    # We want to reach $DOTFILES_ROOT/agent/$source_res
    
    # Simple method: use `realpath --relative-to` if available (Linux/Coreutils). 
    # macOS might not have it by default. 
    # Fallback: Count "/" in "$tool/$config_path" and add one more "..".
    
    local full_target_path="$target_dir"
    local full_source_path="$AGENT_DIR/$source_res"
    
    # Use python for reliable relative path generation on macOS/Linux
    local rel_link
    rel_link=$(python3 -c "import os.path; print(os.path.relpath('$full_source_path', '$full_target_path'))")
    
    echo "   � Linking $target_name -> $rel_link"
    
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
