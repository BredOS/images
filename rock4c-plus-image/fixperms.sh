#! /usr/bin/env bash

declare -A file_permissions=()
file_permissions=(
  ["/etc/"]="0:0:755"
  ["/usr/bin/resizefs"]="0:0:755"
  ["/usr/bin/zswap-arm-ctrl"]="0:0:755"
  ["/usr/bin/oemcleanup"]="0:0:755"
  ["/usr/bin/remove-calamares"]="0:0:755"
  ["/usr/lib"]="0:0:755"
  ["/usr"]="0:0:755"
  ["/home/bred/"]="1001:1001:750"
)
#template dir is passed as an arg converted from a relative path to an absolute path
template_dir=$(readlink -f "$1")

if [[ -d "$template_dir" ]]; then
    # Set ownership and mode for files and directories
    for filename in "${!file_permissions[@]}"; do
        IFS=':' read -ra permissions <<< "${file_permissions["${filename}"]}"
        # Prevent file path traversal outside of $template_dir
        if [[ "$(realpath -q -- "${template_dir}${filename}")" != "${template_dir}"* ]]; then
            echo "Failed to set permissions on '${template_dir}${filename}'. Outside of valid path." 1
        # Warn if the file does not exist
        elif [[ ! -e "${template_dir}${filename}" ]]; then
            echo "Cannot change permissions of '${template_dir}${filename}'. The file or directory does not exist."
        else
            if [[ "${filename: -1}" == "/" ]]; then
                chown -Rh -- "${permissions[0]}:${permissions[1]}" "${template_dir}${filename}"
                echo "Set ownership of '${template_dir}${filename}' to '${permissions[0]}:${permissions[1]}'."
                chmod -- "${permissions[2]}" "${template_dir}${filename}"
                # find "${template_dir}${filename}" -type d -exec chmod "${permissions[2]}" {} \;
            else
                chown -hv -- "${permissions[0]}:${permissions[1]}" "${template_dir}${filename}"
                chmod -- "${permissions[2]}" "${template_dir}${filename}"
            fi
        fi
    done
    echo "Done!"
fi
