#Create Subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = var.subnet_ids #aws_subnet.prv_subnet[*].id   #Note

  tags = {
    Name = "My DB subnet group"
  }
}

#Create MYSQL DB
resource "aws_db_instance" "default" {
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine #"mysql"
  engine_version       = var.engine_version #"8.0"
  instance_class       = var.instance_class
  username             = var.username #"foo"
  password             = var.password #"foobarbaz"
  #parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  publicly_accessible  = false # Ensure RDS is not publicly accessible
  vpc_security_group_ids = var.vpc_db_security_group_ids 
}


