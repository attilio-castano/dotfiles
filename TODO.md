# TODO

## SSH Enhancements

### SSH Agent Management
- [ ] Add `ssh_agent_setup()` function to detect and manage SSH agent status
- [ ] Show loaded keys in agent
- [ ] Auto-start agent if not running (Linux environments)
- [ ] Handle agent forwarding detection

### SSH Key Setup Refinements
- [ ] Enhance `ssh_key_setup()` to detect SSH agent forwarding
- [ ] Distinguish between local keys and forwarded keys
- [ ] Show which keys are being used for different operations
- [ ] Better feedback when keys are already in agent

### Use Cases to Address
- SSH into remote servers with agent forwarding (`ssh -A`)
- Clear indication of which keys are available (local vs forwarded)
- Seamless key management across different environments
- Better user feedback about SSH agent status

## Future Enhancements
- [ ] Add more installation scripts (homebrew, packages, fonts)
- [ ] Create bootstrap script for one-command setup
- [ ] Add bin/ directory for utility scripts
- [ ] Add docs/ directory for documentation