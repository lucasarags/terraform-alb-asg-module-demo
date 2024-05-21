# Changelog

## 5.1

- Add support to Amazon MQ policies.

## 4.3

- Replace `source_json` with `source_policy_documents` in the runway-role module

## 4.2

- Add support for bootrapping the `prime-role` in DIME accounts.
- Ability to create an instance profile in the `iam-role` module.

## 4.1

- Add support for IRSA roles permission boundary in the `prime-role` module.

## 4.0

- Add `policy_name_prefix` parameter in the `runway-role` module to unlink the provisioning-policy `name_prefix` parameter from the `role-prefix` parameter. Breaks compatibility for users of the `runway-role` module using the `role-prefix` parameter to define the role name.

## 3.1

- Add `max_session_duration` parameter to control the maximum session duration (in seconds) to set in the IAM roles. Defaults to `3600` seconds, which is the default setting from AWS. 

## 3.0

- Breaking change for the `runway-role` module. Removed variables `attach_ecs_cluster_policy` and `attach_ecs_service_policy` and replaced with `attach_ecs_policy`. This aligns ECS with the other repositories of having a single policy. 
