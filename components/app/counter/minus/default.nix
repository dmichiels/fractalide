{ component, contracts }:

component {
  src = ./.;
  contracts = with contracts; [ app_counter ];
  depsSha256 = "0yav2znjhqlqh6f17jn8sjdk7sf7wxjm5y6df8nxmgiv14x5ln1f";
}
