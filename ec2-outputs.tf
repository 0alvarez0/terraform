output "ec2pubip" {
  value = aws_instance.myinstance.public_ip
}

output "ec2id" {
  value = aws_instance.myinstance.id
}

output "pubdns" {
  value = aws_instance.myinstance.public_dns
}

output "ec2tags" {
  value = aws_instance.myinstance.tags
}