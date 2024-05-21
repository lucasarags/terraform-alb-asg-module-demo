package test

import (
	"os"
	"testing"

	"github.azc.ext.hp.com/runway/terratest-lib/v3/pkg/commons"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func createIamUser(t *testing.T) {
	t.Parallel()
	commons.CheckRequiredVariables(t, []string{
		"TF_VAR_region",
	})

	userName := commons.GenerateUniqueName()
	awsRegion := os.Getenv("TF_VAR_region")

	terraformOptions := &terraform.Options{
		TerraformDir: test_structure.CopyTerraformFolderToTemp(t, "../", "examples/create-iam-user"),

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"region":    awsRegion,
			"user_name": userName,
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Check output variables are properly defined
	newUserName := terraform.Output(t, terraformOptions, "user_name")
	newUserArn := terraform.Output(t, terraformOptions, "user_arn")

	assert.Equal(t, userName, newUserName, "Fail to get user_name")
	assert.NotEmpty(t, newUserArn, "Fail to get user_arn")
}
