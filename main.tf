module "ec2"{
    source = "./ec2"
    pub_cidr_block = var.pub_cidr_block
    ami = var.ami
    instance_type = var.instance_type
    subnet_pub_id = module.vpc.pubsubnet
    ec2_sec_gp = module.secgp.ec2_sec_gp
    subnet_id = module.vpc.pubsubnet
    web_sec_gp_name = var.web_sec_gp_name
    ec2_sec_gp_name = var.ec2_sec_gp_name
}

module "secgp"{
    source = "./secgp"
    vpc_id = module.vpc.vpcid
    web_sec_gp_name = var.web_sec_gp_name
    ec2_sec_gp_name = var.ec2_sec_gp_name
    ssh_port = var.ssh_port
    http_port = var.http_port
    db_sec_gp_name = var.db_sec_gp_name

}

module "rds"{
    source = "./rds"
    allocated_storage = var.allocated_storage
    db_name = var.db_name
    engine  = var.engine
    engine_version = var.engine_version
    instance_class = var.instance_class
    username = var.username
    password = var.password
    subnet_ids = module.vpc.prvsubnet
    vpc_db_security_group_ids = [module.secgp.db_sec_gp]
}

module "vpc"{
    source = "./vpc"
    cidr_block = var.cidr_block
    vpc_name = var.vpc_name
    pub_cidr_block = var.pub_cidr_block
    pub_availability_zone = var.pub_availability_zone
    prv_availability_zone = var.prv_availability_zone
    igw_name = var.igw_name
    prv_cidr_block = var.prv_cidr_block
}
