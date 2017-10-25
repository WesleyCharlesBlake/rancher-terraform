#------------------------------------------#
# RDS Database Configuration
#------------------------------------------#
resource "aws_rds_cluster_instance" "rancher_ha" {
    count                = 2
    identifier           = "${var.name_prefix}-db-${count.index}"
    cluster_identifier   = "${aws_rds_cluster.rancher_ha.id}"
    instance_class       = "db.t2.medium"
    publicly_accessible  = false
    db_subnet_group_name = "${aws_db_subnet_group.rancher_ha.name}"
}

resource "aws_rds_cluster" "rancher_ha" {
    cluster_identifier     = "${var.name_prefix}-db"
    database_name          = "${var.db_name}"
    master_username        = "${var.db_user}"
    master_password        = "${var.db_pass}"
    db_subnet_group_name   = "${aws_db_subnet_group.rancher_ha.name}"
    vpc_security_group_ids = ["${aws_security_group.rancher_ha_rds.id}"]
    storage_encrypted      =  true

}

resource "aws_db_subnet_group" "rancher_ha" {
    name        = "${var.name_prefix}-db-subnet-group"
    description = "Rancher HA Subnet Group"
    subnet_ids  = ["${aws_subnet.rancher_ha.*.id}"]
    tags {
        Name = "${var.name_prefix}-db-subnet-group"
    }
}

resource "aws_security_group" "rancher_ha_rds" {
    name        = "${var.name_prefix}-rds-secgroup"
    description = "Rancher RDS Ports"
    vpc_id      = "${aws_vpc.rancher_ha.id}"

    ingress {
        from_port = 0
        to_port   = 65535
        protocol  = "tcp"
        self      = true
    }

    ingress {
        from_port = 0
        to_port   = 65535
        protocol  = "udp"
        self      = true
    }

    ingress {
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
