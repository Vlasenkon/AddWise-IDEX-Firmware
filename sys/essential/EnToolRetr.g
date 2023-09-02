echo >"essential/autogen/printretract.g" "; ToolChange Retraction Enabled"
echo >>"essential/autogen/printretract.g" "M83"

echo >>"essential/autogen/printretract.g" "if exists(param.R) && heat.heaters[state.currentTool].current > heat.coldRetractTemperature"
echo >>"essential/autogen/printretract.g" "  M116 P{state.currentTool} S20"
echo >>"essential/autogen/printretract.g" "  G1 E-1 F3000"

echo >>"essential/autogen/printretract.g" "elif exists(param.E) && heat.heaters[state.currentTool].current > heat.coldExtrudeTemperature"
echo >>"essential/autogen/printretract.g" "  M116 P{state.currentTool} S10"
echo >>"essential/autogen/printretract.g" "  G1 E30 F600"