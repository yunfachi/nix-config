# TO<!-- it is necessary that this file is not in the search for "TODO" -->DO

## Hosts

- [ ] Rework, or rather divide most of hardware.nix into modules
- [x] Create a shared.nix in each host that will always be imported
- [ ] Own `secrets.yaml` in each host
- [ ] Make the option `hosts.<name>`, which will store each host, and will be visible to all hosts. In this case, all hosts can be imported at once, and then do something like this: `_: {config=config.hosts.<name>;}`

## Lib


## Options

- [ ] Create terminal.nix with a universal terminal configuration and an execution command
- [x] Add archisteamfarm with configuration

## Modules


## Flake
- [ ] Divide outputs in flake into a separate `outputs` directory

## Structure


## Misc

- [x] Create a GitHub Workflow for flake check
- [x] Rename this branch to master and rename other branches with suitable names
- [ ] Write in README a lot of fluff :D
