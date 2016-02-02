docker-machine create --driver amazonec2 \
    --amazonec2-access-key $AWS_ACCESS_KEY_ID \
    --amazonec2-secret-key $AWS_SECRET_ACCESS_KEY \
    --amazonec2-vpc-id $VPC_ID \
    --amazonec2-ami ami-2fb59945 \
    --amazonec2-instance-type m4.xlarge \
    --amazonec2-request-spot-instance \
    --amazonec2-spot-price 0.10 \
    --amazonec2-ssh-user ubuntu \
    --amazonec2-security-group docker-book \
    aws01

