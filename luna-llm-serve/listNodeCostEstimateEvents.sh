for POD_NAME in $(kubectl get pods --all-namespaces -o jsonpath='{range .items[?(@.spec.schedulingGates[0].name == "nodecostestimate")]}{.metadata.name}{"\n"}{end}'); do
  echo -e "\nNode cost estimate event for $POD_NAME:"; \
  kubectl get events --field-selector involvedObject.name="$POD_NAME",reason=NodeCostEstimate -o jsonpath='{range .items[*]}{.message}{"\n"}{end}'
 done
