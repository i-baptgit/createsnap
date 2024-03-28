#!/bin/bash

# Get list of disk selfLinks
disk_selfLinks=$(gcloud compute disks list --format="csv[no-heading](selfLink)")

# Specify the existing snapshot policy name
existing_snapshot_policy="schedule-1"

# Loop through each disk selfLink
while IFS= read -r disk_selfLink; do
    # Apply existing snapshot policy to disk
    gcloud compute disks add-resource-policies $disk_selfLink \
        --resource-policies=$existing_snapshot_policy
    echo "Snapshot policy '$existing_snapshot_policy' applied to disk '$disk_selfLink'."
done <<< "$disk_selfLinks"
