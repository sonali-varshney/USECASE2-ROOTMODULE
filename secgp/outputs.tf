output "ec2_sec_gp"{
value = aws_security_group.web_sg.id
}

output "db_sec_gp"{
value = aws_security_group.db_sec_gp.id
}