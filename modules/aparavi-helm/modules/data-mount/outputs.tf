output "pvc_names" {
  description = "List of PVC names"
  value = concat(

    values(
      kubernetes_persistent_volume_claim.nfs
    )[*].metadata[0].name,

    values(
      kubernetes_persistent_volume_claim.smb
    )[*].metadata[0].name,

    values(
      kubernetes_persistent_volume_claim.ebs
    )[*].metadata[0].name,

    values(
      kubernetes_persistent_volume_claim.gce
    )[*].metadata[0].name,

    values(
      kubernetes_persistent_volume_claim.azure
    )[*].metadata[0].name

  )
}
