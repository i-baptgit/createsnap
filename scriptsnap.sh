#!/bin/bash

# Get list of disk selfLinks
disk_selfLinks=$(gcloud compute disks list --format="csv[no-heading](selfLink)")

# Specify the snapshot policy name
snapshot_policy="mg1-sbx-prj-vms-magasins-dss"

# Loop through each disk selfLink
while IFS= read -r disk_selfLink; do
    # Apply existing snapshot policy to disk
    gcloud compute disks add-resource-policies $disk_selfLink \
        --resource-policies=$snapshot_policy
    echo "Snapshot policy '$snapshot_policy' applied to disk '$disk_selfLink'."
done <<< "$disk_selfLinks"
