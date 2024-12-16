output "public_ip" {
  value = aws_instance.myEc2-instance.public_ip
}
output "id" {
  value = aws_instance.myEc2-instance.id
}
