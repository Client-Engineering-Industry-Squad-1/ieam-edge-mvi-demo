# ieam-edge-mvi-demo

1. Create a namespace called `mvi-edge`
2. Create an image pull secret called `custom-pull-secret` authenticating to the registry with the MVI image
3. Create an image pull secret called `operator-image-registry` authenticating to the registry that will store the operator
4. Update `MODEL_DIR` variable in `deploy.sh` to full path of deploy folder
5. Update `APP_IMAGE_BASE` variable to point to the targeted MVI model in `deploy.sh`
6. Update `IMAGE_VERSION` variable to point to the image tag of the targeted MVI model in `deploy.sh`
7. Update `OPERATOR_IMAGE_BASE` to point to image registry path that is accessible to IEAM (should be same registry as step 3) in `deploy.sh`
8. Update `HZN_POLICY_NAME` in `deploy.sh` to reference your IEAM org
9. Set the variables in `env.sh`
10. Execute the `deploy.sh` script (`./deploy.sh`)