region = "eu-west-1"
ami = "ami-0776c814353b4814d"
instance_type = "t2.micro"
my_ip = "91.130.2.122"

instance_name = "fastapi_app"

SSH_PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDWDb6Tgpol1VhgFHVnzAHXhat23uGHucweYNlyQNfAMnM2y8QicUf1JNCyVWoiHXe/fJ56jXcO4If9qcUKCg49gFGmZwGuESmcdvtZRGLL4ADPoQsIQ9afBiDtdI5SqKuxUdhiJI07KnK5FbOw3XuoUW7QN6SvM/SO8AyudDxW0QKOht18zmnWoq/6MjVdJCQSXepcuOEkW3xN3PLjnWs4dXhpyok8yj7Gzt9evyW0fdEvpTAa/l/zpXSBKliQmdiuA0M9uprSbIe85S02DUeDRWHNVaG728KbcG9AQ4AGyf3dFf5pDkYW8e9572GefPEMdQ+d9aUHnYUT1ZyS73XOkKhABI1kVh0LjfDpEkLVjjoRWpBHcsf90AiONzSNxieLNlmiU4iTaKYMS43mTEm9JC5W/5Lemfgypn2/gFFEWQ3sp4zkBCIErB0hdjISNewdq7MY8vk27Tk8NhBzjRHaBLB7pgr1qL1huJwgON720I68bO9dcqf5cb9JB+Fnr8dnYIN3QBgCKEn8vkkq7Y06u+740XVdJorWoDm1bK1E3ALUujGv3X+1hJSsd8kSksrnIuj30WXkt6RjhLGvun3Rpc7k9G6rdO5xF1Z95qQhhYQ7bJnww1eqZ+w9dZnmAuIY8qkHHhqinnSNKM6rPOQ7MqbppewkrWF8+uxkjj5ulw== j.agboola@f5.com"

#clone
#replace allowed with public_ip
#install docker compose :- docker-compose up -d -y
#ssh -i ~/.ssh/my_key.pem ubuntu@ec2-3-254-153-23.eu-west-1.compute.amazonaws.com