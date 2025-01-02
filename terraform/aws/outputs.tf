output "jenkins-ec2-public-ip" {
  value = module.jenkins-ec2.public_ip
}

output "eks-name" {
  value = module.eks.cluster_name
}