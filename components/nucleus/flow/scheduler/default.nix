{ component, contracts }:

component {
  src = ./.;
  contracts = with contracts; [ fbp_graph path generic_text fbp_action ];
  depsSha256 = "0sakyczg4yc99q2f3vpwcyp4hh4dd86rx5x9drkzr1jz5izxfzyi";
}
