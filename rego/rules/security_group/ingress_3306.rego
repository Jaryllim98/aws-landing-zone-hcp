package rules.tf_aws_securty_group_ingress_3306
import data.aws.security_groups.library
import data.fugue

__rego__metadoc__ := {
  "custom": {
		"controls": {
			"COBIT_DETAILS": [
	          "DSS05.02.6",
            "DSS05.03.5"
	        ],
	        "COBIT_IMPLEMENTATION": [
	          "DSS05.02.6",
            "DSS05.03.5"
	        ],
	        "COBIT_DEFINITION": [
	          "DSS05.02.2",
            "DSS05.02.3"
	        ],
    },
		"severity": "High",
	},
  "description": "VPC security group rules should not permit ingress from '0.0.0.0/0' to TCP/UDP port 3306 (MySQL). Removing unfettered connectivity to MySQL ports reduces a server's exposure to risk.",
  "id": "FR50,FR51",
  "title": "VPC security group rules should not permit ingress from '0.0.0.0/0' to TCP/UDP port 3306 (MySQL)"
}

security_groups = fugue.resources("aws_security_group")

resource_type := "MULTIPLE"

policy[j] {
  sg = security_groups[global_sg_id]
  msg = library.deny_security_group_ingress_zero_cidr_to_port_lb(global_sg_id, sg, 3306)
  j = fugue.deny_resource_with_message(sg, msg)
} {
  sg = security_groups[global_sg_id]
  not library.deny_security_group_ingress_zero_cidr_to_port_lb(global_sg_id, sg, 3306)
  j = fugue.allow_resource(sg)
}