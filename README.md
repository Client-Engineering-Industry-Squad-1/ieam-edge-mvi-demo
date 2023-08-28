# ieam-edge-mvi-demo

1. Create a namespace called `mvi-edge`
2. Create an image pull secret called `custom-pull-secret` authenticating to the registry with the MVI image
3. Create an image pull secret called `operator-image-registry` authenticating to the registry that will store the operator
4. Update `MODEL_DIR` variable in `deploy.sh` to full path of deploy folder
5. Update `HZN_POLICY_NAME` in `deploy.sh` to reference your IEAM org instead of ceorg
6. Set the variables in `env.sh`
7. Execute the `deploy.sh` script (`./deploy.sh`)