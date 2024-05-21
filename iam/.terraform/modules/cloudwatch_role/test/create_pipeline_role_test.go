package test

import (
	"testing"

	"github.azc.ext.hp.com/runway/terratest-lib/v3/pkg/commons"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func createPipelineRole(t *testing.T) {
	t.Parallel()

	roleName := commons.GenerateUniqueName()
	variableGroupName1 := commons.GenerateUniqueName()
	variableGroupName2 := commons.GenerateUniqueName()
	codeway_projects_r1 := make([]map[string]string, 0)
	codeway_projects_r2 := make([]map[string]string, 0)
	codeway_projects_r1 = append(codeway_projects_r1, map[string]string{"name": "RunWay", "variable_group": variableGroupName1, "variable_prefix": "terratest-1"})
	codeway_projects_r2 = append(codeway_projects_r2, map[string]string{"name": "RunWay", "variable_group": variableGroupName2, "variable_prefix": "terratest-2"})

	terraformOptions := &terraform.Options{
		TerraformDir: test_structure.CopyTerraformFolderToTemp(t, "../", "examples/create-pipeline-role"),

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"role_name":         roleName,
			"codeway_projects1": codeway_projects_r1,
			"codeway_projects2": codeway_projects_r2,
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
