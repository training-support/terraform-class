#!/usr/bin/env python

from cdktf import App, TerraformStack
from cdktf_cdktf_provider_aws.provider import AwsProvider
from cdktf_cdktf_provider_aws.s3_bucket import S3Bucket
from constructs import Construct


class MyStack(TerraformStack):
    def __init__(self, scope: Construct, id: str):
        super().__init__(scope, id)

        AwsProvider(self, "aws", region="ap-south-2")
        S3Bucket(self, "terraform-lvc-june25-test-cdk-bucket", bucket="terraform-lvc-june25-test-cdk-bucket")

app = App()
MyStack(app, "Session-8-CDK")
app.synth()
