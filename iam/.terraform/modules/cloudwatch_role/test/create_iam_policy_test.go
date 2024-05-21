package test

import (
	"os"
	"testing"

	"github.azc.ext.hp.com/runway/terratest-lib/v3/pkg/commons"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func createIamPolicy(t *testing.T) {
	t.Parallel()
	commons.CheckRequiredVariables(t, []string{
		"TF_VAR_region",
	})

	policyName := commons.GenerateUniqueName()
	awsRegion := os.Getenv("TF_VAR_region")

	terraformOptions := &terraform.Options{
		TerraformDir: test_structure.CopyTerraformFolderToTemp(t, "../", "examples/create-iam-policy"),

		// Variables to pass to our Terraform code using -var options
		Vars: map[string]interface{}{
			"policy_name": policyName,
			"region":      awsRegion,
		},

		// Disable colors in Terraform commands so its easier to parse stdout/stderr
		NoColor: true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Check output variables are properly defined
	newPolicyName := terraform.Output(t, terraformOptions, "policy_name")
	newPolicyArn := terraform.Output(t, terraformOptions, "policy_arn")
	newPolicyId := terraform.Output(t, terraformOptions, "policy_id")

	assert.Equal(t, policyName, newPolicyName, "Invalid policy name created")
	assert.Regexp(t, "arn:aws:iam::\\d{12}:policy\\/.*", newPolicyArn, "Fail to create policy_arn")
	assert.NotEmpty(t, newPolicyId, "Fail to creat policy_id")
}
