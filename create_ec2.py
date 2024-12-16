import boto3


def create_security_group():
    ec2_client = boto3.client("ec2", region_name="us-west-1")

    try:
        # Create a security group
        response = ec2_client.create_security_group(
            Description="Security group for FastAPI server",
            GroupName="fastapi-security-group",
        )

        security_group_id = response["GroupId"]
        print(f"Security Group Created: {security_group_id}")

        # Set inbound rules to allow HTTP (80) and SSH (22)
        ec2_client.authorize_security_group_ingress(
            GroupId=security_group_id,
            IpPermissions=[
                {
                    "IpProtocol": "tcp",
                    "FromPort": 22,
                    "ToPort": 22,
                    "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "Allow SSH"}],
                },
                {
                    "IpProtocol": "tcp",
                    "FromPort": 80,
                    "ToPort": 80,
                    "IpRanges": [{"CidrIp": "0.0.0.0/0", "Description": "Allow HTTP"}],
                },
            ],
        )
        print("Inbound rules set: SSH (22) and HTTP (80)")

        return security_group_id

    except Exception as e:
        print(f"Error creating security group: {e}")
        return None


def create_instance(security_group_id):
    ec2_client = boto3.client("ec2", region_name="us-west-1")

    try:
        # Launch an EC2 instance
        instances = ec2_client.run_instances(
            ImageId="ami-02141377eee7defb9",  # Amazon Linux 2 AMI (replace with your desired AMI)
            MinCount=1,
            MaxCount=1,
            InstanceType="t2.micro",  # Instance type
            KeyName="ec2-user",  # Replace with your key pair name
            SecurityGroupIds=[security_group_id],
            TagSpecifications=[
                {
                    "ResourceType": "instance",
                    "Tags": [{"Key": "Name", "Value": "FastAPI-Server"}],
                }
            ],
        )

        # Retrieve instance information
        instance_id = instances["Instances"][0]["InstanceId"]
        print(f"EC2 Instance Created: {instance_id}")

        # Wait for the instance to be running
        waiter = ec2_client.get_waiter("instance_running")
        waiter.wait(InstanceIds=[instance_id])
        print(f"EC2 Instance {instance_id} is now running.")

        # Get public IP
        instance_description = ec2_client.describe_instances(InstanceIds=[instance_id])
        public_ip = instance_description["Reservations"][0]["Instances"][0][
            "PublicIpAddress"
        ]
        print(f"Instance Public IP: {public_ip}")

        return instance_id, public_ip

    except Exception as e:
        print(f"Error creating instance: {e}")
        return None, None


if __name__ == "__main__":
    sg_id = create_security_group()
    if sg_id:
        create_instance(sg_id)
