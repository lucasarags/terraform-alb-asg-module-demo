package test

import (
	"testing"

	"github.azc.ext.hp.com/runway/terratest-lib/v3/pkg/commons"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func createPrimeRole(t *testing.T) {
	t.Parallel()

	roleName := commons.GenerateUniqueName()
	variablePrefix := commons.GenerateUniqueName()
	codewayProject := "RunWay"

	terraformOptions := &terraform.Options{
		TerraformDir: test_structure.CopyTerraformFolderToTemp(t, "../", "examples/create-prime-role"),

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"role_name":       roleName,
			"codeway_project": codewayProject,
			"variable_prefix": variablePrefix,
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Check output variables are properly defined
	newRoleName := terraform.Output(t, terraformOptions, "role_name")
	newRoleArn := terraform.Output(t, terraformOptions, "role_arn")
	newRoleId := terraform.Output(t, terraformOptions, "role_id")

	assert.Equal(t, roleName, newRoleName, "Invalid role name created")
	assert.Regexp(t, "arn:aws:iam::\\d{12}:role\\/.*", newRoleArn, "Fail to create role_arn")
	assert.NotEmpty(t, newRoleId, "Fail to create role_id")
}
