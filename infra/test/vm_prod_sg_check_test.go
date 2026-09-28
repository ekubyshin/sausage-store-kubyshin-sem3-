package terratest

import (
	"context"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"github.com/yandex-cloud/go-genproto/yandex/cloud/compute/v1"
	vpc "github.com/yandex-cloud/go-genproto/yandex/cloud/vpc/v1"
	ycsdk "github.com/yandex-cloud/go-sdk"
)

// Имя из infra/modules/vps/variables.tf, variable "vps_security_group_name".
const expectedSecurityGroupName = "sausage-store-security-group"

func TestProdSecurityGroup(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "..",
	}

	// Инфраструктуру создаёт job apply. Здесь только читаем её outputs.
	terraform.Init(t, terraformOptions)

	securityGroupID := terraform.Output(t, terraformOptions, "prod_security_group_id")
	securityGroupName := terraform.Output(t, terraformOptions, "prod_security_group_name")
	vmProdName := terraform.Output(t, terraformOptions, "vm_prod_name")

	require.NotEmpty(t, securityGroupID)
	assert.Equal(t, expectedSecurityGroupName, securityGroupName, "Terraform security group name does not match the name in the Terraform files")

	ctx := context.Background()
	yc, err := ycsdk.Build(ctx, ycsdk.Config{
		Credentials: getYCToken(t),
	})
	require.NoError(t, err)

	group, err := yc.VPC().SecurityGroup().Get(ctx, &vpc.GetSecurityGroupRequest{
		SecurityGroupId: securityGroupID,
	})
	require.NoError(t, err)
	assert.Equal(t, expectedSecurityGroupName, group.GetName(), "Cloud security group name does not match the name in the Terraform files")

	prodVM := findInstanceByName(t, yc, vmProdName)
	assert.True(t, instanceHasSecurityGroup(prodVM, securityGroupID), "Prod VM does not have security group %s attached", securityGroupID)
}

func findInstanceByName(t *testing.T, yc *ycsdk.SDK, name string) *compute.Instance {
	t.Helper()

	instances, err := yc.Compute().Instance().List(context.Background(), &compute.ListInstancesRequest{
		FolderId: getFolderID(t),
	})
	require.NoError(t, err)

	for _, instance := range instances.Instances {
		if instance.GetName() == name {
			return instance
		}
	}

	t.Fatalf("Prod VM %s not found in Yandex Cloud", name)
	return nil
}

func instanceHasSecurityGroup(instance *compute.Instance, securityGroupID string) bool {
	for _, nic := range instance.GetNetworkInterfaces() {
		for _, id := range nic.GetSecurityGroupIds() {
			if id == securityGroupID {
				return true
			}
		}
	}
	return false
}
