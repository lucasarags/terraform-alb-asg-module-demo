package test

import (
	"os"
	"testing"

	"github.azc.ext.hp.com/runway/terratest-lib/v3/pkg/commons"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func createServiceLinkedRole(t *testing.T) {
	t.Parallel()
	commons.CheckRequiredVariables(t, []string{
		"TF_VAR_region",
	})

	awsRegion := os.Getenv("TF_VAR_region")
    customSuffix := commons.GenerateUniqueName()

	terraformOptions := &terraform.Options{
		TerraformDir: test_structure.CopyTerraformFolderToTemp(t, "../", "examples/create-service-linked-role"),

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"custom_suffix":    customSuffix,
			"region":           awsRegion,
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Check output variables are properly defined
	//newRoleArn := terraform.Output(t, terraformOptions, "role_arn")
	newRoleId := terraform.Output(t, terraformOptions, "role_id")

	//assert.Regexp(t, "arn:aws:iam::\\d{12}:role\\/.*", newRoleArn, "Fail to create role_arn")
	assert.NotEmpty(t, newRoleId, "Fail to create role_id")
}
